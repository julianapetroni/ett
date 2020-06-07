import 'package:ett_app/style/lightColors.dart';
import 'package:flutter/material.dart';

class FlightPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.blueSky,
        title: Text('Flight CO2 Calculator'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              LightColors.blueSky,
              LightColors.greenLand,
            ],
          ),
        ),
        padding: const EdgeInsets.all(8.0),
        child: SafeArea(
          child: Column(children: <Widget>[
            FlightDetailsCard(),
            FlightCalculationCard(),
          ]),
        ),
      ),
    );
  }
}

class FlightDetailsCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        decoration: BoxDecoration(
          // lighter gradient effect
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              LightColors.blueSkyLight,
              LightColors.greenLandLight,
            ],
          ),
        ),
        // TODO: add child
      ),
    );
  }
}

class FlightCalculationCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        // match the ending color of the gradient in FlightDetailsCard
        color: LightColors.greenLandLight,
        // TODO: add child
      ),
    );
  }
}


