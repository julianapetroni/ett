import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';

class DropDownForm extends StatelessWidget {
  var itemsForm;
  var onChangedForm;
  var valueForm;
  bool expandedForm;
  var textForm;
  var dropDownErrorForm;

  DropDownForm(this.itemsForm, this.onChangedForm, this.valueForm,
      this.expandedForm, this.textForm, this.dropDownErrorForm);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          DropdownButton(
            items: itemsForm,
            onChanged: onChangedForm,
            value: valueForm,
            isExpanded: expandedForm,
            hint: Text(textForm),
          ),
          dropDownErrorForm == null
              ? SizedBox.shrink()
              : Container(
                  child: Row(
                    children: [
                      Text(
                        dropDownErrorForm ?? "",
                        style: TextStyle(color: Colors.red[800], fontSize: 12),
                      ),
                    ],
                  ),
                ),
        ],
      ),
    );
  }
}
