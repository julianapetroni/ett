import 'package:ett_app/testes/validators.dart';
import 'package:flutter/material.dart';

class InputForm extends StatelessWidget {
  var keyForm;
  var controllerForm;
  var requiredValidatorForm;
  var onSavedForm;


  InputForm(this.keyForm, this.controllerForm, this.requiredValidatorForm, this.onSavedForm);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
          left: 20.0, right: 20.0),
      child: TextFormField(
        key: keyForm,
        controller: controllerForm,
        validator: requiredValidatorForm,
        onSaved: onSavedForm,
      ),
    );
  }
}
