import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

void main() => runApp(PhotoApp());

class PhotoApp extends StatelessWidget {
  @override 
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: "Photo App",
      home: RandomWords()
    );
  }
}

class RandomWords extends StatefulWidget {
  @override 
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {

  final _suggestions = <WordPair>[];
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Photo App")),
      body: _buildSuggestion(),
    );
  }

  Widget _buildSuggestion() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemBuilder: (context, i) {
        if (i.isOdd) {
          return Divider();
        }
        
        // [1,2,3,4,5] => [0,1,1,2,2]
        final index = i ~/ 2;
        if (index >= _suggestions.length) {
          _suggestions.addAll(generateWordPairs().take(10));
        }
        return _buildRow(_suggestions[index]);
      },
    );
  }

  Widget _buildRow(WordPair word) {
    return ListTile(title: Text(
      word.asPascalCase,
      style: _biggerFont,
      )
      );
  }
}
