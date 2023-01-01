import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:material_dialogs/material_dialogs.dart';
import 'package:movie_app/cubit/money_cubit.dart';
import 'package:movie_app/cubit/movies_cubit.dart';
import 'package:movie_app/models/ticket.dart';
import 'package:movie_app/models/utils.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class SeatsPage extends StatefulWidget {
  final int id;
  const SeatsPage({super.key, required this.id});

  @override
  State<SeatsPage> createState() => _SeatsPageState();
}

class _SeatsPageState extends State<SeatsPage> {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  final user = FirebaseAuth.instance.currentUser;
  List<int> colorRowA = List.generate(6, (index) => 0);
  List<int> colorRowB = List.generate(8, (index) => 0);
  List<int> colorRowC = List.generate(8, (index) => 0);
  List<int> colorRowD = List.generate(8, (index) => 0);
  List<int> colorRowE = List.generate(6, (index) => 0);
  List<String> selectedSeat = [];
  int selectedDateIndex = 0;
  int selectedTimeIndex = 0;

  List<String> times = [
    '11:00',
    '12:30',
    '14:30',
    '16:00',
    '18:30',
    '20:00',
    '21:30'
  ];

  var now = DateTime.now();

  final formatterMonth = DateFormat('MMM');
  final formatterDay = DateFormat('dd');
  final formatterCurrency =
      NumberFormat.currency(locale: "id_ID", symbol: "Rp");
  final formatterTime = DateFormat('HH:mm');
  final formatterDate = DateFormat('dd MMMM yyyy');

