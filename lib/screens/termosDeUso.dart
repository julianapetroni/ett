import 'package:flutter/material.dart';

class TermosDeUso extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.grey[600]),
        title: Center(
            child: Text(
          ' ',
          style: TextStyle(color: Colors.grey[400]),
        )),
        backgroundColor: Colors.grey[100],
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              child: Row(
                children: <Widget>[],
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Column(
        children: <Widget>[
          Flexible(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 30),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Image(
                        image: AssetImage('images/PECLogo.png'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 10.0),
            child: Row(
              children: <Widget>[
                Text("Termos de uso",
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 22.0,
                        color: Colors.green,
                        fontFamily: "Poppins-Bold",
                        letterSpacing: .6)),
              ],
            ),
          ),
          SizedBox(
            height: 30.0,
          ),
          Flexible(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Text(
                'O usuário, ao criar o seu cadastro, concorda com os sequintes termos de uso e políticas abaixo explicitados:',
                textAlign: TextAlign.justify,
                style: TextStyle(color: Colors.grey[500], fontSize: 16),
              ),
            ),
          ),
//          FloatingActionButton(
//            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => FlutterDemo()),
//              );
//            },
//            child: Text('teste'),
//          ),
        ],
      )),
    );
  }
}
