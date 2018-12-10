import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(PhotoApp());

class PhotoApp extends StatelessWidget {
  @override Widget build(BuildContext context) {
    final word = WordPair.random();
    return new MaterialApp(
      title: "Photo App",
      home: Scaffold(
        appBar: AppBar(title: Text("Photo App")),
        body: Center(child: Text("How you doing? ${word.asPascalCase}")),
      ),
    );
  }
}
