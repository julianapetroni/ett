import 'package:flutter/material.dart';

class LogoETT extends StatelessWidget {
  var heightLogoETT;

  LogoETT(this.heightLogoETT);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightLogoETT,
      width: double.infinity,
      child: Padding(
        padding: const EdgeInsets.all(95.0),
        child: Image(
          image: AssetImage("images/logo-slim.png"),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
