import 'package:flutter/material.dart';

import '../../data/models/sos.dart';

class SosDetails extends StatelessWidget {
  final Sos sos;

  const SosDetails({Key? key, required this.sos}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Image.network(
        //   sos.imageCaptured ?? '',
        //   height: 250,
        //   width: MediaQuery.of(context).size.width,
        //   fit: BoxFit.cover,
        // ),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 24),
          child: Text(
            sos.message,
            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w600),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 24, left: 24),
          child: Text(
            '${sos.location.latitude} - ${sos.location.longitude}',
          ),
        ),
      ],
    );
  }
}
