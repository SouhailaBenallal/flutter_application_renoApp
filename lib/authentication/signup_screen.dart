import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_reno/all/all.dart';
// import 'package:flutter_application_reno/authentication/handyman_info_screen.dart';
import 'package:flutter_application_reno/authentication/signin_screen.dart';
import 'package:flutter_application_reno/screens/mendatory/mendatoryScreen.dart';
import 'package:flutter_application_reno/widgets/progress_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:country_picker/country_picker.dart';
import '../assets/constants.dart';
import '../assets/widgets.dart';

class SignUpScreen extends StatefulWidget {
  String selectedCountry = "🇧🇪  Belgium";
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nametextEditingController = TextEditingController();
  TextEditingController emailtextEditingController = TextEditingController();
  TextEditingController phonetextEditingController = TextEditingController();
  TextEditingController adressEditingController = TextEditingController();
  TextEditingController pswtextEditingController = TextEditingController();
  String selectedCountry = "🇧🇪  Belgium";

  validateForm() {
    if (nametextEditingController.text.length < 3) {
      Fluttertoast.showToast(msg: "Name must be atleast 3 Characters");
    } else if (!emailtextEditingController.text.contains("@")) {
      Fluttertoast.showToast(msg: "Email address is not valid.");
    } else if (phonetextEditingController.text.isEmpty) {
      Fluttertoast.showToast(msg: "Phone Number is required");
    } else if (adressEditingController.text.length < 6) {
      Fluttertoast.showToast(msg: "Adress is required");
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
        "adress": adressEditingController.text.trim(),
        "country": selectedCountry,
      };

      DatabaseReference handymanRef =
          FirebaseDatabase.instance.ref().child("handyman");
      handymanRef.child(firebaseUser.uid).set(handymanMap);

      currentFribaseUser = firebaseUser;
      Fluttertoast.showToast(msg: "Account has been Created.");
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => MendatoryScreen()));
    } else {
      Navigator.pop(context);
      Fluttertoast.showToast(msg: "Account has not been Created");
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
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: MediaQuery.of(context).size.width - 100,
                        width: MediaQuery.of(context).size.width - 100,
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
                            "Register as a Handyman",
                            style: kHeadline2,
                          ),
                        ],
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
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 10),
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 14),
                          )),
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
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 10),
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 14),
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
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 10),
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 14),
                          )),
                      TextField(
                          controller: adressEditingController,
                          keyboardType: TextInputType.text,
                          style: const TextStyle(color: Colors.black),
                          decoration: const InputDecoration(
                            labelText: "Adress",
                            hintText: "Adress",
                            enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.black)),
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 10),
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 14),
                          )),
                      MandatoryStepContainer(
                          spacing: 0,
                          function: () {
                            showCountryPicker(
                                context: context,
                                countryListTheme: CountryListThemeData(
                                  flagSize: 25,
                                  backgroundColor: Colors.white,
                                  textStyle: const TextStyle(
                                      fontSize: 16, color: Colors.blueGrey),
                                  bottomSheetHeight:
                                      500, // Optional. Country list modal height
                                  //Optional. Sets the border radius for the bottomsheet.
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                  //Optional. Styles the search field.
                                  inputDecoration: InputDecoration(
                                    labelText: 'Select',
                                    hintText: 'Start typing to search',
                                    prefixIcon: const Icon(Icons.search),
                                    border: OutlineInputBorder(
                                      borderSide: BorderSide(
                                        color: const Color(0xFF8C98A8)
                                            .withOpacity(0.2),
                                      ),
                                    ),
                                  ),
                                ),
                                onSelect: (Country country) {
                                  setState(() {
                                    widget.selectedCountry =
                                        "${country.flagEmoji}  ${country.name}";
                                  });
                                });
                          },
                          trailing: null,
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(widget.selectedCountry.toString(),
                                  style: kHeadline5),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {},
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        RotatedBox(
                                          quarterTurns: 3,
                                          child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 10,
                                            color: kColorBlack,
                                          ),
                                        ),
                                        RotatedBox(
                                          quarterTurns: 1,
                                          child: Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            size: 10,
                                            color: kColorBlack,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
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
                            hintStyle:
                                TextStyle(color: Colors.black, fontSize: 10),
                            labelStyle:
                                TextStyle(color: Colors.black, fontSize: 14),
                          )),
                      const SizedBox(height: 20),
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
                                context,
                                MaterialPageRoute(
                                    builder: (c) => const SigninScreen()));
                          })
                    ]),
              )),
        ));
  }
}
