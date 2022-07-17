import 'package:cloud_firestore/cloud_firestore.dart';

import '../res/strings.dart';

// FirebaseFirestore firestore = FirebaseFirestore.instance;

class Database {
  final FirebaseFirestore _firestore;

  Database(this._firestore);

  // CollectionReference _getDontPanicDb() {
  //   return firestore.collection('dontpanic');
  // }

  CollectionReference getSosCollection() {
    return _firestore.collection(Strings.sosCollection);
  }

  CollectionReference getSecureContactCollection() {
    return _firestore.collection(Strings.secureContactCollection);
  }
}
