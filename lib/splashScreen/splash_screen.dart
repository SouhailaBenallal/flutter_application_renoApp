import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:flutter_application_reno/authentication/signin_screen.dart';
import 'package:flutter_application_reno/authentication/signup_screen.dart';
import 'package:flutter_application_reno/mainScreens/main_screen.dart';

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({Key? key}) : super(key: key);

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 5), () async {
      if (await fAuth.currentUser != null) {
        currentFribaseUser = fAuth.currentUser;
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => MainScreen()));
      } else {
        // send user to home screen
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => SigninScreen()));
      }
    });
  }

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Image.asset("images/logo.png"),
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}
