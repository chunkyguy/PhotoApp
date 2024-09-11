import 'photo_item.dart';

class PhotoList {
  PhotoList({required this.items});

  factory PhotoList.fromJson({required List<dynamic> json}) {
    final list =
        json.map((itemJson) => PhotoItem.fromJson(json: itemJson)).toList();
    return PhotoList(items: list);
  }

  final List<PhotoItem> items;
}
