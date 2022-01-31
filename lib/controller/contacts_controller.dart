import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dontpanic/data/database.dart';
import 'package:dontpanic/models/secure_contact.dart';
import 'package:dontpanic/res/strings.dart';

class ContactsController {
  String userEmail;
  late CollectionReference secureContacts;

  ContactsController(this.userEmail) {
    secureContacts = Database.dontPanicDb
        .doc(userEmail)
        .collection(Strings.secureContactCollection);
  }

  Future<void> addSecureContact({required SecureContact secureContact}) async {
    DocumentReference documentReferencer = secureContacts.doc();
    await documentReferencer
        .set({'name': secureContact.name, 'phone': secureContact.phone})
        .whenComplete(() => print("Note item added to the database"))
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }

  Future<void> updateItem(
      {required SecureContact secureContact, required String docId}) async {
    DocumentReference documentReferencer = secureContacts.doc(docId);

    Map<String, dynamic> data = <String, dynamic>{
      "name": secureContact.name,
      "phone": secureContact.phone,
    };

    await documentReferencer
        .update(data)
        .whenComplete(() => print("Note item updated in the database"))
        .catchError((e) => print(e));
  }

  Stream<QuerySnapshot> readSecureContacts() {
    return secureContacts.snapshots();
  }

  Future<void> deleteSecureContact({
    required String docId,
  }) async {
    DocumentReference documentReferencer = secureContacts.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete(() => print('Note item deleted from the database'))
        .catchError((e) => print(e));
  }
}
