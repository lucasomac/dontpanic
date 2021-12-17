import 'package:dontpanic/models/sos.dart';
import 'package:flutter/material.dart';

class SosRepository extends ChangeNotifier {
  final List<Sos> _soss = [
    //   Sos(
    //     'Posto GT - Rede Rodoil',
    //     -22.0199919,
    //     -47.8976676,
    //     imageCaptured:
    //         'https://lh5.googleusercontent.com/p/AF1QipP_xnSi5-sp9slSuMpSx-JlmvwvHGL1VJ_JcOGX=w408-h306-k-no',
    //   ),
    //   Sos(
    //     'Auto Posto Rodoviária',
    //     -22.0192609,
    //     -47.8975322,
    //     imageCaptured:
    //         'https://lh5.googleusercontent.com/p/AF1QipPnfQSsnvt6-VAxF-fUQ0onQCeRktJptOvSL_9F=w408-h306-k-no',
    //   ),
    //   Sos(
    //     'Auto Posto Nilo Cairo',
    //     -22.0197966,
    //     -47.8975237,
    //     imageCaptured:
    //         'https://lh5.googleusercontent.com/p/AF1QipOB2w7C9Q_NTblNRhcxJtN3-s4_gSjHI1rs5cSM=w408-h544-k-no',
    //   ),
  ];

  List<Sos> get soss => _soss;
}
