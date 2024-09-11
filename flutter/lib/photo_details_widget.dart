import 'package:flutter/material.dart';
import 'photo_item.dart';

class PhotoDetailsWidget extends StatelessWidget {
  PhotoDetailsWidget({required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Details')),
      body: Column(
        children: <Widget>[
          Image.network(item.url),
          Center(child: Text(item.title)),
        ],
      ),
    );
  }

  final PhotoItem item;
}
