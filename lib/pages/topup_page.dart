import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/cubit/money_cubit.dart';
import 'package:movie_app/cubit/movies_cubit.dart';
import 'package:movie_app/widgets/history_transaction.dart';
import 'package:movie_app/widgets/loading_spinner.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class TopupPage extends StatefulWidget {
  const TopupPage({super.key});

  @override
  State<TopupPage> createState() => _TopupPageState();
}

class _TopupPageState extends State<TopupPage> {
  final user = FirebaseAuth.instance.currentUser;

  final formatterCurrency =
      NumberFormat.currency(locale: "id_ID", symbol: "Rp ", decimalDigits: 0);
  final formatterDate = DateFormat('dd MMMM yyyy');
  final formatterTime = DateFormat('HH:mm');

  List<int> topupValue = [10000, 20000, 50000, 100000, 200000, 500000];
  int selectedTopupIndex = 0;

  @override
  Widget build(BuildContext context) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference users = firestore.collection('users');
    CollectionReference transactions = firestore.collection('transactions');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(size: 26, color: Colors.white),
        elevation: 0,
        title: const Text(
          "Top Up",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: BlocBuilder<MoneyCubit, MoneyState>(
        builder: (context, state) {
          return ListView(
            children: [
              const SizedBox(height: 20),
              Text(
                'Balance',
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Colors.white.withOpacity(0.8), fontSize: 15),
              ),
              const SizedBox(height: 5),
              state.when(
                selected: (money) {
                  return Text(
                    formatterCurrency.format(money),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w600),
                  );
                },
              ),
              const SizedBox(height: 30),
              Wrap(
                  alignment: WrapAlignment.spaceEvenly,
                  children: List.generate(
                      6,
                      (index) => GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedTopupIndex = index;
                              });
                            },
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 20),
                              width: 100,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.05),
                                  border: Border.all(
                                      color: index == selectedTopupIndex
                                          ? Theme.of(context).primaryColor
                                          : Colors.transparent,
                                      width: 1),
                                  borderRadius: BorderRadius.circular(6)),
                              child: Center(
                                  child: Text(
                                formatterCurrency.format(topupValue[index]),
                                style: TextStyle(
                                    color: index == selectedTopupIndex
                                        ? Theme.of(context).primaryColor
                                        : Colors.white,
                                    fontWeight: FontWeight.w500),
                              )),
                            ),
                          ))),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        state.when(
                          selected: (money) {
                            showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (context) => Center(
                                        child: CircularProgressIndicator(
                                      color: Theme.of(context).primaryColor,
                                    )));

                            final topupMoney = topupValue[selectedTopupIndex];

                            users.doc(user?.uid).get().then((value) {
                              final data = value.data() as Map<String, dynamic>;

                              BlocProvider.of<MoneyCubit>(context)
                                  .getSelectedMoney(data['money'] + topupMoney);

                              users.doc(user?.uid).update(
                                  {'money': data['money'] + topupMoney});
                            }).then((_) {
                              transactions.add({
                                'uid': user?.uid,
                                'datetime': DateTime.now(),
                                'date': formatterDate.format(DateTime.now()),
                                'time': formatterTime.format(DateTime.now()),
                                'type': 'in',
                                'amount': topupMoney,
                              });
                            }).then((_) {
                              Navigator.of(context, rootNavigator: true).pop();
                              context.goNamed('profile');

                              showTopSnackBar(
                                  Overlay.of(context) as OverlayState,
                                  displayDuration:
                                      const Duration(milliseconds: 1000),
                                  const CustomSnackBar.success(
                                      message: 'Top Up Success'));
                            }).catchError((e) {
                              Navigator.of(context, rootNavigator: true).pop();
                              showTopSnackBar(
                                  Overlay.of(context) as OverlayState,
                                  displayDuration:
                                      const Duration(milliseconds: 1000),
                                  const CustomSnackBar.error(
                                      message: 'An error occured!'));
                            });
                          },
                        );
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(200, 60)),
                      child: const Text(
                        'Top Up',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ))
                ],
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Latest Transactions',
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: Colors.white.withOpacity(0.9)),
                ),
              ),
              const SizedBox(height: 10),
              FutureBuilder<QuerySnapshot>(
                future: transactions
                    .where('uid', isEqualTo: user?.uid)
                    .orderBy('datetime', descending: true)
                    .limit(7)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.docs.isEmpty) {
                      return Center(
                          child: Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Text(
                          "You have no transactions!",
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600),
                        ),
                      ));
                    }
                    final dataDocs = snapshot.data!.docs;

                    return Column(
                        children: List.generate(dataDocs.length, (index) {
                      final data =
                          dataDocs[index].data() as Map<String, dynamic>;
                      return HistoryTransaction(
                          index: index,
                          type: data['type'],
                          date: data['date'],
                          time: data['time'],
                          amount: formatterCurrency.format(data['amount']));
                    }));
                  } else {
                    return const LoadingSpinner();
                  }
                },
              )
            ],
          );
        },
      ),
    );
  }
}
