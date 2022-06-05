import 'package:flutter/material.dart';
import 'package:flutter_application_reno/models/directions.dart';

class AppInfo extends ChangeNotifier {
  Directions? clientHouseLocation, clientDroppOffLocation;

  void updateClientHouseAdress(Directions clientHouseAdress) {
    clientHouseLocation = clientHouseAdress;
    notifyListeners();
  }

  void updateDropOffClientHouseAdress(Directions droppOffLocation) {
    clientDroppOffLocation = droppOffLocation;
    notifyListeners();
  }
}
