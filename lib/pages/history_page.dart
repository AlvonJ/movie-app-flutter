import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/widgets/history_card.dart';
import 'package:movie_app/widgets/loading_spinner.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({super.key});

  final formatter = DateFormat('dd MMMM yyyy');
  final formatterCurrency =
      NumberFormat.currency(locale: "id_ID", symbol: "Rp ");

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference tickets = firestore.collection('tickets');

    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xff1C1C27),
        iconSize: 28,
        selectedItemColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.grey[600],
        currentIndex: 1,
        type: BottomNavigationBarType.fixed,
        onTap: (value) {
          switch (value) {
            case 0:
              context.goNamed('home');
              break;
            case 1:
              context.goNamed('history');
              break;
            case 2:
              context.goNamed('profile');
              break;
            case 3:
              FirebaseAuth.instance
                  .signOut()
                  .then((_) => context.goNamed('login'));
              break;
          }
        },
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.history_rounded), label: "History"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
          BottomNavigationBarItem(
              icon: Icon(Icons.logout_outlined), label: "Logout"),
        ],
      ),
      body: SafeArea(
          child: ListView(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 30),
              const Center(
                child: Text(
                  "History Tickets",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                ),
              ),
              const SizedBox(height: 50),
              FutureBuilder<QuerySnapshot>(
                future: tickets
                    .where('uid', isEqualTo: user?.uid)
                    .orderBy('date', descending: true)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                          child: Text(
                        "You have no tickets!",
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 20,
                            fontWeight: FontWeight.w600),
                      ));
                    }
                    return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: snapshot.data!.docs.map((e) {
                          final data = e.data() as Map<String, dynamic>;
                          DateTime dateTime =
                              (data['date'] as Timestamp).toDate();

                          return HistoryCard(
                            data: data,
                            formatter: formatter,
                            dateTime: dateTime,
                            formatterCurrency: formatterCurrency,
                            onTap: () {
                              context.goNamed('ticket',
                                  params: {'id': e.reference.id});
                            },
                          );
                        }).toList());
                  } else {
                    return const LoadingSpinner();
                  }
                },
              ),
            ],
          )
        ],
      )),
    );
  }
}
