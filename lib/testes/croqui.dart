////capture image PNG
//import 'dart:async';
//import 'dart:convert';
//import 'dart:typed_data';
//import 'dart:ui' as ui;
//
//import 'package:flutter/material.dart';
//import 'package:flutter/rendering.dart';
//
//
//class MyHomePage extends StatefulWidget {
//  @override
//  _MyHomePageState createState() => new _MyHomePageState();
//}
//
//class _MyHomePageState extends State<MyHomePage> {
//  GlobalKey _captureImageKey = new GlobalKey();
//
//  bool inside = false;
//  Uint8List imageInMemory;
//
//  Future<Uint8List> _capturePng() async {
//    try {
//      print('inside');
//      inside = true;
//      RenderRepaintBoundary boundary =
//      _captureImageKey.currentContext.findRenderObject();
//      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//      ByteData byteData =
//      await image.toByteData(format: ui.ImageByteFormat.png);
//      Uint8List pngBytes = byteData.buffer.asUint8List();
////      String bs64 = base64Encode(pngBytes);
////      print(pngBytes);
////      print(bs64);
//      print('png done');
//      setState(() {
//        imageInMemory = pngBytes;
//        inside = false;
//      });
//      return pngBytes;
//    } catch (e) {
//      print(e);
//    }
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    return RepaintBoundary(
//      key: _captureImageKey,
//      child: new Scaffold(
//          appBar: new AppBar(
//            title: new Text('Widget To Image demo'),
//          ),
//          body: SingleChildScrollView(
//            child: Center(
//              child: new Column(
//                mainAxisAlignment: MainAxisAlignment.center,
//                children: <Widget>[
//                  new Text(
//                    'click the button below to capture image',
//                  ),
//                  new RaisedButton(
//                    child: Text('capture Image'),
//                    onPressed: _capturePng,
//                  ),
//                  inside ? CircularProgressIndicator()
//                      :
//                  imageInMemory != null
//                      ? Container(
//                      child: Image.memory(imageInMemory),
//                      margin: EdgeInsets.all(10))
//                      : Container(),
//                ],
//              ),
//            ),
//          )),
//    );
//  }
//}

////Drag image

import 'package:flutter/material.dart';


class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomePageState();
  }
}

class _HomePageState extends State<HomePage> {
  double width = 100.0, height = 100.0;
  Offset position ;

  @override
  void initState() {
    super.initState();
    position = Offset(0.0, height - 20);
  }

  MyBlueBox(){}

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Positioned(
          left: position.dx,
          //top: position.dy - height + 20,
          child: Draggable(
            //childWhenDragging: MyRoundedBlueBox(),
            child: Container(
              width: width,
              height: height,
              color: Colors.blue,
              child: Center(child: Text("Drag", style: Theme.of(context).textTheme.headline,),),
            ),
            feedback: Container(
              child: Center(
                child: Text("Drag", style: Theme.of(context).textTheme.headline,),),
              color: Colors.red[800],
              width: width,
              height: height,
            ),
            onDraggableCanceled: (Velocity velocity, Offset offset){
              setState(() => position = offset);
            },

          ),


        ),
      ],
    );
  }
}

