import 'package:dontpanic/controller/sos_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget with ChangeNotifier {
  Home({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SosController>(
      create: (context) => SosController(),
      child: Builder(
        builder: (context) {
          final local = context.watch<SosController>();
          return GoogleMap(
            initialCameraPosition: CameraPosition(
              target: LatLng(local.lat, local.long),
              zoom: 18,
            ),
            mapType: MapType.normal,
            myLocationEnabled: true,
            onMapCreated: local.onMapCreated,
            markers: local.markers,
          );
        },
      ),
    );
  }
}
