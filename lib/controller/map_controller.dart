import 'package:dontpanic/data/repository/sos_repository.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiwi/kiwi.dart';
import '../data/models/sos.dart';
import '../ui/screens/base.dart';
import '../ui/widgets/sos_details.dart';

class MapRepository extends ChangeNotifier {
  final SosRepository repository = KiwiContainer().resolve();
  double lat = 0;
  double long = 0;
  String error = '';
  Set<Marker> markers = {};
  late GoogleMapController _googleMapController;

  final String useremail;

  MapRepository(this.useremail);

  get googleMapController => _googleMapController;

  onMapCreated(GoogleMapController gmc) async {
    _googleMapController = gmc;
    getPosition();
    loadSos(useremail);
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

  void loadSos(String userEmail) {
    final List<Sos> soss = repository.getAllSos(userEmail) as List<Sos>;
    for (var sos in soss) {
      markers.add(Marker(
          markerId: MarkerId(sos.message),
          position: LatLng(sos.location.latitude, sos.location.longitude),
          // icon: await BitmapDescriptor.fromAssetImage(
          //     ImageConfiguration(size: Size(5, 5)),
          //     'assets/images/logo_dont_panic.png'),
          onTap: () {
            showModalBottomSheet(
                context: appKey.currentState!.context,
                builder: (context) => SosDetails(sos: sos));
          }));
    }
    notifyListeners();
  }
}
