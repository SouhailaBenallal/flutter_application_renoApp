import 'package:flutter/material.dart';

class WorklistTabPage extends StatefulWidget {
  const WorklistTabPage({Key? key}) : super(key: key);

  @override
  State<WorklistTabPage> createState() => _WorklistTabPageState();
}

class _WorklistTabPageState extends State<WorklistTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Worklist"),
    );
  }
}
