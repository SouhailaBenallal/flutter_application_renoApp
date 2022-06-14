import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientHandymanRequestInformation {
  LatLng? locationLat;
  LatLng? locationLong;
  String? locationAdress;
  String? clientName;
  String? clientPhone;
  String? clientTask;

  ClientHandymanRequestInformation(
      {this.locationLat,
      this.locationLong,
      this.locationAdress,
      this.clientName,
      this.clientPhone,
      this.clientTask});
}
