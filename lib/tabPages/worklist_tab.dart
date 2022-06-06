import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:flutter_application_reno/assistants/assistant_methods.dart';
import 'package:flutter_geofire/flutter_geofire.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

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

  String statusText = "Now Offline";
  Color buttonColor = Colors.grey;
  bool isHandymanActive = false;
  StreamSubscription<Position>? streamSubscriptionPosition;

  blackThemeGoogleMap() {
    // Black theme
    // https://drive.google.com/file/d/1wxFaewOHc5MLnLB2r_tElElQZalv-Nxc/view
    // https://www.youtube.com/watch?v=NBT053E039A&list=PLxefhmF0pcPmc4AOB6es_8Tby70Ngnh2T&index=19&t=425s
    newGoogleMapController!.setMapStyle('''
                    [
                      {
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#242f3e"
                          }
                        ]
                      },
                      {
                        "featureType": "administrative.locality",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#263c3f"
                          }
                        ]
                      },
                      {
                        "featureType": "poi.park",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#6b9a76"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#38414e"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#212a37"
                          }
                        ]
                      },
                      {
                        "featureType": "road",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#9ca5b3"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#746855"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "geometry.stroke",
                        "stylers": [
                          {
                            "color": "#1f2835"
                          }
                        ]
                      },
                      {
                        "featureType": "road.highway",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#f3d19c"
                          }
                        ]
                      },
                      {
                        "featureType": "transit",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#2f3948"
                          }
                        ]
                      },
                      {
                        "featureType": "transit.station",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#d59563"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "geometry",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.fill",
                        "stylers": [
                          {
                            "color": "#515c6d"
                          }
                        ]
                      },
                      {
                        "featureType": "water",
                        "elementType": "labels.text.stroke",
                        "stylers": [
                          {
                            "color": "#17263c"
                          }
                        ]
                      }
                    ]
                ''');
  }

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
    print("this is your address = " + humanReadableAddress);
  }

  @override
  void initState() {
    super.initState();

    checkIfLocationPermissionAllowed();
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
            blackThemeGoogleMap();
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
                // updateDriversLocationAtRealTime();
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
        .child("newLocationPlaceStatus");

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
        .child("newLocationPlaceStatus");
    ref.onDisconnect();
    ref.remove();
    ref = null;

    Future.delayed(const Duration(microseconds: 2000), () {
      //SystemChannels.platform.invokeListMethod("SystemNavigator.pop");
      SystemNavigator.pop();
    });
  }
}
