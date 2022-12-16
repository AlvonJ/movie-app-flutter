import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/cubit/money_cubit.dart';
import 'package:movie_app/cubit/movies_cubit.dart';
import 'package:movie_app/widgets/loading_spinner.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final formatterCurrency =
      NumberFormat.currency(locale: "id_ID", symbol: "Rp ");

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');

    return Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: const Color(0xff1C1C27),
          iconSize: 28,
          selectedItemColor: Theme.of(context).primaryColor,
          unselectedItemColor: Colors.grey[600],
          currentIndex: 2,
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
          child: BlocBuilder<MoneyCubit, MoneyState>(
            builder: (context, state) {
              return ListView(children: [
                Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(children: [
                      const SizedBox(height: 30),
                      const CircleAvatar(
                        backgroundColor: Colors.grey,
                        radius: 46,
                      ),
                      const SizedBox(height: 16),
                      state.when(
                        selected: (money) {
                          return Text(
                            money != 0
                                ? formatterCurrency.format(money)
                                : 'Rp 0',
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          );
                        },
                      ),
                      const SizedBox(height: 6),
                      ElevatedButton(
                        onPressed: () {
                          context.goNamed('topup');
                        },
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 40, vertical: 12),
                        ),
                        child: const Text(
                          'Top Up',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                    ]))
              ]);
            },
          ),
        ));
  }
}
