import 'package:flutter/material.dart';

class AccountTapPage extends StatefulWidget {
  const AccountTapPage({Key? key}) : super(key: key);

  @override
  State<AccountTapPage> createState() => _AccountTapPageState();
}

class _AccountTapPageState extends State<AccountTapPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text("Account"),
    );
  }
}
