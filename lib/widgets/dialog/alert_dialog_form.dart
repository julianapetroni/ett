import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';

class AlertDialogForm extends StatelessWidget {
  var textAlert;
  Function onPressed;

  AlertDialogForm({@required this.textAlert, this.onPressed});

  @override
  Widget build(BuildContext context) {
    // return AlertDialog(
    //   title: Center(
    //       child: new Icon(
    //     Icons.check_circle,
    //     size: 50.0,
    //     color: Colors.green,
    //   )),
    //   content: Row(
    //     children: <Widget>[
    //       Flexible(
    //         child: new Text(
    //           textAlert,
    //           style: TextStyle(
    //               fontSize: 16.0,
    //               color: Colors.grey[600],
    //               fontFamily: "Poppins-Bold",
    //               letterSpacing: .6),
    //         ),
    //       ),
    //     ],
    //   ),
    //   actions: <Widget>[
    //     // usually buttons at the bottom of the dialog
    //     new FlatButton(
    //       child: new Text(
    //         "Ok",
    //         style: TextStyle(
    //           fontSize: 18,
    //         ),
    //       ),
    //       onPressed: () {
    //         Navigator.of(context).pop();
    //       },
    //     ),
    //   ],
    // );

    return AlertDialog(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24.0))),
        contentPadding: EdgeInsets.only(top: 10.0),
        title: Center(
            child: new Icon(
          Icons.check_circle,
          size: 60.0,
          color: Colors.green[400],
        )),
        content: Padding(
          padding: const EdgeInsets.only(left: 24, right: 24, top: 16),
          child: Wrap(
            children: [
              Flexible(
                child: new Text(
                  textAlert,
                  style: TextStyle(
                      fontSize: 16.0,
                      color: Colors.grey[600],
                      fontFamily: "Poppins-Bold",
                      letterSpacing: .6),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Divider(
                color: Colors.grey[300],
                height: 16,
              ),
              SizedBox(
                height: 4,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          new FlatButton(
            child: new Text(
              "Ok",
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            onPressed: onPressed,
          ),
        ]);
  }
}
