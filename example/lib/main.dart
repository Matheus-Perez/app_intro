import 'package:flutter/material.dart';
import 'package:app_intro/app_intro.dart';

void main() => runApp(Main());

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Intro',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return AppIntro(
      pages: <Widget>[
        Container(
          color: Colors.deepOrange,
          height: double.infinity,
        ),
        Container(
          color: Colors.red,
          height: double.infinity,
        ),
        Container(
          color: Colors.yellow,
          height: double.infinity,
        ),
      ],
    );
  }
}
