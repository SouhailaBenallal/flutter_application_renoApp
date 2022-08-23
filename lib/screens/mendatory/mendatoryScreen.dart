import 'package:flutter/material.dart';
import '../../assets/constants.dart';
import '../../assets/widgets.dart';
import 'skillsScreen.dart';

class MendatoryScreen extends StatefulWidget {
  const MendatoryScreen({Key? key}) : super(key: key);

  @override
  State<MendatoryScreen> createState() => _MendatoryScreenState();
}

class _MendatoryScreenState extends State<MendatoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kAppBackgroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        // actions: [
        //   IconButton(
        //       onPressed: () {},
        //       icon: Icon(
        //         Icons.close,
        //         color: kColorBlack,
        //       ))
        // ],
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
                  "Welcome, Souhaila",
                  style: kHeadline2,
                ),
                const SizedBox(height: kBigSpacing),
                Text(
                    "Here is a list of things you need to do before you can apply for jobs",
                    style: kBodyText2),
                const SizedBox(height: kBigSpacing * 2),
                Text(
                  "Mandatory steps",
                  style: kHeadline3,
                ),
                const SizedBox(height: kBigSpacing),
                MandatoryStepContainer(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.circle,
                        color: kColorYellow,
                        size: 12,
                      ),
                      const SizedBox(width: kBigSpacing / 2),
                      const Text("Indicate your skills"),
                    ],
                  ),
                  function: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SkillsScreen(),
                      ),
                    );
                  },
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: kColorBlack,
                    size: 15,
                  ),
                ),
                MandatoryStepContainer(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.circle,
                        color: kColorYellow,
                        size: 12,
                      ),
                      const SizedBox(width: kBigSpacing / 2),
                      const Text("Fill in your availability"),
                    ],
                  ),
                  function: () {},
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: kColorBlack,
                    size: 15,
                  ),
                ),
                MandatoryStepContainer(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.circle,
                        color: kColorYellow,
                        size: 12,
                      ),
                      const SizedBox(width: kBigSpacing / 2),
                      const Text("Define your pay"),
                    ],
                  ),
                  function: () {},
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: kColorBlack,
                    size: 15,
                  ),
                ),
                MandatoryStepContainer(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.circle,
                        color: kColorYellow,
                        size: 12,
                      ),
                      const SizedBox(width: kBigSpacing / 2),
                      const Text("Define your area of intervention"),
                    ],
                  ),
                  function: () {},
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: kColorBlack,
                    size: 15,
                  ),
                ),
                MandatoryStepContainer(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.circle,
                        color: kColorYellow,
                        size: 12,
                      ),
                      const SizedBox(width: kBigSpacing / 2),
                      const Text("Valid identity documents"),
                    ],
                  ),
                  function: () {},
                  trailing: Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: kColorBlack,
                    size: 15,
                  ),
                ),
              ],
            ),
            BigButton(
                title: "Let's Go",
                buttonColor: kColorBlack,
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SkillsScreen(),
                    ),
                  );
                }),
          ],
        ),
      ),
    );
  }
}
