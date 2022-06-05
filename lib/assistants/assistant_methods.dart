import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:flutter_application_reno/all/map_key.dart';
import 'package:flutter_application_reno/assistants/assistant_request.dart';
import 'package:flutter_application_reno/infoHandler/app_info.dart';
import 'package:flutter_application_reno/models/directions.dart';
import 'package:flutter_application_reno/models/handyman_model.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';

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
}
