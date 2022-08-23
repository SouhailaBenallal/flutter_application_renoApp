import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../infoHandler/app_info.dart';
import '../widgets/history_design_ui.dart';

class HandymansHistoryScreen extends StatefulWidget {
  @override
  State<HandymansHistoryScreen> createState() => _HandymansHistoryScreenState();
}

class _HandymansHistoryScreenState extends State<HandymansHistoryScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: const Text("Handyman History"),
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            if (Platform.isAndroid) {
              SystemNavigator.pop();
            } else if (Platform.isIOS) {
              exit(0);
            }
          },
        ),
      ),
      body: ListView.separated(
        separatorBuilder: (context, i) => const Divider(
          color: Colors.grey,
          thickness: 2,
          height: 2,
        ),
        itemBuilder: (context, i) {
          return Card(
            color: Colors.white54,
            child: HistoryDesignUiWidget(
              handymanHistoryModel: Provider.of<AppInfo>(context, listen: false)
                  .allHandymansHistoryInformationList[i],
            ),
          );
        },
        itemCount: Provider.of<AppInfo>(context, listen: false)
            .allHandymansHistoryInformationList
            .length,
        physics: const ClampingScrollPhysics(),
        shrinkWrap: true,
      ),
    );
  }
}
