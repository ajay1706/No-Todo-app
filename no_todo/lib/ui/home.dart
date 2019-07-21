import 'package:flutter/material.dart';
import './notodoscreen.dart';


class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text(
          "No-Todo",

        ),
        backgroundColor: Colors.black54,
      ),
body: new NotoDoScreen(),

    );
  }
}
