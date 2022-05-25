import 'package:flutter/material.dart';

class ChatsTabPage extends StatefulWidget {
  const ChatsTabPage({Key? key}) : super(key: key);

  @override
  State<ChatsTabPage> createState() => _ChatsTabPageState();
}

class _ChatsTabPageState extends State<ChatsTabPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Chats"),
    );
  }
}
