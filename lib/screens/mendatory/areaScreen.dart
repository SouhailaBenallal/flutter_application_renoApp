import 'package:flutter/material.dart';
import 'package:flutter_application_reno/screens/mendatory/idocScreen.dart';
import '../../assets/constants.dart';
import '../../assets/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class AreaScreen extends StatefulWidget {
  const AreaScreen({Key? key}) : super(key: key);

  @override
  State<AreaScreen> createState() => _AreaScreenState();
}

class _AreaScreenState extends State<AreaScreen> {
  late GoogleMapController mapController;
  MapType _currentMapType = MapType.normal;
  final LatLng _center = const LatLng(50.8503396, 4.3517103);

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  List<String> areaTypeList = [
    "Brussels      1 KM",
    "Brussels      5 KM",
    "Brussels      10 KM",
    "Brussels      15 KM",
    "Brussels      20 KM",
    "Brussels      25 KM",
    "Brussels      30 KM",
    "Brussels      35 KM",
  ];

  String? selectedareaType;

  saveHandyInfoArea() {
    Map handyInfoArea = {"area": selectedareaType};

    DatabaseReference handyRef =
        FirebaseDatabase.instance.ref().child("handyman");
    handyRef
        .child(currentFribaseUser!.uid)
        .child("handyman_area")
        .set(handyInfoArea);
    Fluttertoast.showToast(msg: "Handyman Details has been saved.");
    Navigator.push(context,
        MaterialPageRoute(builder: (c) => const IdentifyDocmuentScreen()));
  }
  // TextEditingController areaTextEditingController = TextEditingController();

  // saveHandymanSkillsHourpay() {
  //   Map handymanArea = {
  //     " 1 Hour": areaTextEditingController.text.trim(),
  //   };

  //   DatabaseReference handyRefHourPay =
  //       FirebaseDatabase.instance.ref().child("handyman");
  //   handyRefHourPay
  //       .child(currentFribaseUser!.uid)
  //       .child("handyman_area")
  //       .set(handymanArea);
  //   Fluttertoast.showToast(msg: "Handyman Details has been saved.");
  //   Navigator.push(
  //       context, MaterialPageRoute(builder: (c) => IdentifyDocmuentScreen()));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.arrow_forward_rounded,
        //         color: kColorBlack,
        //       ))
        // ],
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 30, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Area",
                  style: kHeadline2,
                ),
                const SizedBox(height: kBigSpacing),
                Text("Define your area arround Brussels-Centrum",
                    style: kBodyText2),
                const SizedBox(height: kBigSpacing * 2),
                DropdownButton(
                    iconSize: 30,
                    value: selectedareaType,
                    hint: const Text(
                      "Brussels 1KM",
                      style: TextStyle(fontSize: 14.0, color: Colors.black),
                    ),
                    onChanged: (newValue) {
                      setState(() {
                        selectedareaType = newValue.toString();
                      });
                    },
                    items: areaTypeList.map((job) {
                      return DropdownMenuItem(
                        // ignore: sort_child_properties_last
                        child: Text(
                          job,
                          style: const TextStyle(color: Colors.black),
                        ),
                        value: job,
                      );
                    }).toList()),
              ],
            ),
          ),
          Stack(
            children: [
              Container(
                height: 400,
                child: GoogleMap(
                  mapType: _currentMapType,
                  myLocationButtonEnabled: false,
                  onMapCreated: _onMapCreated,
                  initialCameraPosition: CameraPosition(
                    target: _center,
                    zoom: 14.0,
                  ),
                ),
              )
            ],
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(30.0, 0, 30, 30),
            child: BigButton(
                title: "Next",
                buttonColor: kColorBlack,
                function: () {
                  saveHandyInfoArea();
                }),
          ),
        ],
      ),
    );
  }
}
