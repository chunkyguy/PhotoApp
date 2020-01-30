import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:photo_app/photo_list.dart';
import 'photo_list.dart';

class AppController {
  Stream<PhotoList> get photoList => _fetchData().asStream();

  Future<PhotoList> _fetchData() async {
    final response =
        await http.get('https://jsonplaceholder.typicode.com/photos');
    if (response.statusCode == 200) {
      return PhotoList.fromJson(json: json.decode(response.body));
    } else {
      throw Exception('Unable to parse data');
    }
  }
}
