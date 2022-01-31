import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dontpanic/controller/contacts_controller.dart';
import 'package:dontpanic/controller/map_controller.dart';
import 'package:dontpanic/controller/sos_controller.dart';
import 'package:dontpanic/models/secure_contact.dart';
import 'package:dontpanic/models/sos.dart';
import 'package:dontpanic/res/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:sprintf/sprintf.dart';
import 'package:telephony/telephony.dart';

class Home extends StatelessWidget with ChangeNotifier {
  final Telephony telephony = Telephony.instance;
  User loggedUser;

  Home(this.loggedUser, {key}) : super(key: key);

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
              StreamBuilder<QuerySnapshot>(
                  stream: ContactsController(loggedUser.email!)
                      .readSecureContacts(),
                  builder: (context, snapshot) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(Colors.greenAccent)),
                        onPressed: () {
                          var secureContactInfo = snapshot.data!.docs
                              .map((e) => SecureContact.fromJson(
                                  e.data() as Map<String, dynamic>))
                              .map((e) => e.phone)
                              .toList();
                          if (secureContactInfo.isNotEmpty) {
                            _sendSMS(secureContactInfo, local.lat, local.long);
                            _registerSos(Sos(
                                _montaMessageToSend(local.lat, local.long),
                                GeoPoint(local.lat, local.long),
                                DateTime.now()));
                            _showToast(
                                "Pedido de socorro enviado. Tente ir para um local seguro!");
                          } else {
                            _showToast("Você não possui contatos cadastrados!");
                          }
                        },
                        child: const Text(
                          'SOS',
                          style: TextStyle(fontSize: 48, color: Colors.black54),
                        ),
                      ),
                    );
                  })
            ],
          );
        },
      ),
    );
  }

  void _showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  _montaMessageToSend(double latitude, double longitude) {
    return Strings.patternMessage +
        sprintf(Strings.urlMaps, [latitude, longitude]);
  }

  Future<void> _registerSos(Sos sos) async {
    SosController(loggedUser.email!).addSosCall(sos: sos);
  }

  Future<void> _sendSMS(
      List<String> recipients, double latitude, double longitude) async {
    for (var element in recipients) {
      telephony.sendSms(
          to: element,
          message: _montaMessageToSend(latitude, longitude),
          isMultipart: true);
    }
  }
}
