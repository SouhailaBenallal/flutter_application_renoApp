import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:flutter_application_reno/authentication/signup_screen.dart';
import 'package:flutter_application_reno/splashScreen/splash_screen.dart';
import 'package:flutter_application_reno/widgets/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../assets/constants.dart';
import '../assets/widgets.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({Key? key}) : super(key: key);

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController pswtextEditingController = TextEditingController();

  validateForm() {
    if (!emailtextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not valid.");
    } else if (pswtextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Password is required");
    } else {
      signinHandymanNow();
    }
  }

  signinHandymanNow() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext c) {
          return ProgressDialog(
            message: "Processing, Please wait...",
          );
        });

    final User? firebaseUser = (await fAuth
            .signInWithEmailAndPassword(
                email: emailtextEditingController.text.trim(),
                password: pswtextEditingController.text.trim())
            .catchError((msg) {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error" + msg.toString());
    }))
        .user;

    if (firebaseUser != null) {
      DatabaseReference handymanRef =
          FirebaseDatabase.instance.ref().child("handyman");
      handymanRef.child(firebaseUser.uid).once().then((handymanKey) {
        final snap = handymanKey.snapshot;
        if (snap.value != null) {
          currentFribaseUser = firebaseUser;
          Fluttertoast.showToast(msg: "Login Successful.");
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => MySplashScreen()));
        } else {
          Fluttertoast.showToast(msg: "No record exist with this email.");
          fAuth.signOut();
          Navigator.push(
              context, MaterialPageRoute(builder: (c) => MySplashScreen()));
        }
      });
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Error Occured during Login.");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: kAppBackgroundColor,
        body: SingleChildScrollView(
            child: SizedBox(
                height: MediaQuery.of(context).size.height,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(children: [
                          Container(
                            height: MediaQuery.of(context).size.width - 120,
                            width: MediaQuery.of(context).size.width - 120,
                            decoration: const BoxDecoration(
                              image: DecorationImage(
                                image: AssetImage("lib/assets/icons/logo.png"),
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              Text(
                                "Login as a Handyman",
                                style: kHeadline2,
                              ),
                              const SizedBox(height: kBigSpacing),
                              TextField(
                                  controller: emailtextEditingController,
                                  keyboardType: TextInputType.emailAddress,
                                  style: const TextStyle(color: Colors.black),
                                  decoration: const InputDecoration(
                                    labelText: "Email",
                                    hintText: "Email",
                                    enabledBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 14),
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
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide:
                                            BorderSide(color: Colors.black)),
                                    hintStyle: TextStyle(
                                        color: Colors.black, fontSize: 10),
                                    labelStyle: TextStyle(
                                        color: Colors.black, fontSize: 14),
                                  )),
                              const SizedBox(height: 10),
                              ElevatedButton(
                                  onPressed: () {
                                    validateForm();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.black,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(7)),
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 100.0, vertical: 15.0),
                                  ),
                                  child: const Text(
                                    "Login",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                    ),
                                  )),
                              TextButton(
                                  child: const Text(
                                    "Don't have an account yet? Sign Up here.",
                                    style: TextStyle(color: Colors.black),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (c) => SignUpScreen()));
                                  })
                            ],
                          ),
                        ])
                      ]),
                ))));
  }
}
