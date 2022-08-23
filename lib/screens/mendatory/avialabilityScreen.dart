import 'package:flutter/material.dart';
import '../../assets/constants.dart';
import '../../assets/widgets.dart';
import 'hourpayScreen.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AvialabiltyScreen extends StatefulWidget {
  const AvialabiltyScreen({Key? key}) : super(key: key);

  @override
  State<AvialabiltyScreen> createState() => _AvialabiltyScreenState();
}

class _AvialabiltyScreenState extends State<AvialabiltyScreen> {
  TextEditingController mHourTextEditingController = TextEditingController();
  TextEditingController tuHourTextEditingController = TextEditingController();
  TextEditingController wHourTextEditingController = TextEditingController();
  TextEditingController thHourTextEditingController = TextEditingController();
  TextEditingController fHourTextEditingController = TextEditingController();
  TextEditingController satHourTextEditingController = TextEditingController();
  TextEditingController sunHourTextEditingController = TextEditingController();

  saveHandymanAvilabilityHoursDays() {
    Map handymanAvilabilityHoursDays = {
      "Monday": mHourTextEditingController.text.trim(),
      "Tuesday": tuHourTextEditingController.text.trim(),
      "Wednesday": wHourTextEditingController.text.trim(),
      "Thursday": thHourTextEditingController.text.trim(),
      "Friday": fHourTextEditingController.text.trim(),
      "Saturday": satHourTextEditingController.text.trim(),
      "Sunday": sunHourTextEditingController.text.trim(),
    };

    DatabaseReference handyRefHoursDay =
        FirebaseDatabase.instance.ref().child("handyman");
    handyRefHoursDay
        .child(currentFribaseUser!.uid)
        .child("handyman_avilability")
        .set(handymanAvilabilityHoursDays);
    Fluttertoast.showToast(msg: "Handyman Details has been saved.");
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const HourPayScreen()));
  }

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
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Availability",
                  style: kHeadline2,
                ),
                const SizedBox(height: kBigSpacing),
                Text("Fill in your availability", style: kBodyText2),
                const SizedBox(height: kBigSpacing * 2),
                Text(
                  "Monday",
                  style: kHeadline4,
                ),
                TextField(
                    controller: mHourTextEditingController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "00:00-23:59",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                      labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    )),
                const SizedBox(height: kBigSpacing * 2),
                Text(
                  "Tuesday",
                  style: kHeadline4,
                ),
                TextField(
                    controller: tuHourTextEditingController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "00:00-23:59",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                      labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    )),
                const SizedBox(height: kBigSpacing * 2),
                Text(
                  "Wednesday",
                  style: kHeadline4,
                ),
                TextField(
                    controller: wHourTextEditingController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "00:00-23:59",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                      labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    )),
                const SizedBox(height: kBigSpacing * 2),
                Text(
                  "Thursday",
                  style: kHeadline4,
                ),
                TextField(
                    controller: thHourTextEditingController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "00:00-23:59",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                      labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    )),
                const SizedBox(height: kBigSpacing * 2),
                Text(
                  "Friday",
                  style: kHeadline4,
                ),
                TextField(
                    controller: fHourTextEditingController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "00:00-23:59",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                      labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    )),
                const SizedBox(height: kBigSpacing * 2),
                Text(
                  "Saturday",
                  style: kHeadline4,
                ),
                TextField(
                    controller: satHourTextEditingController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "00:00-23:59",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                      labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    )),
                const SizedBox(height: kBigSpacing * 2),
                Text(
                  "Sunday",
                  style: kHeadline4,
                ),
                TextField(
                    controller: sunHourTextEditingController,
                    keyboardType: TextInputType.text,
                    style: const TextStyle(color: Colors.black),
                    decoration: const InputDecoration(
                      hintText: "00:00-23:59",
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.black)),
                      hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                      labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                    )),
              ],
            ),
            BigButton(
                title: "Next",
                buttonColor: kColorBlack,
                function: () {
                  saveHandymanAvilabilityHoursDays();
                }),
          ],
        ),
      ),
    );
  }
}
