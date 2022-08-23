import 'dart:async';
import 'dart:io';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:flutter_application_reno/assistants/assistant_methods.dart';
import 'package:flutter_application_reno/push_notifications/push_notification_system.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../assistants/black_theme_google_map.dart';

class WorklistTabPage extends StatefulWidget {
  const WorklistTabPage({Key? key}) : super(key: key);

  @override
  State<WorklistTabPage> createState() => _WorklistTabPageState();
}

class _WorklistTabPageState extends State<WorklistTabPage> {
  GoogleMapController? newGoogleMapController;
  final Completer<GoogleMapController> _controllerGoogleMap = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  Position? handymanCurrentPosition;
  var geoLocator = Geolocator();
  LocationPermission? _locationPermission;

  StreamSubscription<Position>? streamSubscriptionPosition;

  checkIfLocationPermissionAllowed() async {
    _locationPermission = await Geolocator.requestPermission();

    if (_locationPermission == LocationPermission.denied) {
      _locationPermission = await Geolocator.requestPermission();
    }
  }

  locateHandymanPosition() async {
    Position cPosition = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    handymanCurrentPosition = cPosition;

    LatLng latLngPosition = LatLng(
        handymanCurrentPosition!.latitude, handymanCurrentPosition!.longitude);

    CameraPosition cameraPosition =
        CameraPosition(target: latLngPosition, zoom: 14);
    newGoogleMapController!
        .animateCamera(CameraUpdate.newCameraPosition(cameraPosition));

    String humanReadableAddress =
        await AssistantMethods.searchAddressForGeographicCoordinates(
            handymanCurrentPosition!, context);
    // print("this is your address = " + humanReadableAddress);
    AssistantMethods.readHandymanRatings(context);
  }

  readCurrentHandymanInformation() async {
    currentFribaseUser = fAuth.currentUser;
    FirebaseDatabase.instance
        .ref()
        .child("handyman")
        .child(currentFribaseUser!.uid)
        .once()
        .then((DatabaseEvent snap) {
      if (snap.snapshot.value != null) {
        onlineHandymanData.id = (snap.snapshot.value as Map)["id"];
        onlineHandymanData.name = (snap.snapshot.value as Map)["name"];
        onlineHandymanData.phone = (snap.snapshot.value as Map)["phone"];
        onlineHandymanData.email = (snap.snapshot.value as Map)["email"];
        onlineHandymanData.diplome =
            (snap.snapshot.value as Map)["handyman_details"]["diplome"];
        onlineHandymanData.skills =
            (snap.snapshot.value as Map)["handyman_details"]["skills"];
        onlineHandymanData.vat =
            (snap.snapshot.value as Map)["handyman_details"]["vat"];
        handymanTaskJob =
            (snap.snapshot.value as Map)["handyman_details"]["jobtype"];

        print('Details');
        print(snap.snapshot.value as Map);
        print(onlineHandymanData.name);
        print(onlineHandymanData.diplome);
      }
    });

    PushNotificationSystem pushNotificationSystem = PushNotificationSystem();
    pushNotificationSystem.initializeCloudMessaging(context);
    pushNotificationSystem.generateAndGetToken();

    AssistantMethods.readHandymanEarnings(context);
  }

  @override
  void initState() {
    super.initState();

    checkIfLocationPermissionAllowed();
    readCurrentHandymanInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          myLocationButtonEnabled: true,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controllerGoogleMap.complete(controller);
            newGoogleMapController = controller;
            // blackThemeGoogleMap(newGoogleMapController);
            locateHandymanPosition();
          },
        ),

        //ui for online offline handyman
        statusText != "Now Online"
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                color: Colors.black87,
              )
            : Container(),

        //button for online offline handyman
        Positioned(
          top: statusText != "Now Online"
              ? MediaQuery.of(context).size.height * 0.46
              : 25,
          left: 0,
          right: 0,
          child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            ElevatedButton(
              onPressed: () {
                if (isHandymanActive != true) {
                  updateHandymansLocationAtRealTime();
                  handyIsOnlineNow();
                  setState(() {
                    statusText = "Now Online";
                    isHandymanActive = true;
                    buttonColor = Colors.transparent;
                  });
                  Fluttertoast.showToast(msg: "You are online now");
                } else {
                  handyIsOfflineNow();
                  setState(() {
                    statusText = "Now Offline";
                    isHandymanActive = false;
                    buttonColor = Colors.grey;
                  });
                  Fluttertoast.showToast(msg: "You are offline now");
                }
              },
              style: ElevatedButton.styleFrom(
                  primary: buttonColor,
                  padding: const EdgeInsets.symmetric(horizontal: 28),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(26))),
              child: statusText != "Now Online"
                  ? Text(
                      statusText,
                      style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    )
                  : const Icon(
                      Icons.phonelink_ring,
                      color: Colors.white,
                      size: 25,
                    ),
            )
          ]),
        )
      ],
    );
  }

  handyIsOnlineNow() async {
    Position pos = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    handymanCurrentPosition = pos;
    Geofire.initialize("activeHandymans");

    Geofire.setLocation(currentFribaseUser!.uid,
        handymanCurrentPosition!.latitude, handymanCurrentPosition!.longitude);
    DatabaseReference ref = FirebaseDatabase.instance
        .ref()
        .child("handyman")
        .child(currentFribaseUser!.uid)
        .child("newHandymanStatus");

    ref.set("idle");
    ref.onValue.listen((event) {});
  }

  updateHandymansLocationAtRealTime() {
    streamSubscriptionPosition =
        Geolocator.getPositionStream().listen((Position position) {
      handymanCurrentPosition = position;

      if (isHandymanActive == true) {
        Geofire.setLocation(
            currentFribaseUser!.uid,
            handymanCurrentPosition!.latitude,
            handymanCurrentPosition!.longitude);
      }

      LatLng latLng = LatLng(
        handymanCurrentPosition!.latitude,
        handymanCurrentPosition!.longitude,
      );

      newGoogleMapController!.animateCamera(CameraUpdate.newLatLng(latLng));
    });
  }

  handyIsOfflineNow() {
    Geofire.removeLocation(currentFribaseUser!.uid);

    DatabaseReference? ref = FirebaseDatabase.instance
        .ref()
        .child("handyman")
        .child(currentFribaseUser!.uid)
        .child("newHandymanStatus");
    ref.onDisconnect();
    ref.remove();
    ref = null;

    Future.delayed(const Duration(microseconds: 2000), () {
      //SystemChannels.platform.invokeListMethod("SystemNavigator.pop");
      if (Platform.isAndroid) {
        SystemNavigator.pop();
      } else if (Platform.isIOS) {
        exit(0);
      }
    });
  }
}
