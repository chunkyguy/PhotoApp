import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'photo_list.dart';

class PhotoListWidget extends StatelessWidget {
  PhotoListWidget({this.photoList});

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 2,
      children: List.generate(photoList.items.length, (index) {
        return Image.network(photoList.items[index].thumbUrl);
      }),
    );
  }

  final PhotoList photoList;
}
