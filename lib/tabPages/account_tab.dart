import 'package:flutter/material.dart';
import 'package:flutter_application_reno/all/all.dart';
import 'package:flutter_application_reno/splashScreen/splash_screen.dart';

class AccountTapPage extends StatefulWidget {
  const AccountTapPage({Key? key}) : super(key: key);

  @override
  State<AccountTapPage> createState() => _AccountTapPageState();
}

class _AccountTapPageState extends State<AccountTapPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: ElevatedButton(
      child: const Text(
        "Sign Out",
      ),
      onPressed: () {
        fAuth.signOut();
        Navigator.push(
            context, MaterialPageRoute(builder: (c) => const MySplashScreen()));
      },
    ));
  }
}
