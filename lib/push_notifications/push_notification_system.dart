import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:flutter_application_reno/models/clientRequest_information.dart';
import 'package:flutter_application_reno/push_notifications/notification_dialog_box.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PushNotificationSystem {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  Future initializeCloudMessaging(BuildContext context) async {
    //1. Terminated
    //When the app is completely closed and opened directly from the push notification
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? remoteMessage) {
      if (remoteMessage != null) {
        //display handyman request information - user information who request a handyman
        readClientHandymanRequestInformtaion(
            remoteMessage.data["handymanRequestId"], context);
      }
    });

    //2. Foreground
    //When the app is open and it receives a push notification
    FirebaseMessaging.onMessage.listen((RemoteMessage? remoteMessage) {
      //display handyman request information - user information who request a handyman
      readClientHandymanRequestInformtaion(
          remoteMessage!.data["handymanRequestId"], context);
    });

    //3. Background
    //When the app is in the background and opened directly from the push notification.
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? remoteMessage) {
      //display handyman request information - user information who request a handyman
      readClientHandymanRequestInformtaion(
          remoteMessage!.data["handymanRequestId"], context);
    });
  }

  readClientHandymanRequestInformtaion(
      String handymanRequestId, BuildContext context) {
    FirebaseDatabase.instance
        .ref()
        .child("All Handyman request")
        .child(handymanRequestId)
        .once()
        .then((snapData) {
      if (snapData.snapshot.value != null) {
        audioPlayer.open(Audio("music/music_notification.mp3"));
        audioPlayer.play();

        String locationAdress = (snapData.snapshot.value! as Map)["Location"];
        String clientTask = (snapData.snapshot.value! as Map)["Choose tasks"];

        String clientName = (snapData.snapshot.value! as Map)["ClientName"];
        String clientPhone = (snapData.snapshot.value! as Map)["ClientPhone"];

        ClientHandymanRequestInformation clientHandymanRequestDetails =
            ClientHandymanRequestInformation();

        clientHandymanRequestDetails.clientName = clientName;
        clientHandymanRequestDetails.clientPhone = clientPhone;
        clientHandymanRequestDetails.locationAdress = locationAdress;
        clientHandymanRequestDetails.clientTask = clientTask;

        showDialog(
          context: context,
          builder: (BuildContext context) => NotificationDialogBox(
            clientHandymanRequestDetails: clientHandymanRequestDetails,
          ),
        );
      } else {
        Fluttertoast.showToast(msg: "This handyman Request Id do not exists.");
      }
    });
  }

  Future generateAndGetToken() async {
    String? registrationToken = await messaging.getToken();
    print("FCM Registration Token: ");
    print(registrationToken);

    FirebaseDatabase.instance
        .ref()
        .child("handyman")
        .child(currentFribaseUser!.uid)
        .child("token")
        .set(registrationToken);

    messaging.subscribeToTopic("allHandymans");
    messaging.subscribeToTopic("allClients");
  }
}
