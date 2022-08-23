import 'package:flutter/material.dart';
import 'package:flutter_application_reno/tabPages/account_tab.dart';
import 'package:flutter_application_reno/tabPages/ratings_tab.dart';
import 'package:flutter_application_reno/tabPages/earnings_tab.dart';
import 'package:flutter_application_reno/tabPages/worklist_tab.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen>
    with SingleTickerProviderStateMixin {
  TabController? tabController;
  int selectedIndex = 0;

  onItemClicked(int index) {
    setState(() {
      selectedIndex = index;
      tabController!.index = selectedIndex;
    });
  }

  @override
  void initState() {
    super.initState();

    tabController = TabController(length: 4, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: TabBarView(
        // ignore: prefer_const_constructors
        physics: NeverScrollableScrollPhysics(),
        controller: tabController,
        children: [
          WorklistTabPage(),
          EarningsTabPage(),
          RatingsTabPage(),
          const AcountScreen(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Worklist"),
          BottomNavigationBarItem(icon: Icon(Icons.euro), label: "My Earnings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.star_border), label: "My ratings"),
          BottomNavigationBarItem(
              icon: Icon(Icons.account_box_outlined), label: "Account")
        ],
        unselectedItemColor: Colors.grey,
        selectedItemColor: Colors.yellow[700],
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: const TextStyle(fontSize: 14),
        showUnselectedLabels: true,
        currentIndex: selectedIndex,
        onTap: onItemClicked,
      ),
    );
  }
}
