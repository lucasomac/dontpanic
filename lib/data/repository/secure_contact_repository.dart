import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/secure_contact.dart';

abstract class SecureContactRepository {
  Future<void> addSecureContact(String userEmail, SecureContact secureContact);

  Future<void> updateSecureContact(
      String userEmail, SecureContact secureContact, String docId);

  Stream<QuerySnapshot> getAllSecureContact(String userEmail);

  Future<void> deleteSecureContact(String userEmail, String docId);
}
