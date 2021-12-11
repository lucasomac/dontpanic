import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:permission_handler/permission_handler.dart' as ph;

class DashBoardSos extends StatefulWidget {
  const DashBoardSos({Key? key}) : super(key: key);

  @override
  State<DashBoardSos> createState() => _DashBoardSosState();
}

class _DashBoardSosState extends State<DashBoardSos> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  late StreamSubscription<Position> positionStream;
  String status = 'Aguardando GPS';
  late Position positionLocation;

  @override
  void initState() {
    listenPosition();
    super.initState();
  }

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 256),
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: const CameraPosition(
            target: LatLng(25, 23),
          ),
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
      ),
    );
  }

  listenPosition() async {
    ph.PermissionStatus permission = await ph.Permission.location.request();

    if (permission.isDenied) {
      _showMessage(
          'Parece que você não permitiu o uso do GPS, abra as configurações do aplicativo e libere a permissão');
    } else {
      bool gpsIsEnabled = await Geolocator.isLocationServiceEnabled();

      if (!gpsIsEnabled) {
        _showMessage(
            'Seu GPS está desligado, para obter a localicação ative-o.');
      }
      setState(() {
        status = 'Obtendo a localização';
      });

      positionStream =
          Geolocator.getPositionStream().listen((Position position) async {
        // garante que o trecho abaixo seja executado somente uma vez
        if (positionLocation == null) {
          setState(() {
            positionLocation = position;
          });
          setState(() {
            positionLocation = position;
            status = 'Localização obtida';
          });
        }
      });
    }
  }

  _showMessage(String message) => scaffoldKey.currentState?.showSnackBar(
        SnackBar(
          content: Text(message),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          behavior: SnackBarBehavior.floating,
        ),
      );
}
