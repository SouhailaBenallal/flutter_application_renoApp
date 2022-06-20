import 'package:firebase_database/firebase_database.dart';

class HandymanHistoryModel {
  String? time;
  String? location;
  String? status;
  String? totalFareAmount;
  String? clientName;
  String? clientPhone;

  HandymanHistoryModel(
      {this.time,
      this.location,
      this.status,
      this.totalFareAmount,
      this.clientName,
      this.clientPhone});

  HandymanHistoryModel.fromSnapshot(DataSnapshot dataSnapshot) {
    time = (dataSnapshot.value as Map)["Time"];
    location = (dataSnapshot.value as Map)["Location"];
    status = (dataSnapshot.value as Map)["status"];
    totalFareAmount = (dataSnapshot.value as Map)["totalFareAmount"].toString();
    clientName = (dataSnapshot.value as Map)["ClientName"];
    clientPhone = (dataSnapshot.value as Map)["ClientPhone"];
  }
}
