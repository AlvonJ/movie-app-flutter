import 'package:flutter/material.dart';

class SmallBox extends StatelessWidget {
  final IconData icon;
  final String header;
  final String content;

  const SmallBox(
      {super.key,
      required this.icon,
      required this.header,
      required this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 90,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.white12),
          borderRadius: BorderRadius.circular(10)),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(
          icon,
          size: 24,
          color: Colors.white,
          shadows: const [Shadow(color: Colors.white30, blurRadius: 50)],
        ),
        const SizedBox(height: 10),
        Text(
          header,
          style: const TextStyle(color: Colors.white60),
        ),
        const SizedBox(height: 2),
        Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(fontWeight: FontWeight.w600),
        )
      ]),
    );
  }
}
