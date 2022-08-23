import 'package:firebase_database/firebase_database.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:flutter/material.dart';
import '../../assets/constants.dart';
import '../../assets/widgets.dart';
import 'avialabilityScreen.dart';
import 'package:fluttertoast/fluttertoast.dart';

class SkillsScreen extends StatefulWidget {
  const SkillsScreen({Key? key}) : super(key: key);

  @override
  State<SkillsScreen> createState() => _SkillsScreenState();
}

class _SkillsScreenState extends State<SkillsScreen> {
  saveHandymanSkillsElec() {
    DatabaseReference handyRef =
        FirebaseDatabase.instance.ref().child("handyman");
    handyRef
        .child(currentFribaseUser!.uid)
        .child("handyman_skills")
        .set("Electrician");
    Fluttertoast.showToast(msg: "Handyman Details has been saved.");
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const AvialabiltyScreen()));
  }

  saveHandymanSkillsIns() {
    DatabaseReference handyRef =
        FirebaseDatabase.instance.ref().child("handyman");
    handyRef
        .child(currentFribaseUser!.uid)
        .child("handyman_skills")
        .set("Insolator");
    Fluttertoast.showToast(msg: "Handyman Details has been saved.");
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const AvialabiltyScreen()));
  }

  saveHandymanSkillsPainter() {
    DatabaseReference handyRef =
        FirebaseDatabase.instance.ref().child("handyman");
    handyRef
        .child(currentFribaseUser!.uid)
        .child("handyman_skills")
        .set("Painter");
    Fluttertoast.showToast(msg: "Handyman Details has been saved.");
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const AvialabiltyScreen()));
  }

  saveHandymanSkillsHeatingE() {
    DatabaseReference handyRef =
        FirebaseDatabase.instance.ref().child("handyman");
    handyRef
        .child(currentFribaseUser!.uid)
        .child("handyman_skills")
        .set("Heating Engineer");
    Fluttertoast.showToast(msg: "Handyman Details has been saved.");
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const AvialabiltyScreen()));
  }

  saveHandymanSkillsPlumbing() {
    DatabaseReference handyRef =
        FirebaseDatabase.instance.ref().child("handyman");
    handyRef
        .child(currentFribaseUser!.uid)
        .child("handyman_skills")
        .set("Plumber");
    Fluttertoast.showToast(msg: "Handyman Details has been saved.");
    Navigator.push(
        context, MaterialPageRoute(builder: (c) => const AvialabiltyScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, //change your color here
        ),
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
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
                  "Skills",
                  style: kHeadline2,
                ),
                const SizedBox(height: kBigSpacing),
                Text("Choose your skill", style: kBodyText2),
                const SizedBox(height: kBigSpacing * 2),
                MandatoryStepContainer(
                    title: const Text("Electrician"),
                    function: () {
                      saveHandymanSkillsElec();
                    },
                    trailing: Image.asset("lib/assets/icons/electrician.png")),
                MandatoryStepContainer(
                    title: const Text("Insulator"),
                    function: () {
                      saveHandymanSkillsIns();
                    },
                    trailing: Image.asset("lib/assets/icons/insolator.png")),
                MandatoryStepContainer(
                    title: const Text("Painter"),
                    function: () {
                      saveHandymanSkillsPainter();
                    },
                    trailing: Image.asset("lib/assets/icons/painter.png")),
                MandatoryStepContainer(
                    title: const Text("Heating engineer"),
                    function: () {
                      saveHandymanSkillsHeatingE();
                    },
                    trailing:
                        Image.asset("lib/assets/icons/heatingengineer.png")),
                MandatoryStepContainer(
                    title: const Text("Plumber"),
                    function: () {
                      saveHandymanSkillsPlumbing();
                    },
                    trailing: Image.asset("lib/assets/icons/plumbing.png")),
              ],
            ),
            BigButton(
                title: "Next",
                buttonColor: kColorBlack,
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AvialabiltyScreen(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
