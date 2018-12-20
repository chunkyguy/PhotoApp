import 'package:flutter/material.dart';
import 'home.dart';
// import 'random_words.dart';

void main() => runApp(PhotoApp());

class PhotoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(title: "Photo App", home: Home());
  }
}
