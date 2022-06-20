import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:flutter_application_reno/all/map_key.dart';
import 'package:flutter_application_reno/assistants/assistant_request.dart';
import 'package:flutter_application_reno/infoHandler/app_info.dart';
import 'package:flutter_application_reno/models/directions.dart';
import 'package:flutter_application_reno/models/handyman_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

import '../models/history_model.dart';

class AssistantMethods {
  static Future<String> searchAddressForGeographicCoordinates(
      Position position, context) async {
    String apiUrl =
        "https://maps.googleapis.com/maps/api/geocode/json?latlng=${position.latitude},${position.longitude}&key=$mapKeyAndroid";

    String humanReadableAddress = "";

    var requestResponse = await AssistantRequest.receiveRequest(apiUrl);

    if (requestResponse != "Error Occurred, Failed. No Response") {
      humanReadableAddress = requestResponse["results"][0]["formatted_address"];
      Directions clientHouseAdress = Directions();
      clientHouseAdress.locationLatitude = position.latitude;
      clientHouseAdress.locationLongitude = position.longitude;
      clientHouseAdress.locationName = humanReadableAddress;

      Provider.of<AppInfo>(context, listen: false)
          .updateClientHouseAdress(clientHouseAdress);
    }

    return humanReadableAddress;
  }

  static void readCurrentOnlineClientInfo() async {
    currentFribaseUser = fAuth.currentUser;
    DatabaseReference clientRef = FirebaseDatabase.instance
        .ref()
        .child("clients")
        .child(currentFribaseUser!.uid);

    clientRef.once().then((snap) {
      if (snap.snapshot.value != null) {
        clientModelCurrentinfo = ClientModel.fromSnapshot(snap.snapshot);
      }
    });
  }

  // retrieve the handymans keys for online client
  // hanyman key = handyman request key
  static void readHandymanKeyForOnlineHandymans(context) {
    FirebaseDatabase.instance
        .ref()
        .child("All Handyman request")
        .orderByChild("handymanId")
        .equalTo(fAuth.currentUser!.uid)
        .once()
        .then((snap) {
      if (snap.snapshot.value != null) {
        Map keysHandymansId = snap.snapshot.value as Map;
        int handymansCounter = keysHandymansId.length;
        Provider.of<AppInfo>(context, listen: false)
            .updateHandymansCounter(handymansCounter);

        //share handymans keys with Provider
        List<String> handymanKeysList = [];
        keysHandymansId.forEach((key, value) {
          handymanKeysList.add(key);
          Provider.of<AppInfo>(context, listen: false)
              .updateOverAllHandymansKeys(handymanKeysList);
          // get handyman data
          readHandymanHistoryInformation(context);
        });
      }
    });
  }

  static void readHandymanHistoryInformation(context) {
    var handymansAllKeys =
        Provider.of<AppInfo>(context, listen: false).historyHandymanKeysList;
    for (String eachkey in handymansAllKeys) {
      FirebaseDatabase.instance
          .ref()
          .child("All Handyman request")
          .child(eachkey)
          .once()
          .then((snap) {
        var eacheHistoryHandyman =
            HandymanHistoryModel.fromSnapshot(snap.snapshot);
        if ((snap.snapshot.value as Map)["status"] == "ended") {
          Provider.of<AppInfo>(context, listen: false)
              .updateOverAllHandymansHistoryDataInformation(
                  eacheHistoryHandyman);
        }
      });
    }
  }

  static void readHandymanEarnings(context) {
    FirebaseDatabase.instance
        .ref()
        .child("handyman")
        .child(fAuth.currentUser!.uid)
        .child("earnings")
        .once()
        .then((snap) {
      if (snap.snapshot.value != null) {
        String handymanEarnings = snap.snapshot.value.toString();
        Provider.of<AppInfo>(context, listen: false)
            .updateHandymanTotalEarnings(handymanEarnings);
      }
    });
    readHandymanKeyForOnlineHandymans(context);
  }

  static void readHandymanRatings(context) {
    FirebaseDatabase.instance
        .ref()
        .child("handyman")
        .child(fAuth.currentUser!.uid)
        .child("ratings")
        .once()
        .then((snap) {
      if (snap.snapshot.value != null) {
        String handymanRatings = snap.snapshot.value.toString();
        Provider.of<AppInfo>(context, listen: false)
            .updateHandymanAverageRatings(handymanRatings);
      }
    });
  }
}
