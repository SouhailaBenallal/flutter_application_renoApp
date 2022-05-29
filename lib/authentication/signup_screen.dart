import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:flutter_application_reno/authentication/handyman_info_screen.dart';
import 'package:flutter_application_reno/authentication/signin_screen.dart';
import 'package:flutter_application_reno/widgets/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nametextEditingController = TextEditingController();
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController phonetextEditingController = TextEditingController();
  TextEditingController pswtextEditingController = TextEditingController();

  validateForm() {
    if (nametextEditingController.text.length < 3) {
      Fluttertoast.showToast(msg: "Name must be atleast 3 Characters");
    } else if (!emailtextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not valid.");
    } else if (phonetextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone Number is required");
    } else if (pswtextEditingController.text.length < 6) {
      Fluttertoast.showToast(msg: "Password must be atleast 6 Characters");
    } else {
      saveHandymanInfo();
    }
  }

  saveHandymanInfo() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Processing, Please wait...",
          );
        });

    final User? firebaseUser = (await fAuth
            .createUserWithEmailAndPassword(
                email: emailtextEditingController.text.trim(),
                password: pswtextEditingController.text.trim())
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error" + msg.toString());
    }))
        .user;

    if (firebaseUser != null) {
      Map handymanMap = {
        "id": firebaseUser.uid,
        "name": nametextEditingController.text.trim(),
        "email": emailtextEditingController.text.trim(),
        "phone": phonetextEditingController.text.trim(),
      };

      DatabaseReference handymanRef =
          FirebaseDatabase.instance.ref().child("handyman");
      handymanRef.child(firebaseUser.uid).set(handymanMap);

      currentFribaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created.");
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => handymanInfoScreen()));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been Created");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Image.asset("images/logo.png"),
          ),
          const SizedBox(height: 10),
          const Text("Register as a Handyman",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.bold)),
          TextField(
              controller: nametextEditingController,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: "Name",
                hintText: "Name",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                labelStyle: TextStyle(color: Colors.black, fontSize: 14),
              )),
          TextField(
              controller: emailtextEditingController,
              keyboardType: TextInputType.emailAddress,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: "Email",
                hintText: "Email",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                labelStyle: TextStyle(color: Colors.black, fontSize: 14),
              )),
          TextField(
              controller: phonetextEditingController,
              keyboardType: TextInputType.phone,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: "Phone",
                hintText: "Phone",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                labelStyle: TextStyle(color: Colors.black, fontSize: 14),
              )),
          TextField(
              controller: pswtextEditingController,
              keyboardType: TextInputType.text,
              obscureText: true,
              style: const TextStyle(color: Colors.black),
              decoration: const InputDecoration(
                labelText: "Password",
                hintText: "Password",
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black)),
                hintStyle: TextStyle(color: Colors.black, fontSize: 10),
                labelStyle: TextStyle(color: Colors.black, fontSize: 14),
              )),
          const SizedBox(height: 20),
          ElevatedButton(
              onPressed: () {
                validateForm();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.black,
              ),
              child: const Text(
                "Create Account",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              )),
          TextButton(
              child: const Text(
                "Already have an account? Login here.",
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (c) => SigninScreen()));
              })
        ]),
      )),
    );
  }
}
