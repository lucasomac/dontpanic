import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Database {
  static CollectionReference dontPanicDb = firestore.collection('dontpanic');
}
