class Sos {
  DateTime createdAt = DateTime.now();
  String message;
  double latitude;
  double longitude;
  String? imageCaptured;

  Sos(this.message, this.latitude, this.longitude, {this.imageCaptured});
}
