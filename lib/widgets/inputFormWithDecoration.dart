import 'package:flutter/material.dart';

class InputFormWithDecoration extends StatelessWidget {
  var larguraInputForm;
  var labelTextForm;
  var keyForm;
  var textInputForm;
  var validatorForm;
  var onSavedForm;
  var enable;

  InputFormWithDecoration(
      this.larguraInputForm,
      this.labelTextForm,
      this.keyForm,
      this.textInputForm,
      this.validatorForm,
      this.onSavedForm,
      this.enable);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      width: larguraInputForm,
      child: TextFormField(
        decoration: InputDecoration(
          labelText: labelTextForm,
          labelStyle: TextStyle(fontSize: 13.0, color: Colors.grey[600]),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[600], width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey[300], width: 2.0),
            borderRadius: BorderRadius.circular(5.0),
          ),
        ),
        key: keyForm,
        controller: textInputForm,
        validator: validatorForm,
        onSaved: onSavedForm,
        enabled: enable,
      ),
    );
  }
}
