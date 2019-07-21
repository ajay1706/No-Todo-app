import 'package:flutter/material.dart';
import './ui/home.dart';




void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      title:"no-todo" ,
      home: new Home(),
    );
  }
}
