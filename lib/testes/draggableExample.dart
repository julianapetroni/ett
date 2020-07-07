import 'package:ett_app/screens/appBar.dart';
import 'package:ett_app/style/lightColors.dart';
import 'package:flutter/material.dart';

class Drag extends StatefulWidget {
  Drag({Key key}) : super(key: key);
  @override
  _DragState createState() => _DragState();
}

class _DragState extends State<Drag> {
  double busTop = 0;
  double left = 0;
  double carTop = 5;
  double carLeft = 40;
  double bikeTop = 7;
  double bikeLeft = 80;
  double personTop = 5;
  double personLeft = 120;
  double truckTop = 3;
  double truckLeft = 160;
  double pickUpTop = 2;
  double pickUpLeft = 210;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.neonETT,
        elevation: 0,
      ),
      body: Container(
        alignment: Alignment.topLeft,
        margin: EdgeInsets.all(30),
        height: 300,
        width: 300,
        color: LightColors.kLightYellow2,
        child: Stack(
          children: <Widget>[
            Draggable(
              child: Container(
                padding: EdgeInsets.only(top: busTop, left: left),
                child: DragBus(),
              ),
              feedback: Container(
                padding: EdgeInsets.only(top: busTop, left: left),
                child: DragBus(),

              ),
              childWhenDragging: Container(
                padding: EdgeInsets.only(top: busTop, left: left),
                child:  DragBus(),

              ),
              onDragCompleted: () {},
              onDragEnd: (drag) {
                setState(() {
                  if((busTop + drag.offset.dy) > (300.0 - 30.0)){
                    busTop = (300.0 - 30.0);
                  }else if((busTop + drag.offset.dy-30.0) < 0.0){
                    busTop = 0;
                  }else{
                    busTop =  busTop + drag.offset.dy-30.0;
                  }if((left + drag.offset.dx) > (300.0 - 30.0)){
                    left = (300.0 - 30.0);
                  }else if((left + drag.offset.dx-30.0) < 0.0){
                    left = 0;
                  }else{
                    left =  left + drag.offset.dx-30.0;
                  }});
              },
            ),
            Draggable(
              child: Container(
                padding: EdgeInsets.only(top: carTop, left: carLeft),
                child: DragCar(),
              ),
              feedback: Container(
                padding: EdgeInsets.only(top: carTop, left: carLeft),
                child: DragCar(),

              ),
              childWhenDragging: Container(
                padding: EdgeInsets.only(top: carTop, left: carLeft),
                child:  DragCar(),

              ),
              onDragCompleted: () {},
              onDragEnd: (drag) {
                setState(() {
                  if((carTop + drag.offset.dy) > (300.0 - 30.0)){
                    carTop = (300.0 - 30.0);
                  }else if((carTop + drag.offset.dy-30.0) < 0.0){
                    carTop = 0;
                  }else{
                    carTop =  carTop + drag.offset.dy-30.0;
                  }if((left + drag.offset.dx) > (300.0 - 30.0)){
                    carLeft = (300.0 - 30.0);
                  }else if((carLeft + drag.offset.dx-30.0) < 0.0){
                    carLeft = 0;
                  }else{
                    carLeft =  carLeft + drag.offset.dx-30.0;
                  }});
              },
            ),
            Draggable(
              child: Container(
                padding: EdgeInsets.only(top: bikeTop, left: bikeLeft),
                child: DragBike(),
              ),
              feedback: Container(
                padding: EdgeInsets.only(top: bikeTop, left: bikeLeft),
                child: DragBike(),

              ),
              childWhenDragging: Container(
                padding: EdgeInsets.only(top: bikeTop, left: bikeLeft),
                child:  DragBike(),

              ),
              onDragCompleted: () {},
              onDragEnd: (drag) {
                setState(() {
                  if((bikeTop + drag.offset.dy) > (300.0 - 30.0)){
                    bikeTop = (300.0 - 30.0);
                  }else if((bikeTop + drag.offset.dy-30.0) < 0.0){
                    bikeTop = 0;
                  }else{
                    bikeTop =  bikeTop + drag.offset.dy-30.0;
                  }if((left + drag.offset.dx) > (300.0 - 30.0)){
                    bikeLeft = (300.0 - 30.0);
                  }else if((bikeLeft + drag.offset.dx-30.0) < 0.0){
                    bikeLeft = 0;
                  }else{
                    bikeLeft =  bikeLeft + drag.offset.dx-30.0;
                  }});
              },
            ),
            Draggable(
              child: Container(
                padding: EdgeInsets.only(top: personTop, left: personLeft),
                child: DragPerson(),
              ),
              feedback: Container(
                padding: EdgeInsets.only(top: personTop, left: personLeft),
                child: DragPerson(),

              ),
              childWhenDragging: Container(
                padding: EdgeInsets.only(top: personTop, left: personLeft),
                child:  DragPerson(),

              ),
              onDragCompleted: () {},
              onDragEnd: (drag) {
                setState(() {
                  if((personTop + drag.offset.dy) > (300.0 - 30.0)){
                    personTop = (300.0 - 30.0);
                  }else if((personTop + drag.offset.dy-30.0) < 0.0){
                    personTop = 0;
                  }else{
                    personTop =  personTop + drag.offset.dy-30.0;
                  }if((left + drag.offset.dx) > (300.0 - 30.0)){
                    personLeft = (300.0 - 30.0);
                  }else if((personLeft + drag.offset.dx-30.0) < 0.0){
                    personLeft = 0;
                  }else{
                    personLeft =  personLeft + drag.offset.dx-30.0;
                  }});
              },
            ),
            Draggable(
              child: Container(
                padding: EdgeInsets.only(top: truckTop, left: truckLeft),
                child: DragTruck(),
              ),
              feedback: Container(
                padding: EdgeInsets.only(top: truckTop, left: truckLeft),
                child: DragTruck(),

              ),
              childWhenDragging: Container(
                padding: EdgeInsets.only(top: truckTop, left: truckLeft),
                child:  DragTruck(),

              ),
              onDragCompleted: () {},
              onDragEnd: (drag) {
                setState(() {
                  if((truckTop + drag.offset.dy) > (300.0 - 30.0)){
                    truckTop = (300.0 - 30.0);
                  }else if((truckTop + drag.offset.dy-30.0) < 0.0){
                    truckTop = 0;
                  }else{
                    truckTop =  truckTop + drag.offset.dy-30.0;
                  }if((left + drag.offset.dx) > (300.0 - 30.0)){
                    truckLeft = (300.0 - 30.0);
                  }else if((truckLeft + drag.offset.dx-30.0) < 0.0){
                    truckLeft = 0;
                  }else{
                    truckLeft =  truckLeft + drag.offset.dx-30.0;
                  }});
              },
            ),
            Draggable(
              child: Container(
                padding: EdgeInsets.only(top: pickUpTop, left: pickUpLeft),
                child: DragPickUp(),
              ),
              feedback: Container(
                padding: EdgeInsets.only(top: pickUpTop, left: pickUpLeft),
                child: DragPickUp(),

              ),
              childWhenDragging: Container(
                padding: EdgeInsets.only(top: pickUpTop, left: pickUpLeft),
                child:  DragPickUp(),

              ),
              onDragCompleted: () {},
              onDragEnd: (drag) {
                setState(() {
                  if((pickUpTop + drag.offset.dy) > (300.0 - 30.0)){
                    pickUpTop = (300.0 - 30.0);
                  }else if((pickUpTop + drag.offset.dy-30.0) < 0.0){
                    pickUpTop = 0;
                  }else{
                    pickUpTop =  pickUpTop + drag.offset.dy-30.0;
                  }if((left + drag.offset.dx) > (300.0 - 30.0)){
                    pickUpLeft = (300.0 - 30.0);
                  }else if((pickUpLeft + drag.offset.dx-30.0) < 0.0){
                    pickUpLeft = 0;
                  }else{
                    pickUpLeft =  pickUpLeft + drag.offset.dx-30.0;
                  }});
              },
            ),
          ],
        ),
      ),
    );
  }
}
class DragBus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.directions_bus,
      //IconData(57744, fontFamily: 'MaterialIcons'),
      size: 47,
    );
  }
}

class DragCar extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return
      Icon(
        Icons.directions_car,
        //IconData(57744, fontFamily: 'MaterialIcons'),
        size: 40,
      );
  }
}

class DragBike extends StatelessWidget {
@override
  Widget build(BuildContext context) {
    return
      Icon(
      Icons.directions_bike,
      //IconData(57744, fontFamily: 'MaterialIcons'),
      size: 37,
    );
  }
}

class DragPerson extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      Icon(
        Icons.directions_walk,
        //IconData(57744, fontFamily: 'MaterialIcons'),
        size: 37,
      );
  }
}

class DragTruck extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      ImageIcon(
         // Image.asset("images/ETT.png", fit: BoxFit.contain)
        AssetImage('images/caminhao.png'),
        size: 45,
        //color: Colors.black87,
      );
  }
}

class DragPickUp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return
      ImageIcon(
        // Image.asset("images/ETT.png", fit: BoxFit.contain)
        AssetImage('images/caminhoneta.png'),
        size: 50,
        //color: Colors.black87,
      );
  }
}