import 'package:flutter/material.dart';

class HistoryTransaction extends StatelessWidget {
  final int index;
  final String type;
  final String date;
  final String time;
  final String amount;

  const HistoryTransaction({
    Key? key,
    required this.index,
    required this.type,
    required this.date,
    required this.time,
    required this.amount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 80,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
          color: index % 2 == 0 ? Colors.white10 : Colors.transparent),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                date,
                style: TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 6),
              Text(
                time,
                style: TextStyle(color: Colors.white.withOpacity(0.8)),
              )
            ],
          ),
          type == 'in'
              ? Text(
                  '+$amount',
                  style: TextStyle(
                      fontSize: 16,
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w500),
                )
              : Text(
                  '-$amount',
                  style: const TextStyle(
                      fontSize: 16,
                      color: Colors.red,
                      fontWeight: FontWeight.w500),
                )
        ],
      ),
    );
  }
}
