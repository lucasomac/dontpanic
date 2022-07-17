import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dontpanic/data/repository/sos_repository.dart';
import 'package:flutter/material.dart';

import '../../data/models/secure_contact.dart';
import '../../data/models/sos.dart';
import '../../res/strings.dart';

class SosRepositoryImpl implements SosRepository {
  // final String userEmail;
  // final FirebaseFirestore firestore;
  final CollectionReference sosCalls;

  SosRepositoryImpl(this.sosCalls) {
    // sosCalls = Database(firestore)
    //     .getDontPanicDb()
    //     .doc(userEmail)
    //     .collection(Strings.sosCollection);
  }

  @override
  Future<void> addSos(String userEmail, Sos sos) async {
    DocumentReference documentReferencer =
        sosCalls.doc(userEmail).collection(Strings.sosCollection).doc();
    await documentReferencer
        .set(sos.toJson())
        .whenComplete(() => debugPrint("Note item added to the database"))
        .then((value) => debugPrint("User Added"))
        .catchError((error) => debugPrint("Failed to add user: $error"));
  }

  @override
  Future<void> updateSos(
      String userEmail, SecureContact secureContact, String docId) async {
    DocumentReference documentReferencer = sosCalls.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": secureContact.name,
      "phone": secureContact.phone,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => debugPrint("Note item updated in the database"))
        .catchError((e) => debugPrint(e));
  }

  @override
  Stream<QuerySnapshot<Object?>> getAllSos(String userEmail) {
    return sosCalls.snapshots();
  }
}
