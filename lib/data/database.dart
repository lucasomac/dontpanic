import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore firestore = FirebaseFirestore.instance;

class Database {
  static CollectionReference dontPanicDb = firestore.collection('dontpanic');
  // static CollectionReference dontPanicDbSos =
  //     firestore.collection(Strings.sosCollection);
  // static CollectionReference dontPanicDbContact =
  //     firestore.collection(Strings.secureContactCollection);
}
