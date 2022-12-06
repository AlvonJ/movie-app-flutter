import 'package:flutter/material.dart';

class Utils {
  static final messengerKey = GlobalKey<ScaffoldMessengerState>();

  static showSnackBarError(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(content: Text(text), backgroundColor: Colors.red);

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  static showSnackBarSuccess(String? text) {
    if (text == null) return;

    final snackBar = SnackBar(
        content: Text(
          text,
          style: const TextStyle(
              color: Colors.black, fontSize: 16, fontWeight: FontWeight.w600),
        ),
        backgroundColor: const Color(0xffdca135));

    messengerKey.currentState!
      ..removeCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
