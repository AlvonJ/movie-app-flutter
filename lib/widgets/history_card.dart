import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryCard extends StatelessWidget {
  const HistoryCard({
    Key? key,
    required this.data,
    required this.formatter,
    required this.dateTime,
    required this.formatterCurrency,
    required this.onTap,
  }) : super(key: key);

  final Map<String, dynamic> data;
  final DateFormat formatter;
  final DateTime dateTime;
  final NumberFormat formatterCurrency;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Container(
          margin: const EdgeInsets.only(bottom: 20),
          width: double.maxFinite,
          height: 150,
          decoration: BoxDecoration(
              color: Colors.white10, borderRadius: BorderRadius.circular(10)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 100,
                  height: 150,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: NetworkImage(
                              'https://image.tmdb.org/t/p/w200${data['movie']['poster_path']}'),
                          fit: BoxFit.cover)),
                ),
                const SizedBox(width: 20),
                SizedBox(
                  width: MediaQuery.of(context).size.width - 180,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${data['movie']['title']}',
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: Theme.of(context).primaryColor,
                            fontSize: 20),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        formatter.format(dateTime),
                        style: TextStyle(
                            fontSize: 16, color: Colors.white.withOpacity(0.9)),
                      ),
                      const Spacer(),
                      Text(
                        data['seats'].length == 1
                            ? '1 seat'
                            : "${data['seats'].length} seats",
                        style: TextStyle(color: Colors.white.withOpacity(0.8)),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        formatterCurrency.format(data['price']),
                        style: TextStyle(color: Colors.white.withOpacity(0.8)),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
