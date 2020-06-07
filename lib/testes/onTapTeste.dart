import 'package:flutter/material.dart';

class Test extends StatefulWidget {
  @override
  TestState createState() => TestState();
}

class TestState extends State<Test> {
  String selected = "first";

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        GestureDetector(
          onTap: () {
            setState(() {
              selected = 'first';
            });
          },
          child: Container(
            height: 200,
            width: 200,
            color: selected == 'first' ? Colors.blue : Colors.transparent,
            child: Text("First"),
          ),
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              selected = 'second';
            });
          },
          child: Container(
            height: 200,
            width: 200,
            color: selected == 'second' ? Colors.blue : Colors.transparent,
            child: Text("Second"),
          ),
        ),
      ],
    );
  }
}