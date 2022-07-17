import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/secure_contact.dart';
import '../models/sos.dart';

abstract class SosRepository {
  Future<void> addSos(String userEmail, Sos sos);

  Stream<QuerySnapshot> getAllSos(String userEmail);

  Future<void> updateSos(
      String userEmail, SecureContact secureContact, String docId);
}