  @override
  Widget build(BuildContext context) {
    final CollectionReference tickets = firestore.collection('tickets');
    final CollectionReference transactions =
        firestore.collection('transactions');
    final CollectionReference users = firestore.collection('users');
    List<DateTime> dates =
        List.generate(7, (index) => now.add(Duration(days: index)));

    selectedSeat.sort((a, b) => a.compareTo(b));

    String price = formatterCurrency.format(selectedSeat.length * 43000);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(size: 26, color: Colors.white),
        elevation: 0,
        title: const Text(
          "Select Seats",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Column(children: [
        Container(
          width: 280,
          height: 65,
          decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('./assets/img/screen.png'),
                  fit: BoxFit.cover)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  colorRowA[index] == 0
                      ? {
                          colorRowA[index] = 1,
                          selectedSeat.add("A${index + 1}")
                        }
                      : {
                          colorRowA[index] = 0,
                          selectedSeat.remove("A${index + 1}")
                        };

                  ;
                });
              },
              child: Container(
                width: 35,
                height: 35,
                margin: index == 2
                    ? const EdgeInsets.only(right: 25)
                    : const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorRowA[index] == 0
                        ? const Color(0xff373741)
                        : Theme.of(context).primaryColor),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(8, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  colorRowB[index] == 0
                      ? {
                          colorRowB[index] = 1,
                          selectedSeat.add("B${index + 1}")
                        }
                      : {
                          colorRowB[index] = 0,
                          selectedSeat.remove("B${index + 1}")
                        };
                });
              },
              child: Container(
                width: 35,
                height: 35,
                margin: index == 3
                    ? const EdgeInsets.only(right: 25)
                    : const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorRowB[index] == 0
                        ? const Color(0xff373741)
                        : Theme.of(context).primaryColor),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(8, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  colorRowC[index] == 0
                      ? {
                          colorRowC[index] = 1,
                          selectedSeat.add("C${index + 1}")
                        }
                      : {
                          colorRowC[index] = 0,
                          selectedSeat.remove("C${index + 1}")
                        };
                });
              },
              child: Container(
                width: 35,
                height: 35,
                margin: index == 3
                    ? const EdgeInsets.only(right: 25)
                    : const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorRowC[index] == 0
                        ? const Color(0xff373741)
                        : Theme.of(context).primaryColor),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(8, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  colorRowD[index] == 0
                      ? {
                          colorRowD[index] = 1,
                          selectedSeat.add("D${index + 1}")
                        }
                      : {
                          colorRowD[index] = 0,
                          selectedSeat.remove("D${index + 1}")
                        };
                });
              },
              child: Container(
                width: 35,
                height: 35,
                margin: index == 3
                    ? const EdgeInsets.only(right: 25)
                    : const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorRowD[index] == 0
                        ? const Color(0xff373741)
                        : Theme.of(context).primaryColor),
              ),
            );
          }),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(6, (index) {
            return GestureDetector(
              onTap: () {
                setState(() {
                  colorRowE[index] == 0
                      ? {
                          colorRowE[index] = 1,
                          selectedSeat.add("E${index + 1}")
                        }
                      : {
                          colorRowE[index] = 0,
                          selectedSeat.remove("E${index + 1}")
                        };
                });
              },
              child: Container(
                width: 35,
                height: 35,
                margin: index == 2
                    ? const EdgeInsets.only(right: 25)
                    : const EdgeInsets.only(right: 10),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: colorRowE[index] == 0
                        ? const Color(0xff373741)
                        : Theme.of(context).primaryColor),
              ),
            );
          }),
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 18,
              height: 18,
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xff373741)),
            ),
            const SizedBox(width: 10),
            const Text("Available"),
            const SizedBox(width: 15),
            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor),
            ),
            const SizedBox(width: 10),
            const Text("Selected"),
          ],
        ),
        const SizedBox(height: 30),
        Flexible(
          child: Container(
            width: double.maxFinite,
            decoration: const BoxDecoration(
                color: Color(0xff373741),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(50),
                    topRight: Radius.circular(50))),
            child: Column(children: [
              const SizedBox(height: 20),
              const Text(
                "Select Date and Time",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 30),
              Container(
                width: double.infinity,
                height: 75,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                        dates.length,
                        (index) => InkWell(
                              onTap: () {
                                setState(() {
                                  selectedDateIndex = index;
                                });
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: 50,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(22),
                                    color: index == selectedDateIndex
                                        ? Theme.of(context).primaryColor
                                        : Colors.white.withOpacity(0.05)),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 12, horizontal: 5),
                                  child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          formatterMonth.format(dates[index]),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: Colors.white70),
                                        ),
                                        Container(
                                          padding: const EdgeInsets.all(7),
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: index == selectedDateIndex
                                                  ? Colors.white
                                                  : Colors.transparent),
                                          child: Text(
                                            formatterDay.format(dates[index]),
                                            style: TextStyle(
                                                color:
                                                    index == selectedDateIndex
                                                        ? Colors.black
                                                        : Colors.white,
                                                fontWeight: FontWeight.w500),
                                          ),
                                        )
                                      ]),
                                ),
                              ),
                            ))),
              ),
              const SizedBox(height: 35),
              Container(
                width: double.infinity,
                height: 40,
                child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: List.generate(
                        times.length,
                        (index) => InkWell(
                              onTap: () {
                                setState(() {
                                  selectedTimeIndex = index;
                                });
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                width: 60,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.05),
                                    border: Border.all(
                                        color: index == selectedTimeIndex
                                            ? Theme.of(context).primaryColor
                                            : Colors.transparent,
                                        width: 1),
                                    borderRadius: BorderRadius.circular(6)),
                                child: Center(
                                    child: Text(
                                  times[index],
                                  style: TextStyle(
                                      color: index == selectedTimeIndex
                                          ? Theme.of(context).primaryColor
                                          : Colors.white,
                                      fontWeight: FontWeight.w500),
                                )),
                              ),
                            ))),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total Price",
                          style: TextStyle(color: Colors.white54),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          selectedSeat.isEmpty ? 'Select seats' : price,
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                    BlocBuilder<MoviesCubit, MoviesState>(
                      builder: (context, state) {
                        return ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                shadowColor: Colors.white70,
                                elevation: 100,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 50, vertical: 18)),
                            onPressed: () {
                              if (selectedSeat.isEmpty) {
                                showTopSnackBar(
                                    Overlay.of(context) as OverlayState,
                                    const CustomSnackBar.error(
                                        message: 'Select your seats first!'),
                                    dismissType: DismissType.onSwipe,
                                    dismissDirection: [
                                      DismissDirection.horizontal,
                                      DismissDirection.up
                                    ]);

                                return;
                              }

                              Dialogs.materialDialog(
                                  msg:
                                      'Do you want to buy the ticket for \n${formatterCurrency.format(selectedSeat.length * 43000)}',
                                  title: "Purchase Confirmation",
                                  titleStyle: const TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20),
                                  msgStyle: const TextStyle(
                                      color: Colors.black, fontSize: 16),
                                  msgAlign: TextAlign.center,
                                  color: Colors.white,
                                  context: context,
                                  actions: [
                                    IconButton(
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                      icon: const Icon(Icons.close_outlined,
                                          semanticLabel: 'Cancel',
                                          color: Colors.grey),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        if (selectedSeat.length > 6) {
                                          Navigator.of(context).pop();

                                          showTopSnackBar(
                                              Overlay.of(context)
                                                  as OverlayState,
                                              const CustomSnackBar.error(
                                                  message:
                                                      'Maximum seats are six for one order!'),
                                              dismissType: DismissType.onSwipe,
                                              dismissDirection: [
                                                DismissDirection.horizontal,
                                                DismissDirection.up
                                              ]);
                                          return;
                                        }

                                        if (BlocProvider.of<MoneyCubit>(context)
                                                .selectedMoney <=
                                            selectedSeat.length * 43000) {
                                          Navigator.of(context).pop();

                                          showTopSnackBar(
                                              Overlay.of(context)
                                                  as OverlayState,
                                              const CustomSnackBar.error(
                                                  message:
                                                      'Your money is not enough!'),
                                              dismissType: DismissType.onSwipe,
                                              dismissDirection: [
                                                DismissDirection.horizontal,
                                                DismissDirection.up
                                              ]);
                                          return;
                                        }

                                        state.when(
                                            unselected: () => null,
                                            selected: (movie) {
                                              showDialog(
                                                  context: context,
                                                  barrierDismissible: false,
                                                  builder: (context) => Center(
                                                          child:
                                                              CircularProgressIndicator(
                                                        color: Theme.of(context)
                                                            .primaryColor,
                                                      )));

                                              Ticket ticket = Ticket(
                                                  movie: movie,
                                                  date:
                                                      dates[selectedDateIndex],
                                                  time:
                                                      times[selectedTimeIndex],
                                                  price: (selectedSeat.length *
                                                      43000),
                                                  seats: selectedSeat);

                                              users
                                                  .doc(user?.uid)
                                                  .get()
                                                  .then((value) {
                                                final data = value.data()
                                                    as Map<String, dynamic>;

                                                BlocProvider.of<MoneyCubit>(
                                                        context)
                                                    .getSelectedMoney(data[
                                                            'money'] -
                                                        selectedSeat.length *
                                                            43000);
                                                users.doc(user?.uid).update({
                                                  'money': data['money'] -
                                                      selectedSeat.length *
                                                          43000
                                                });
                                              }).then((_) {
                                                tickets.add({
                                                  'date': ticket.date,
                                                  'time': ticket.time,
                                                  'price': ticket.price,
                                                  'seats': ticket.seats,
                                                  'uid': user!.uid,
                                                  'movie': {
                                                    'id': ticket.movie.id,
                                                    'title': ticket.movie.title,
                                                    'poster_path': ticket
                                                        .movie.poster_path,
                                                  },
                                                }).then((_) {
                                                  final now = DateTime.now();
                                                  transactions.add({
                                                    'uid': user?.uid,
                                                    'type': 'out',
                                                    'datetime': now,
                                                    'time': formatterTime
                                                        .format(now),
                                                    'date': formatterDate
                                                        .format(now),
                                                    'amount':
                                                        selectedSeat.length *
                                                            43000
                                                  });
                                                }).then((_) {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();
                                                  showTopSnackBar(
                                                      Overlay.of(context)
                                                          as OverlayState,
                                                      displayDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  1500),
                                                      const CustomSnackBar
                                                              .success(
                                                          message:
                                                              'New ticket has been bought!'));

                                                  BlocProvider.of<MoviesCubit>(
                                                          context)
                                                      .unselectMovie();

                                                  context.goNamed('home');
                                                }).catchError((e) {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pop();

                                                  showTopSnackBar(
                                                      Overlay.of(context)
                                                          as OverlayState,
                                                      displayDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  2000),
                                                      CustomSnackBar.error(
                                                          message: e.message));
                                                });
                                              });
                                            });
                                      },
                                      icon: Icon(Icons.done_rounded,
                                          size: 40,
                                          semanticLabel: 'Yes',
                                          color:
                                              Theme.of(context).primaryColor),
                                    ),
                                  ]);
                            },
                            child: const Text(
                              "Book Ticket",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87),
                            ));
                      },
                    ),
                  ],
                ),
              )
            ]),
          ),
        )
      ]),
    );
  }
}
