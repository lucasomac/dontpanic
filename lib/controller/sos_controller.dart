import 'package:dontpanic/repositories/sos_repositories.dart';
import 'package:dontpanic/screens/base.dart';
import 'package:dontpanic/widgets/sos_details.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SosController extends ChangeNotifier {
  double lat = 0;
  double long = 0;
  String error = '';
  Set<Marker> markers = {};
  late GoogleMapController _googleMapController;

  get googleMapController => _googleMapController;

  onMapCreated(GoogleMapController gmc) async {
    _googleMapController = gmc;
    getPosition();
    loadSos();
  }

  getPosition() async {
    try {
      Position position = await _actualPosition();
      lat = position.latitude;
      long = position.longitude;
      _googleMapController
          .animateCamera(CameraUpdate.newLatLng(LatLng(lat, long)));
    } catch (error) {
      this.error = error.toString();
    }
    notifyListeners();
  }

  Future<Position> _actualPosition() async {
    LocationPermission permission;
    bool enable = await Geolocator.isLocationServiceEnabled();
    if (!enable) {
      return Future.error('Por favor, habilite a localizacao do smartphone');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Você precisa autorizar o acesso a localização');
      }
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error('Você precisa autorizar o acesso a localização');
    }
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  void loadSos() {
    final sos = SosRepository().soss;
    sos.forEach((sos) async {
      markers.add(Marker(
          markerId: MarkerId(sos.message),
          position: LatLng(sos.latitude, sos.longitude),
          // icon: await BitmapDescriptor.fromAssetImage(
          //     ImageConfiguration(size: Size(5, 5)),
          //     'assets/images/logo_dont_panic.png'),
          onTap: () {
            showModalBottomSheet(
                context: appKey.currentState!.context,
                builder: (context) => SosDetails(sos: sos));
          }));
    });
    notifyListeners();
  }
}
