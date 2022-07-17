import 'package:cloud_firestore/cloud_firestore.dart';

class Sos {
  late final DateTime createdAt;
  late final String message;
  late final GeoPoint location;

  // String? imageCaptured;

  Sos(this.message, this.location, this.createdAt);

  Sos.fromJson(Map<String, dynamic> json) {
    createdAt = json['createdAt'];
    message = json['message'];
    location = json['location'];
    // imageCaptured = json['imageCaptured'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['createdAt'] = createdAt;
    data['message'] = message;
    data['location'] = location;
    // data['imageCaptured'] = imageCaptured;
    return data;
  }
}
