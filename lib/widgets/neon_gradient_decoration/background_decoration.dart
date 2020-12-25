import 'package:ett_app/style/light_colors.dart';

import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';

class BackgroundDecoration extends StatelessWidget {
  var widgetScreen;

  BackgroundDecoration(this.widgetScreen);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.maxFinite,
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
