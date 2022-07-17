import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DashBoardSos extends StatefulWidget {
  const DashBoardSos({Key? key}) : super(key: key);

  @override
  State<DashBoardSos> createState() => _DashBoardSosState();
}

class _DashBoardSosState extends State<DashBoardSos> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  late StreamSubscription<Position> positionStream;
  String status = 'Aguardando GPS';
  Position? positionLocation;

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _determinePosition(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.none:
            break;
          case ConnectionState.waiting:
            // TODO: Handle this case.
            break;
          case ConnectionState.active:
            // TODO: Handle this case.
            break;
          case ConnectionState.done:
            return Padding(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 16, bottom: 256),
              child: GoogleMap(
                mapType: MapType.normal,
                initialCameraPosition: CameraPosition(
                    target: LatLng(positionLocation?.latitude ?? 35,
                        positionLocation?.longitude ?? 34),
                    zoom: 18),
                onMapCreated: (GoogleMapController controller) {
                  _controller.complete(controller);
                },
              ),
            );
        }
        return const Text('data');
      },
    );
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    setState(() {
      positionLocation = Geolocator.getCurrentPosition() as Position?;
    });
    return await Geolocator.getCurrentPosition();
  }
}
