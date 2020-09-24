import 'package:ett_app/style/lightColors.dart';
import 'package:flutter/material.dart';

class AppBarNeon extends AppBar {

  AppBarNeon({Key key, Widget title})
      : super(
    key: key,
    title: title,
    backgroundColor: LightColors.neonYellowLight,
    iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
    elevation: 0,
  );
}
