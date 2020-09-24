import 'package:flutter/material.dart';

class ButtonDecoration extends StatelessWidget {
  String tituloBotao;

  ButtonDecoration(this.tituloBotao);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 45.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        gradient: LinearGradient(
          colors: <Color>[
            Colors.grey[600],
            Colors.grey[500],
            Colors.grey[300],
          ],
        ),
      ),
      child: Center(
        child: Text(tituloBotao, style: TextStyle(fontSize: 20)),
      ),
    );
  }
}
