import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_application_reno/all/all.dart';

import '../widgets/info_design_ui.dart';

class AcountScreen extends StatefulWidget {
  const AcountScreen({Key? key}) : super(key: key);
  @override
  State<AcountScreen> createState() => _AcountScreenState();
}

class _AcountScreenState extends State<AcountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            onlineHandymanData.name!,
            style: TextStyle(
                fontSize: 50,
                color: Colors.yellow[700],
                fontWeight: FontWeight.bold),
          ),
          Text(
            titleStartsRating + " handyman",
            style: TextStyle(
                fontSize: 18,
                color: Colors.yellow[700],
                fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
            width: 200,
            child: Divider(
              color: Colors.black,
              height: 2,
              thickness: 2,
            ),
          ),
          const SizedBox(
            height: 38,
          ),
          InfoDesignUIWidget(
            textInfo: onlineHandymanData.phone!,
            iconData: Icons.phone_iphone,
          ),
          InfoDesignUIWidget(
            textInfo: onlineHandymanData.email!,
            iconData: Icons.email,
          ),
          InfoDesignUIWidget(
            textInfo: handymanTaskJob,
            iconData: Icons.task,
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
              onPressed: () {
                fAuth.signOut();
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else if (Platform.isIOS) {
                  exit(0);
                }
              },
              style: ElevatedButton.styleFrom(primary: Colors.yellow[700]),
              child: const Text(
                "Logout",
                style: TextStyle(color: Colors.white),
              ))
        ],
      )),
    );
  }
}
