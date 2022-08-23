import 'package:flutter/material.dart';
import 'package:flutter_application_reno/authentication/signin_screen.dart';
import '../assets/constants.dart';
import '../assets/widgets.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("lib/assets/icons/image.png"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 70,
                  child: Image.asset("lib/assets/icons/logoL.png"),
                ),
                Text(
                  "Welcome to the Reno App",
                  style: kHeadline3,
                ),
                Text(
                  "Join the app to increase your revenues \n and increase your services.",
                  textAlign: TextAlign.center,
                  style: kBodyText2,
                ),
                const SizedBox(height: kBigSpacing * 2),
                Column(
                  children: [
                    BigButton(
                        title: "Login",
                        buttonColor: kColorBlack,
                        function: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SigninScreen(),
                            ),
                          );
                        }),
                    const SizedBox(height: 30.0),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
