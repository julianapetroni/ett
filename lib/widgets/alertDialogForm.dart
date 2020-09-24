import 'package:flutter/material.dart';

class AlertDialogForm extends StatelessWidget {
  var textAlert;

  AlertDialogForm(this.textAlert);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(
          child: new Icon(
            Icons.check_circle,
            size: 50.0,
            color: Colors.green,
          )),
      content: Row(
        children: <Widget>[
          Flexible(
            child: new Text(
              textAlert,
              style: TextStyle(
                  fontSize: 16.0,
                  color: Colors
                      .grey[600],
                  fontFamily:
                  "Poppins-Bold",
                  letterSpacing:
                  .6),
            ),
          ),
        ],
      ),
      actions: <Widget>[
        // usually buttons at the bottom of the dialog
        new FlatButton(
          child: new Text(
            "Ok",
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          onPressed: () {
            Navigator.of(context)
                .pop();
          },
        ),
      ],
    );
  }
}
