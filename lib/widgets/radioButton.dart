import 'package:flutter/material.dart';

class RadioButton extends StatelessWidget {
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem;
  // Group Value for Radio Button.
  int id = 1;
  var estado;
  bool ocorrencia;
  bool _autovalidate;
  var textoRadioBtn1;
  var textoRadioBtn2;

  RadioButton(this.radioButtonItem, this.id, this.estado, this.ocorrencia, this._autovalidate, this.textoRadioBtn1, this.textoRadioBtn2);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Radio(
          value: 1,
          activeColor: Colors.black87,
          groupValue: id,
          onChanged: (val) {
            estado(() {
              ocorrencia = false;
              radioButtonItem = 'ONE';
              id = 1;
            });
          },
        ),
        Flexible(
          child: GestureDetector(
            onTap: () {
              estado(() {
                ocorrencia = false;
                radioButtonItem = 'ONE';
                id = 1;
              });
            },
            child: Text(textoRadioBtn1,
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14.0)),
          ),
        ),
        Radio(
          activeColor: Colors.black87,
          value: 2,
          groupValue: id,
          onChanged: (val) {
            estado(() {
              ocorrencia = true;
              radioButtonItem = 'TWO';
              id = 2;
            });
          },
        ),
        Flexible(
          child: GestureDetector(
            onTap: () {
              estado(() {
                ocorrencia = true;
                radioButtonItem = 'TWO';
                _autovalidate = false;
                id = 2;
              });
            },
            child: Text(textoRadioBtn2,
                style: TextStyle(
                    color: Colors.grey[800],
                    fontSize: 14.0)),
          ),
        ),
      ],
    );
  }
}
