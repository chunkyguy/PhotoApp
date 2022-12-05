import 'package:flutter/material.dart';
import 'package:photo_app/app_widget.dart';

void main() => runApp(PhotoApp());

class PhotoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Photo App",
      home: Scaffold(
        appBar: AppBar(title: Text('Photo App')),
        body: AppWidget(),
      ),
    );
  }
}
