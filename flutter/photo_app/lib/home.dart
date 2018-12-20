import 'package:flutter/material.dart';
import 'chat_screen.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Photo App")), body: ChatScreen());
  }
}
