import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:flutter_application_reno/models/clientRequest_information.dart';
import 'package:flutter_application_reno/widgets/fare_amount_collection_dialog.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../assistants/black_theme_google_map.dart';
import '../widgets/progress_dialog.dart';

class NewTaskScreen extends StatefulWidget {
  ClientHandymanRequestInformation? clientHandymanRequestDetails;
  NewTaskScreen({
    this.clientHandymanRequestDetails,
  });

  @override
  State<NewTaskScreen> createState() => _NewTaskScreenState();
}

class _NewTaskScreenState extends State<NewTaskScreen> {
  GoogleMapController? newGoogleMapController;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  String? buttonTitle = "Can we start";
  Color? buttonColor = Colors.green;
  String handymanRequestStatus = "accepted";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveAssignedHandymanDetailsToClientRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // google map
          GoogleMap(
            mapType: MapType.normal,
            myLocationButtonEnabled: true,
            initialCameraPosition: _kGooglePlex,
            onMapCreated: (GoogleMapController controller) {
              _controllerGoogleMap.complete(controller);
              newGoogleMapController = controller;
              // blackThemeGoogleMap(newGoogleMapController);
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white,
                        blurRadius: 18,
                        spreadRadius: .5,
                        offset: Offset(0.6, 0.6))
                  ]),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 25, vertical: 20),
                child: Column(children: [
                  // Task
                  const Text(
                    "All Information of client",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  // User name - icon
                  const SizedBox(
                    height: 18,
                  ),
                  const Divider(
                    thickness: 2,
                    height: 2,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 8,
                  ),

                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          child: Text(
                            widget.clientHandymanRequestDetails!.clientName!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      const Icon(
                        Icons.phone_android,
                        color: Colors.white,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  // Description
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

                  // Location

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
                  const SizedBox(
                    height: 24,
                  ),
                  const Divider(
                    thickness: 2,
                    height: 2,
                    color: Colors.grey,
                  ),
                  const SizedBox(height: 10.0),
                  ElevatedButton.icon(
                      onPressed: () {
                        if (handymanRequestStatus == "accepted") {
                          handymanRequestStatus = "arrived";

                          FirebaseDatabase.instance
                              .ref()
                              .child("All Handyman request")
                              .child(widget.clientHandymanRequestDetails!
                                  .handymanRequestId!)
                              .child("status")
                              .set(handymanRequestStatus);

                          setState(() {
                            buttonTitle = "Let's started";
                            buttonColor = Colors.yellow[700];
                          });

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext c) => ProgressDialog(
                              message: "Loading...",
                            ),
                          );

                          Navigator.pop(context);
                        } else if (handymanRequestStatus == "arrived") {
                          handymanRequestStatus = "busyTask";

                          FirebaseDatabase.instance
                              .ref()
                              .child("All Handyman request")
                              .child(widget.clientHandymanRequestDetails!
                                  .handymanRequestId!)
                              .child("status")
                              .set(handymanRequestStatus);

                          setState(() {
                            buttonTitle = "Finish";
                            buttonColor = Colors.redAccent;
                          });
                        } else if (handymanRequestStatus == "busyTask") {
                          endTaskNow();
                        }
                      },
                      style: ElevatedButton.styleFrom(primary: buttonColor),
                      icon: const Icon(
                        Icons.task,
                        color: Colors.white,
                        size: 25,
                      ),
                      label: Text(
                        buttonTitle!,
                        style: const TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      )),
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }

  endTaskNow() async {
    FirebaseDatabase.instance
        .ref()
        .child("All Handyman request")
        .child(widget.clientHandymanRequestDetails!.handymanRequestId!)
        .child("status")
        .set("ended");

    calculateFareAmount() {
      if (handymanTaskJob == "Heating engineer") {
        double resultFareAmount = 50;
        return resultFareAmount;
      } else if (handymanTaskJob == "Insulator") {
        double resultFareAmount = 60;
        return resultFareAmount;
      } else if (handymanTaskJob == "Electrician") {
        double resultFareAmount = 65;
        return resultFareAmount;
      } else if (handymanTaskJob == "Painter") {
        double resultFareAmount = 30;
        return resultFareAmount;
      } else if (handymanTaskJob == "Painter") {
        double resultFareAmount = 55;
        return resultFareAmount;
      }
    }

    double totalFareAmount = double.parse(calculateFareAmount().toString());

    // FirebaseDatabase.instance
    //     .ref()
    //     .child("All Handyman request")
    //     .child(widget.clientHandymanRequestDetails!.handymanRequestId!)
    //     .child("totalFareAmount")
    //     .set("Last Thing");
    FirebaseDatabase.instance
        .ref()
        .child("All Handyman request")
        .child(widget.clientHandymanRequestDetails!.handymanRequestId!)
        .child("totalFareAmount")
        .set(totalFareAmount);

    Navigator.pop(context);
    showDialog(
        context: context,
        builder: (BuildContext c) =>
            FareAmountCollectionDialog(totalFareAmount: totalFareAmount));
    saveFareAmountToHandaymanEarnings(totalFareAmount);
  }

  saveFareAmountToHandaymanEarnings(double totalFareAmount) {
    FirebaseDatabase.instance
        .ref()
        .child("handyman")
        .child(currentFribaseUser!.uid)
        .child("earnings")
        .once()
        .then((snap) {
      if (snap.snapshot.value != null) {
        double oldEarnings = double.parse(snap.snapshot.value.toString());
        double handymanTotalEarnings = totalFareAmount + oldEarnings;
        FirebaseDatabase.instance
            .ref()
            .child("handyman")
            .child(currentFribaseUser!.uid)
            .child("earnings")
            .set(handymanTotalEarnings.toString());
      } else {
        FirebaseDatabase.instance
            .ref()
            .child("handyman")
            .child(currentFribaseUser!.uid)
            .child("earnings")
            .set(totalFareAmount.toString());
      }
    });
  }

  saveAssignedHandymanDetailsToClientRequest() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("All Handyman request")
        .child(widget.clientHandymanRequestDetails!.handymanRequestId!);

    databaseReference.child("status").set("Accepted");
    databaseReference.child("handymanId").set(onlineHandymanData.id);
    databaseReference.child("handymanName").set(onlineHandymanData.name);
    databaseReference.child("handymanPhone").set(onlineHandymanData.phone);
    databaseReference.child("handyman_details").set(handymanTaskJob.toString());

    // saveHandymanRequestIdToHandymanHistory();
  }

  // saveHandymanRequestIdToHandymanHistory() {
  //   DatabaseReference handymansHistoryRef = FirebaseDatabase.instance
  //       .ref()
  //       .child("handyman")
  //       .child(currentFribaseUser!.uid)
  //       .child("handymansHistory");
  //   handymansHistoryRef
  //       .child(widget.clientHandymanRequestDetails!.handymanRequestId!)
  //       .set(true);
  // }
}
