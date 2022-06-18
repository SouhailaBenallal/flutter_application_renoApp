import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:flutter_application_reno/mainScreens/task_screen.dart';
import 'package:flutter_application_reno/models/clientRequest_information.dart';
import 'package:fluttertoast/fluttertoast.dart';

class NotificationDialogBox extends StatefulWidget {
  ClientHandymanRequestInformation? clientHandymanRequestDetails;

  NotificationDialogBox({this.clientHandymanRequestDetails});

  @override
  State<NotificationDialogBox> createState() => _NotificationDialogBoxState();
}

class _NotificationDialogBoxState extends State<NotificationDialogBox> {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      backgroundColor: Colors.transparent,
      elevation: 2,
      child: Container(
        margin: const EdgeInsets.all(8),
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 14,
            ),

            Image.asset(
              "images/logo.png",
              width: 160,
            ),

            const SizedBox(
              height: 10,
            ),

            //title
            Text(
              "New Handyman Request",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 22,
                  color: Colors.yellow[700]),
            ),

            const SizedBox(height: 14.0),

            const Divider(
              height: 3,
              thickness: 3,
            ),

            //addresses origin destination
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  //origin location with icon
                  Row(
                    children: [
                      Image.asset(
                        "images/task.png",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.clientHandymanRequestDetails!.clientTask!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20.0),

                  //destination location with icon
                  Row(
                    children: [
                      Image.asset(
                        "images/location.png",
                        width: 30,
                        height: 30,
                      ),
                      const SizedBox(
                        width: 14,
                      ),
                      Expanded(
                        child: Container(
                          child: Text(
                            widget
                                .clientHandymanRequestDetails!.locationAdress!,
                            style: const TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const Divider(
              height: 3,
              thickness: 3,
            ),

            //buttons cancel accept
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                    ),
                    onPressed: () {
                      audioPlayer.pause();
                      audioPlayer.stop();
                      audioPlayer = AssetsAudioPlayer();

                      //cancel the rideRequest
                      FirebaseDatabase.instance
                          .ref()
                          .child("All Handyman request")
                          .child(widget
                              .clientHandymanRequestDetails!.handymanRequestId!)
                          .remove()
                          .then((value) {
                        FirebaseDatabase.instance
                            .ref()
                            .child("handyman")
                            .child(currentFribaseUser!.uid)
                            .child("newHandymanStatus")
                            .set("idle");
                      }).then((value) {
                        FirebaseDatabase.instance
                            .ref()
                            .child("handyman")
                            .child(currentFribaseUser!.uid)
                            .child("handymansHistory")
                            .child(widget.clientHandymanRequestDetails!
                                .handymanRequestId!)
                            .remove();
                      }).then((value) {
                        Fluttertoast.showToast(
                            msg:
                                "Handyman Request has been Cancelled. Successfully. Restart App Now");
                      });

                      Future.delayed(const Duration(milliseconds: 2000), () {
                        SystemNavigator.pop();
                      });
                    },
                    child: Text(
                      "Cancel".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                  const SizedBox(width: 25.0),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                    ),
                    onPressed: () {
                      audioPlayer.pause();
                      audioPlayer.stop();
                      audioPlayer = AssetsAudioPlayer();

                      //accept the rideRequest
                      acceptHandymanRequest(context);
                    },
                    child: Text(
                      "Accept".toUpperCase(),
                      style: const TextStyle(
                        fontSize: 14.0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  acceptHandymanRequest(BuildContext context) {
    String getHandymanRequestId = "";
    FirebaseDatabase.instance
        .ref()
        .child("handyman")
        .child(currentFribaseUser!.uid)
        .child("newHandymanStatus")
        .once()
        .then((snap) {
      if (snap.snapshot.value != null) {
        getHandymanRequestId = snap.snapshot.value.toString();
      } else {
        Fluttertoast.showToast(msg: "This handyman request do not exists");
      }

      if (getHandymanRequestId ==
          widget.clientHandymanRequestDetails!.handymanRequestId) {
        FirebaseDatabase.instance
            .ref()
            .child("handyman")
            .child(currentFribaseUser!.uid)
            .child("newHandymanStatus")
            .set("accepted");

        // send handyman to newHandymanStatus
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => NewTaskScreen(
                      clientHandymanRequestDetails:
                          widget.clientHandymanRequestDetails,
                    )));
      } else {
        Fluttertoast.showToast(msg: "This handyman request do not exixists");
      }
    });
  }
}
