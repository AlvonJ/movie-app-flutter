import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String emoji;
  final String text;

  const CategoryCard({super.key, required this.emoji, required this.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(18),
          decoration: BoxDecoration(
              color: Colors.white10, borderRadius: BorderRadius.circular(16)),
          child: Text(
            emoji,
            style: const TextStyle(fontSize: 20),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        Text(
          text,
          style: const TextStyle(color: Colors.white70, fontSize: 13),
        )
      ],
    );
  }
}
