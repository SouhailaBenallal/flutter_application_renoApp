import 'package:flutter/material.dart';
import 'package:flutter_application_reno/infoHandler/app_info.dart';
import 'package:flutter_application_reno/mainScreens/handymans_history_screen.dart';
import 'package:provider/provider.dart';

class EarningsTabPage extends StatefulWidget {
  EarningsTabPage({Key? key}) : super(key: key);

  @override
  State<EarningsTabPage> createState() => _EarningsTabPageState();
}

class _EarningsTabPageState extends State<EarningsTabPage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Column(children: [
        // earnings
        Container(
          color: Colors.black,
          width: double.infinity,
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 80),
            child: Column(children: [
              Text(
                "Your Earnings:",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
              SizedBox(
                height: 16,
              ),
              Text(
                " \€" +
                    Provider.of<AppInfo>(context, listen: false)
                        .handymanTotalEarnings,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 60,
                    fontWeight: FontWeight.bold),
              )
            ]),
          ),
        ),
        //total
        ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (c) => HandymansHistoryScreen()));
            },
            style: ElevatedButton.styleFrom(primary: Colors.white54),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Image.asset(
                    "images/logo.png",
                    width: 100,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  const Text(
                    "Total tasks performed",
                    style: TextStyle(color: Colors.black54),
                  ),
                  Expanded(
                    child: Container(
                      child: Text(
                        Provider.of<AppInfo>(context, listen: false)
                            .allHandymansHistoryInformationList
                            .length
                            .toString(),
                        textAlign: TextAlign.end,
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  )
                ],
              ),
            ))
      ]),
    );
  }
}
