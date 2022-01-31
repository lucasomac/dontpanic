import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dontpanic/data/database.dart';
import 'package:dontpanic/models/sos.dart';
import 'package:dontpanic/res/strings.dart';

class SosController {
  String userEmail;
  late CollectionReference sosCalls;

  SosController(this.userEmail) {
    sosCalls =
        Database.dontPanicDb.doc(userEmail).collection(Strings.sosCollection);
  }

  Future<void> addSosCall({required Sos sos}) async {
    DocumentReference documentReferencer = sosCalls.doc();
    await documentReferencer
        .set(sos.toJson())
        .whenComplete(() => print("Note item added to the database"))
        .then((value) => print("User Added"))
        .catchError((error) => print("Failed to add user: $error"));
  }
}
// static Future<void> updateItem(
//     {required SecureContact secureContact, required String docId}) async {
//   DocumentReference documentReferencer = sosCalls.doc(docId);
//
//   Map<String, dynamic> data = <String, dynamic>{
//     "name": secureContact.name,
//     "phone": secureContact.phone,
//   };
//
//   await documentReferencer
//       .update(data)
//       .whenComplete(() => print("Note item updated in the database"))
//       .catchError((e) => print(e));
// }
//
// static Stream<QuerySnapshot> readSecureContacts() {
//   return sosCalls.snapshots();
// }
//
// static Future<void> deleteSecureContact({
//   required String docId,
// }) async {
//   DocumentReference documentReferencer = sosCalls.doc(docId);
//
//   await documentReferencer
//       .delete()
//       .whenComplete(() => print('Note item deleted from the database'))
//       .catchError((e) => print(e));
// }
