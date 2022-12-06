import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  const LoadingSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        height: MediaQuery.of(context).size.height / 1.5,
        child: Center(
            child: CircularProgressIndicator(
          color: Theme.of(context).primaryColor,
        )));
  }
}
