import 'package:flutter/material.dart';

class LoginTest extends StatefulWidget {
  @override
  _LoginTestState createState() => _LoginTestState();
}

class _LoginTestState extends State<LoginTest> {
  double loginWidth = 40.0;
  double loginHeight = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: PageView(
          children: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Container(
//                  height: queryData.size.height-120,
//                  width: queryData.size.width-10,
                  //height: imageHeight,
                  child: Image(
                    image: AssetImage("images/OnibusETTFrenteLateral.jpeg"),
                    fit: BoxFit.fitHeight,
                  ),

                ),
                Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: RaisedButton (
                    child: Text('Animate!'),
                    onPressed: () {
                      setState(() {
                        loginWidth = 400.0;
                        loginHeight = 300.0;
                      });
                    },
                  ),
                ),
                Positioned(
                   // top: 50,
                  child: new Align(
                    alignment: Alignment.bottomCenter,
                  child: AnimatedContainer (
                    duration: Duration (seconds: 1),
                    width: loginWidth,
                    height: loginHeight,
                    color: Colors.red,
                    child: null,
                  ),)
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
