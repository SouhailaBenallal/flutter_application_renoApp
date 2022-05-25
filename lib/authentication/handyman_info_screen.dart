import 'package:flutter/material.dart';

class handymanInfoScreen extends StatefulWidget {
  @override
  _handymanInfoScreenState createState() => _handymanInfoScreenState();
}

class _handymanInfoScreenState extends State<handymanInfoScreen> {
  TextEditingController skillsTextEditingController = TextEditingController();
  TextEditingController diplomeTextEditingController = TextEditingController();
  TextEditingController vatTextEditingController = TextEditingController();

  List<String> jobTypeList = ["Electricity", "Isolation", "Painting"];

  String? selectedjobType;

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
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Job",
                  hintText: "Job",
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
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Extra",
                  hintText: "Extra",
                  enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.black)),
                  hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                  labelStyle: TextStyle(color: Colors.black, fontSize: 14),
                )),
            TextField(
                controller: vatTextEditingController,
                keyboardType: TextInputType.datetime,
                obscureText: true,
                style: const TextStyle(color: Colors.black),
                decoration: const InputDecoration(
                  labelText: "Certficate",
                  hintText: "Certficate",
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (c) => handymanInfoScreen()));
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
