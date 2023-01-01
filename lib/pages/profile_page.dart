import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/cubit/money_cubit.dart';
import 'package:movie_app/cubit/movies_cubit.dart';
import 'package:movie_app/widgets/loading_spinner.dart';
import 'package:movie_app/widgets/profile_info.dart';

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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          const CircleAvatar(
                            backgroundImage:
                                AssetImage('./assets/img/profile.jpg'),
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
                          const SizedBox(height: 50),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Account Info',
                                style: TextStyle(
                                    color: Colors.white.withOpacity(0.95),
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700),
                              ),
                              TextButton(
                                  onPressed: () {
                                    context.goNamed('edit');
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        "Edit Profile",
                                        style: TextStyle(
                                            color:
                                                Theme.of(context).primaryColor,
                                            letterSpacing: 0.3,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500),
                                      ),
                                      const SizedBox(
                                        width: 3,
                                      ),
                                      Icon(
                                        Icons.keyboard_arrow_right_sharp,
                                        color: Theme.of(context).primaryColor,
                                        size: 22,
                                      )
                                    ],
                                  )),
                            ],
                          ),
                          const SizedBox(height: 30),
                          FutureBuilder<DocumentSnapshot>(
                              future: users.doc(user?.uid).get(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final data = snapshot.data!.data()
                                      as Map<String, dynamic>;
                                  return Column(
                                    children: [
                                      ProfileInfo(
                                          icon: Icons.person_rounded,
                                          title: 'Name',
                                          color: data['name'] == null
                                              ? Theme.of(context).primaryColor
                                              : Colors.white70,
                                          text:
                                              data['name'] ?? 'Not filled yet'),
                                      const SizedBox(height: 20),
                                      ProfileInfo(
                                          icon: Icons.email_rounded,
                                          title: 'Email',
                                          color: Colors.white70,
                                          text: data['email']),
                                      const SizedBox(height: 20),
                                      ProfileInfo(
                                          icon: Icons.phone_android_rounded,
                                          title: 'Phone Number',
                                          color: data['phone'] == null
                                              ? Theme.of(context).primaryColor
                                              : Colors.white70,
                                          text: data['phone'] ??
                                              'Not filled yet'),
                                      const SizedBox(height: 20),
                                      ProfileInfo(
                                          icon: Icons.home,
                                          title: 'Address',
                                          color: data['address'] == null
                                              ? Theme.of(context).primaryColor
                                              : Colors.white70,
                                          text: data['address'] ??
                                              'Not filled yet'),
                                      const SizedBox(height: 30),
                                    ],
                                  );
                                } else {
                                  return const LoadingSpinner();
                                }
                              })
                        ]))
              ]);
            },
          ),
        ));
  }
}
