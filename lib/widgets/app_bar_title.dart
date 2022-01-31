import 'package:dontpanic/res/pallete.dart';
import 'package:flutter/material.dart';

class AppBarTitle extends StatelessWidget {
  const AppBarTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Image.asset(
          'assets/firebase_logo.png',
          height: 20,
        ),
        const SizedBox(width: 8),
        const Text(
          'FlutterFire',
          style: TextStyle(
            color: Palette.firebaseYellow,
            fontSize: 18,
          ),
        ),
        const Text(
          ' Authentication',
          style: TextStyle(
            color: Palette.firebaseOrange,
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
