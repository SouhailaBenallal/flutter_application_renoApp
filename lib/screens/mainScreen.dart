import 'package:flutter/material.dart';
import 'package:flutter_application_reno/authentication/signin_screen.dart';
import 'package:flutter_application_reno/all/all.dart';

import '../assets/constants.dart';
import '../assets/widgets.dart';

class WorklistScreen extends StatefulWidget {
  const WorklistScreen({Key? key}) : super(key: key);

  @override
  State<WorklistScreen> createState() => _WorklistScreenState();
}

class _WorklistScreenState extends State<WorklistScreen> {
  int selectedIndex = 0;

  List<Widget> getJobsList() {
    List<Widget> jobsList = [
      ListTile(
        onTap: () {},
        dense: true,
        //contentPadding: EdgeInsets.zero,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Text("Repair of wall insulation", style: kHeadline4)),
            Text("3 hours", style: kHeadline4),
          ],
        ),
        subtitle: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Rue Blaes 162", style: kHeadline4),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(child: Text("Wednesday 22/04", style: kHeadline4)),
                Row(
                  children: [
                    SizedBox(
                      width: 75,
                      height: 30,
                      child: DecisionButton(
                          function: () {},
                          title: "Accept",
                          buttonColor: kColorYellow),
                    ),
                    const SizedBox(width: kBigSpacing),
                    SizedBox(
                      width: 75,
                      height: 30,
                      child: DecisionButton(
                          function: () {},
                          title: "Decline",
                          buttonColor: kColorGrey),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: kBigSpacing),
      Divider(color: kColorGrey),
    ];

    return jobsList;
  }

  List<Widget> getAcceptedJobsList() {
    List<Widget> jobsList = [
      const AcceptedJobsListTile(
        isHandymanSide: true,
        typeOfWork: "Repair of wall insulation",
        address: "Rue Blaes 162",
        date: "Wednesday 22/04",
        duration: "3 hours",
      ),
      const SizedBox(height: kBigSpacing),
      // Divider(color: kColorGrey),
    ];

    return jobsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      body: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: selectedIndex == 0
            ? ListView(
                padding: EdgeInsets.zero,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        "lib/assets/icons/logo.png",
                        scale: 6,
                      ),
                      Container(
                        color: Colors.red,
                        height: (MediaQuery.of(context).size.width) / 4 * 5,
                        width: MediaQuery.of(context).size.width,
                        child: const Center(
                            child: Text("CE QUE TU VEUX MONTRER ICI")),
                      ),
                      const SizedBox(height: kBigSpacing),
                      Text("2 jobs nearly", style: kHeadline4),
                      const SizedBox(height: kBigSpacing * 2),
                      Column(children: getJobsList()),
                    ],
                  ),
                ],
              )
            : selectedIndex == 1
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30),
                    child: ListView(
                      padding: EdgeInsets.zero,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Image.asset(
                                "lib/assets/icons/logo.png",
                                scale: 6,
                              ),
                            ),
                            Text(
                              "Tasks Accepted",
                              style: kHeadline3,
                            ),
                            const SizedBox(height: kBigSpacing),
                            Column(children: getAcceptedJobsList()),
                          ],
                        ),
                      ],
                    ),
                  )
                : selectedIndex == 2
                    ? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Image.asset(
                                    "lib/assets/icons/logo.png",
                                    scale: 6,
                                  ),
                                ),
                                Text(
                                  "My Earnings",
                                  style: kHeadline3,
                                ),
                                const SizedBox(height: kBigSpacing * 2),
                                Material(
                                  color: Colors.transparent,
                                  elevation: 10,
                                  child: Container(
                                    height: (MediaQuery.of(context).size.width -
                                            60) /
                                        21 *
                                        9,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      color: kColorYellow,
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(14),
                                      ),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "50 €",
                                        style: kHeadline1.copyWith(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(height: kBigSpacing * 2),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "Total tasks performed:",
                                      style: kHeadline4,
                                    ),
                                    Text(
                                      "2",
                                      style: kHeadline2,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    : Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: ListView(
                          padding: EdgeInsets.zero,
                          children: [
                            SizedBox(
                              height: MediaQuery.of(context).size.height - 120,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Center(
                                        child: Image.asset(
                                          "lib/assets/icons/logo.png",
                                          scale: 6,
                                        ),
                                      ),
                                      Text(
                                        "Account",
                                        style: kHeadline3,
                                      ),
                                      const SizedBox(height: kBigSpacing * 2),
                                      Center(
                                        child: CircleAvatar(
                                          backgroundColor: kColorBlack,
                                          radius: (MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              7.5),
                                          child: CircleAvatar(
                                            backgroundColor: Colors.white,
                                            radius: (MediaQuery.of(context)
                                                        .size
                                                        .width /
                                                    7.5) -
                                                1,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(height: kBigSpacing * 2),
                                      AppFormFieldWithFullBackground(
                                        textValidation: "",
                                        hintText: "Souhaila Ben Halal",
                                        backgroundColor: kColorLightGrey,
                                        borderColor: Colors.transparent,
                                        icon: Icons.account_circle,
                                      ),
                                      const SizedBox(height: kBigSpacing),
                                      AppFormFieldWithFullBackground(
                                        textValidation: "",
                                        hintText: "Sousouben075@gmail.com",
                                        backgroundColor: kColorLightGrey,
                                        borderColor: Colors.transparent,
                                        icon: Icons.alternate_email,
                                      )
                                    ],
                                  ),
                                  BigButton(
                                      title: "Logout",
                                      buttonColor: kColorBlack,
                                      function: () {
                                        fAuth.signOut();
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  SigninScreen()),
                                        );
                                      }),
                                  const SizedBox(height: kBigSpacing * 30),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        backgroundColor: kColorWhite,
        selectedItemColor: kColorBlack,
        unselectedItemColor: kColorGrey,
        selectedFontSize: 14,
        unselectedFontSize: 14,
        onTap: (value) {
          setState(() {
            selectedIndex = value;
          });
        },
        items: const [
          BottomNavigationBarItem(
            label: 'Worklist',
            icon: Icon(Icons.home_filled),
          ),
          BottomNavigationBarItem(
            label: 'Tasks',
            icon: Icon(Icons.list),
          ),
          BottomNavigationBarItem(
            label: 'Earnings',
            icon: Icon(Icons.euro),
          ),
          BottomNavigationBarItem(
            label: 'Account',
            icon: Icon(Icons.account_circle),
          ),
        ],
      ),
    );
  }
}
