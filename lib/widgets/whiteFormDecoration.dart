import 'package:flutter/material.dart';

class WhiteFormDecoration extends StatelessWidget {
  var whiteFormDecorationWidgets;

  WhiteFormDecoration(this.whiteFormDecorationWidgets);

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
            left: 16.0, right: 16.0, top: 16.0),
        margin: const EdgeInsets.all(25.0),
        width: double.infinity,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, 15.0),
                  blurRadius: 15.0),
              BoxShadow(
                  color: Colors.black12,
                  offset: Offset(0.0, -10.0),
                  blurRadius: 10.0),
            ]),
        child: whiteFormDecorationWidgets);
  }
}
