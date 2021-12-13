import 'package:dontpanic/models/sos.dart';
import 'package:flutter/material.dart';

class SosDetails extends StatelessWidget {
  final Sos sos;

  const SosDetails({Key? key, required this.sos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.network(
          sos.imageCaptured ?? '',
          height: 250,
          width: MediaQuery.of(context).size.width,
          fit: BoxFit.cover,
        ),
        Padding(
          padding: EdgeInsets.only(top: 24, left: 24),
          child: Text(
            sos.message,
            style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: 24, left: 24),
          child: Text(
            '${sos.latitude} - ${sos.longitude}',
          ),
        ),
      ],
    );
  }
}
