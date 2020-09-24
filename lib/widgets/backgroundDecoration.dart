import 'package:ett_app/style/lightColors.dart';
import 'package:flutter/material.dart';

class BackgroundDecoration extends StatelessWidget {

  var widgetScreen;

  BackgroundDecoration(this.widgetScreen);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            LightColors.neonYellowLight,
            LightColors.neonETT,
            LightColors.neonETT,
          ],
        ),
      ),
      child: widgetScreen,
    );
  }
}
