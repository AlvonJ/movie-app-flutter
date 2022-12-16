import 'package:barcode_widget/barcode_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:movie_app/widgets/loading_spinner.dart';

class TicketPage extends StatelessWidget {
  final String id;

  TicketPage({super.key, required this.id});

  final formatter = DateFormat('dd MMMM yyyy');
  final formatterCurrency =
      NumberFormat.currency(locale: "id_ID", symbol: "Rp ");

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference tickets = firestore.collection('tickets');

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(size: 26, color: Colors.white),
        elevation: 0,
        title: const Text(
          "Ticket Detail",
          style: TextStyle(fontSize: 18),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: FutureBuilder<DocumentSnapshot>(
            future: tickets.doc(id).get(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final data = snapshot.data!.data() as Map<String, dynamic>;
                DateTime dateTime = (data['date'] as Timestamp).toDate();
                final seatsList = data['seats'] as List<dynamic>;
                final seats = seatsList.join(', ');

                return Container(
                  width: double.infinity,
                  height: 650,
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                      color: Colors.white10,
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 350,
                          decoration: BoxDecoration(
                              image: DecorationImage(
                            image: NetworkImage(
                                'https://image.tmdb.org/t/p/w400${data['movie']['poster_path']}'),
                            fit: BoxFit.cover,
                            alignment: Alignment.bottomCenter,
                          )),
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            '${data['movie']['title']}',
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.clip,
                            maxLines: 1,
                            style: TextStyle(
                                color: Theme.of(context).primaryColor,
                                fontSize: 22,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const SizedBox(height: 14),
                        SizedBox(
                          width: double.infinity,
                          child: Text(
                            formatter.format(dateTime),
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w600),
                          ),
                        ),
                        const SizedBox(height: 6),
                        SizedBox(
                            width: double.infinity,
                            child: Text(
                              formatterCurrency.format(data['price']),
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 17),
                            )),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(children: [
                              const Text(
                                'Time:',
                                style: TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(width: 4),
                              Text(data['time']),
                            ]),
                            Row(children: [
                              const Text(
                                'Seats:',
                                overflow: TextOverflow.fade,
                                style: TextStyle(color: Colors.white70),
                              ),
                              const SizedBox(width: 4),
                              Text(seats)
                            ]),
                          ],
                        ),
                        const SizedBox(height: 20),
                        BarcodeWidget(
                          data: id,
                          barcode: Barcode.code128(),
                          height: 100,
                          color: Colors.white,
                          margin: const EdgeInsets.symmetric(horizontal: 20),
                        )
                      ]),
                );
              } else {
                return const LoadingSpinner();
              }
            }),
      ),
    );
  }
}
