import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dontpanic/data/repository/secure_contact_repository.dart';
import 'package:flutter/material.dart';

import '../../data/models/secure_contact.dart';
import '../../res/strings.dart';

class SecureContactRepositoryImpl implements SecureContactRepository {
  final CollectionReference secureContacts;

  SecureContactRepositoryImpl(this.secureContacts);

  @override
  Future<void> addSecureContact(
      String userEmail, SecureContact secureContact) async {
    DocumentReference documentReferencer = secureContacts
        .doc(userEmail)
        .collection(Strings.secureContactCollection)
        .doc();
    await documentReferencer
        .set({'name': secureContact.name, 'phone': secureContact.phone})
        .whenComplete(() => debugPrint("Note item added to the database"))
        .then((value) => debugPrint("User Added"))
        .catchError((error) => debugPrint("Failed to add user: $error"));
  }

  @override
  Future<void> updateSecureContact(
      String userEmail, SecureContact secureContact, String docId) async {
    DocumentReference documentReferencer = secureContacts
        .doc(userEmail)
        .collection(Strings.secureContactCollection)
        .doc(docId);

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
  Stream<QuerySnapshot> getAllSecureContact(
    String userEmail,
  ) {
    return secureContacts
        .doc(userEmail)
        .collection(Strings.secureContactCollection)
        .snapshots();
  }

  @override
  Future<void> deleteSecureContact(String userEmail, String docId) async {
    DocumentReference documentReferencer = secureContacts
        .doc(userEmail)
        .collection(Strings.secureContactCollection)
        .doc(docId);
    await documentReferencer
        .delete()
        .whenComplete(() => debugPrint('Note item deleted from the database'))
        .catchError((e) => debugPrint(e));
  }
}
