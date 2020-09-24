import 'package:flutter/material.dart';

class LogoETTForm extends StatelessWidget {
  var heightLogoETT;

  LogoETTForm(this.heightLogoETT);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: heightLogoETT,
      width: double.infinity,
      child: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(
              image: AssetImage('images/logo-slim.png'),
            ),
          ],
        ),
      ),
    );
  }
}