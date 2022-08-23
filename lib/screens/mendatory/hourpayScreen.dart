import 'package:flutter/material.dart';
import 'package:flutter_application_reno/screens/mendatory/areaScreen.dart';
import '../../assets/constants.dart';
import '../../assets/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_reno/all/all.dart';

class HourPayScreen extends StatefulWidget {
  const HourPayScreen({Key? key}) : super(key: key);

  @override
  State<HourPayScreen> createState() => _HourPayScreenState();
}

class _HourPayScreenState extends State<HourPayScreen> {
  TextEditingController hourPayTextEditingController = TextEditingController();

  saveHandymanHourpay() {
    Map handymanHourPay = {
      " 1 Hour": hourPayTextEditingController.text.trim(),
    };

    DatabaseReference handyRefHourPay =
        FirebaseDatabase.instance.ref().child("handyman");
    handyRefHourPay
        .child(currentFribaseUser!.uid)
        .child("handyman_hourpay")
        .set(handymanHourPay);
    Fluttertoast.showToast(msg: "Handyman Details has been saved.");
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const AreaScreen()));
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
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(
                "Hour pay",
                style: kHeadline2,
              ),
              const SizedBox(height: kBigSpacing),
              Text("How much would you like to be paid for a hour?",
                  style: kBodyText2),
              const SizedBox(height: kBigSpacing * 2),
              Text(
                "1 Hour",
                style: kHeadline4,
              ),
              TextField(
                  controller: hourPayTextEditingController,
                  keyboardType: TextInputType.text,
                  style: const TextStyle(color: Colors.black),
                  decoration: const InputDecoration(
                    hintText: "15 €",
                    enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.black)),
                    hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                    labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                  )),
            ]),
            BigButton(
                title: "Next",
                buttonColor: kColorBlack,
                function: () {
                  saveHandymanHourpay();
                }),
          ],
        ),
      ),
    );
  }
}
