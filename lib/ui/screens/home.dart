import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dontpanic/data/repository/sos_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:kiwi/kiwi.dart';
import 'package:provider/provider.dart';
import 'package:slidable_button/slidable_button.dart';
import 'package:sprintf/sprintf.dart';
import 'package:telephony/telephony.dart';

import '../../controller/map_controller.dart';
import '../../data/models/secure_contact.dart';
import '../../data/models/sos.dart';
import '../../data/repository/secure_contact_repository.dart';
import '../../res/strings.dart';

class Home extends StatefulWidget with ChangeNotifier {
  User loggedUser;

  Home(this.loggedUser, {key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final Telephony telephony = Telephony.instance;
  final SecureContactRepository repository = KiwiContainer().resolve();
  final SosRepository repositorySos = KiwiContainer().resolve();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<MapRepository>(
      create: (context) => MapRepository(widget.loggedUser.email!),
      child: Builder(
        builder: (context) {
          final local = context.watch<MapRepository>();
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
                stream:
                    repository.getAllSecureContact(widget.loggedUser.email!),
                builder: (context, snapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: HorizontalSlidableButton(
                      width: MediaQuery.of(context).size.width / 2,
                      height: 40,
                      isRestart: true,
                      buttonWidth: 40,
                      color: Colors.greenAccent,
                      buttonColor: Colors.black45,
                      dismissible: false,
                      label: const Center(child: Icon(Icons.arrow_right)),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: const [Text(Strings.labelDragToSentSos)],
                        ),
                      ),
                      onChanged: (position) {
                        // setState(() {
                        if (position == SlidableButtonPosition.end) {
                          setState(() {
                            var secureContactInfo = snapshot.data!.docs
                                .map((e) => SecureContact.fromJson(
                                    e.data() as Map<String, dynamic>))
                                .map((e) => e.phone)
                                .toList();
                            if (secureContactInfo.isNotEmpty) {
                              _sendSMS(
                                  secureContactInfo, local.lat, local.long);
                              _registerSos(Sos(
                                  _montaMessageToSend(local.lat, local.long),
                                  GeoPoint(local.lat, local.long),
                                  DateTime.now()));
                              _showToast(Strings.messageSosSent);
                            } else {
                              _showToast(Strings.messageNoContactsRegistered);
                            }
                          });
                        }
                      },
                    ),
                  );
                },
              ),
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
    repositorySos.addSos(widget.loggedUser.email!, sos);
  }

  Future<void> _sendSMS(
      List<String> recipients, double latitude, double longitude) async {
    for (var element in recipients) {
      debugPrint(_montaMessageToSend(latitude, longitude));
      telephony.sendSms(
          to: element,
          message: _montaMessageToSend(latitude, longitude),
          isMultipart: true);
    }
  }
}
