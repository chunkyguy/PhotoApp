import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  @override
  RandomWordsState createState() => RandomWordsState();
}

class RandomWordsState extends State<RandomWords> {
  final _suggestions = <WordPair>[];
  final _saved = Set<WordPair>();
  final _biggerFont = const TextStyle(fontSize: 18.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Photo App"),
        actions: <Widget>[
          IconButton(icon: const Icon(Icons.list), onPressed: onDetails,)
        ],
        ),
      body: _buildSuggestion(),
    );
  }

  void onDetails() {
    Navigator.of(context).push(
      MaterialPageRoute<void>(
        builder: (BuildContext context) {

          final Iterable<ListTile> tiles = _saved.map((WordPair word) {
            return ListTile(title: Text(word.asPascalCase, style: _biggerFont));
          });

          final List<Widget> children = ListTile.divideTiles(context: context, tiles: tiles).toList();

          return Scaffold(
            appBar: AppBar(title: const Text('Favorites')),
            body: ListView(children: children)
          );
        }
      )
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
    final isSaved = _saved.contains(word);
    return ListTile(
      title: Text(
        word.asPascalCase,
        style: _biggerFont,
      ),
      trailing: Icon(
        isSaved ? Icons.favorite : Icons.favorite_border,
        color: isSaved ? Colors.red : null,
      ),
      onTap: () {
        setState((){
          if (isSaved) {
            _saved.remove(word);
          } else {
            _saved.add(word);
          }
        });
      },
    );
  }
}
