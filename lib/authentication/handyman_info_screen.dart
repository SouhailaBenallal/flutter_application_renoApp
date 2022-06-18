import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:flutter_application_reno/splashScreen/splash_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class handymanInfoScreen extends StatefulWidget {
  @override
  _handymanInfoScreenState createState() => _handymanInfoScreenState();
}

class _handymanInfoScreenState extends State<handymanInfoScreen> {
  TextEditingController skillsTextEditingController = TextEditingController();
  TextEditingController diplomeTextEditingController = TextEditingController();
  TextEditingController vatTextEditingController = TextEditingController();

  List<String> jobTypeList = [
    "Heating engineer",
    "Insulator",
    "Electrician",
    "Painter",
    "Plumber"
  ];

  String? selectedjobType;

  saveHandyInfo() {
    Map handyInfoMap = {
      "skills": skillsTextEditingController.text.trim(),
      "diplome": diplomeTextEditingController.text.trim(),
      "vat": vatTextEditingController.text.trim(),
      "jobtype": selectedjobType
    };

    DatabaseReference handyRef =
        FirebaseDatabase.instance.ref().child("handyman");
    handyRef
        .child(currentFribaseUser!.uid)
        .child("handyman_details")
        .set(handyInfoMap);
    Fluttertoast.showToast(msg: "Handyman Details has been saved.");
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("images/logo.png"),
            ),
            const SizedBox(height: 10),
            const Text("Write handy details",
                style: TextStyle(
                    fontSize: 26,
                    color: Colors.black,
                    fontWeight: FontWeight.bold)),
            TextField(
                controller: skillsTextEditingController,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Job Description",
                  hintText: "Job Description",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                )),
            TextField(
                controller: diplomeTextEditingController,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Certificate/Diplome",
                  hintText: "Certificate/Diplome",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                )),
            TextField(
                controller: vatTextEditingController,
                keyboardType: TextInputType.text,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Extra Info",
                  hintText: "Extra Info",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                )),
            const SizedBox(height: 20),
            DropdownButton(
                iconSize: 30,
                value: selectedjobType,
                hint: const Text(
                  "Please choose your job function",
                  style: TextStyle(fontSize: 14.0, color: Colors.black),
                ),
                onChanged: (newValue) {
                  setState(() {
                    selectedjobType = newValue.toString();
                  });
                },
                items: jobTypeList.map((job) {
                  return DropdownMenuItem(
                    // ignore: sort_child_properties_last
                    child: Text(
                      job,
                      style: const TextStyle(color: Colors.black),
                    ),
                    value: job,
                  );
                }).toList()),
            const SizedBox(height: 20),
            ElevatedButton(
                onPressed: () {
                  if (skillsTextEditingController.text.isNotEmpty &&
                      diplomeTextEditingController.text.isNotEmpty &&
                      vatTextEditingController.text.isNotEmpty &&
                      jobTypeList != null) {
                    saveHandyInfo();
                  }
                  ;
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.black,
                ),
                child: const Text(
                  "Next",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ))
          ],
        ),
      )),
    );
  }
}
