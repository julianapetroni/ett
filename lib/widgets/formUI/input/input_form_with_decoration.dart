import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';

class InputFormWithDecoration extends StatelessWidget {
  var labelTextForm;
  var prefixIcon;
  var suffixIcon;
  var keyForm;
  var controller;
  var keyboardType;
  var validatorForm;
  var onSavedForm;
  var larguraInputForm;
  FocusNode focusNode;
  var obscureText;
  var paddingTop;

  InputFormWithDecoration(
      {@required this.labelTextForm,
      this.prefixIcon,
      this.suffixIcon,
      @required this.keyForm,
      this.controller,
      this.keyboardType,
      @required this.validatorForm,
      @required this.onSavedForm,
      this.larguraInputForm,
      this.focusNode,
      this.obscureText,
      this.paddingTop});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: paddingTop, left: 20.0, right: 20.0),
      child: Container(
        alignment: Alignment.topCenter,
        width: larguraInputForm,
        child: TextFormField(
          focusNode: focusNode,
          keyboardType: keyboardType,
          controller: controller,
          decoration:
              // InputDecoration(
              //   labelText: labelTextForm,
              //   labelStyle: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
              //   focusedBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: Colors.grey[600], width: 2.0),
              //     borderRadius: BorderRadius.circular(5.0),
              //   ),
              //   enabledBorder: OutlineInputBorder(
              //     borderSide: BorderSide(color: Colors.grey[300], width: 2.0),
              //     borderRadius: BorderRadius.circular(5.0),
              //   ),
              // ),

              InputDecoration(
            enabledBorder: UnderlineInputBorder(
              borderSide: new BorderSide(color: Colors.white),
              borderRadius: new BorderRadius.circular(25.0),
            ),
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            labelText: labelTextForm,
            filled: true,
            fillColor: Colors.grey[200],
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: Colors.white),
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          key: keyForm,
          validator: validatorForm,
          onSaved: onSavedForm,
          obscureText: obscureText,
        ),
      ),
    );
  }
}
