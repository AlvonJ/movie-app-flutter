import 'package:flutter/material.dart';

class ProfileInfo extends StatelessWidget {
  final IconData icon;
  final String title;
  final String text;
  final Color color;

  const ProfileInfo({
    Key? key,
    required this.icon,
    required this.title,
    required this.text,
    required this.color,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 46),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
            ),
            Text(
              text,
              style: TextStyle(color: color, fontSize: 15),
            )
          ],
        ),
      ],
    );
  }
}
