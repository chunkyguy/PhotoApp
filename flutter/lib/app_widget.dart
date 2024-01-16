import 'package:flutter/material.dart';
import 'photo_list_widget.dart';
import 'app_controller.dart';
import 'photo_list.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: AppController().photoList,
      builder: (BuildContext context, AsyncSnapshot<PhotoList> snapshot) {
        if (snapshot.hasError) {
          return Text(snapshot.error.toString());
        } else if (snapshot.hasData) {
          return PhotoListWidget(photoList: snapshot.data);
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
