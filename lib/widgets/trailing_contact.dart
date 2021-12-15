import 'package:flutter/material.dart';

class TrailingContact extends StatelessWidget {
  const TrailingContact({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 28,
      height: 28,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: const SizedBox(
        width: 24,
        height: 24,
        child: Icon(
          Icons.delete,
          color: Colors.grey,
        ),
      ),
    );
  }
}
