import 'dart:async';

import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:flutter_application_reno/models/clientRequest_information.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../assistants/black_theme_google_map.dart';

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

  String? buttonTitle = "Begin";
  Color? buttonColor = Colors.green;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    saveAssignedHandymanDetailsToClientHandymanRequest();
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
              blackThemeGoogleMap(newGoogleMapController);
            },
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              decoration: const BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(18),
                  ),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.white30,
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
                    "Lorem ipsum",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.lightGreenAccent,
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
                    children: const [
                      Text(
                        "User name",
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.lightGreenAccent,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(10.0),
                      ),
                      Icon(
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
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(primary: buttonColor),
                      icon: const Icon(
                        Icons.task,
                        color: Colors.white,
                        size: 25,
                      ),
                      label: Text(
                        buttonTitle!,
                        style: const TextStyle(
                            color: Colors.white,
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

  saveAssignedHandymanDetailsToClientHandymanRequest() {
    DatabaseReference databaseReference = FirebaseDatabase.instance
        .ref()
        .child("All Handyman request")
        .child(widget.clientHandymanRequestDetails!.handymanRequestId!);

    // Map handymanLocationDataMap = {
    //   "latitude" : c
    // };

    databaseReference.child("status").set("accepted");
    databaseReference.child("handymanId").set(onlineHandymanData.id);
    databaseReference.child("handymanName").set(onlineHandymanData.name);
    databaseReference.child("handymanPhone").set(onlineHandymanData.phone);
    databaseReference.child("handyman_details").set(
        onlineHandymanData.skills.toString() +
            onlineHandymanData.vat.toString() +
            onlineHandymanData.diplome.toString());

    saveHandymanRequestIdToHandymanHistory();
  }

  saveHandymanRequestIdToHandymanHistory() {
    DatabaseReference tripsHistoryRef = FirebaseDatabase.instance
        .ref()
        .child("handyman")
        .child(currentFribaseUser!.uid)
        .child("tripsHistory");
    tripsHistoryRef
        .child(widget.clientHandymanRequestDetails!.handymanRequestId!)
        .set(true);
  }
}
