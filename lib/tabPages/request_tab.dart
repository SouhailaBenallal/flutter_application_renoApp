import 'package:flutter/material.dart';

class RequestTabPage extends StatefulWidget {
  const RequestTabPage({Key? key}) : super(key: key);

  @override
  State<RequestTabPage> createState() => _RequestTabPageState();
}

class _RequestTabPageState extends State<RequestTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Request"),
    );
  }
}
