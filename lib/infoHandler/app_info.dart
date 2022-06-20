import 'package:flutter/material.dart';

import '../models/directions.dart';
import '../models/history_model.dart';

class AppInfo extends ChangeNotifier {
  Directions? clientHouseLocation, clientDroppOffLocation;
  int countTotalHandymans = 0;
  List<String> historyHandymanKeysList = [];
  List<HandymanHistoryModel> allHandymansHistoryInformationList = [];
  String handymanTotalEarnings = "0";
  String handymanAverageRatings = "0";

  void updateClientHouseAdress(Directions clientHouseAdress) {
    clientHouseLocation = clientHouseAdress;
    notifyListeners();
  }

  void updateDropOffClientHouseAdress(Directions droppOffLocation) {
    clientDroppOffLocation = droppOffLocation;
    notifyListeners();
  }

  updateHandymansCounter(int handymansCounter) {
    countTotalHandymans = handymansCounter;
    notifyListeners();
  }

  updateOverAllHandymansKeys(List<String> handymanKeysList) {
    historyHandymanKeysList = handymanKeysList;
    notifyListeners();
  }

  updateOverAllHandymansHistoryDataInformation(
      HandymanHistoryModel eacheHistoryHandyman) {
    allHandymansHistoryInformationList.add(eacheHistoryHandyman);
    notifyListeners();
  }

  updateHandymanTotalEarnings(String handymanEarnings) {
    handymanTotalEarnings = handymanEarnings;
  }

  updateHandymanAverageRatings(String handymanRatings) {
    handymanAverageRatings = handymanRatings;
  }
}
