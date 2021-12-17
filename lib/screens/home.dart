import 'package:dontpanic/controller/map_controller.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class Home extends StatelessWidget with ChangeNotifier {
  Home({key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapController>(
      create: (context) => MapController(),
      child: Builder(
        builder: (context) {
          final local = context.watch<MapController>();
          return Column(
            children: [
              Flexible(
                child: GoogleMap(
                  initialCameraPosition: CameraPosition(
                    target: LatLng(local.lat, local.long),
                    zoom: 18,
                  ),
                  mapType: MapType.normal,
                  myLocationEnabled: true,
                  onMapCreated: local.onMapCreated,
                  markers: local.markers,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.greenAccent)),
                  onPressed: () {},
                  child: Text(
                    'ENVIAR SOS',
                    style: TextStyle(fontSize: 48, color: Colors.black54),
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
