import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';

import 'package:ett_app/style/size_config.dart';

class DualRadioButtonCard extends StatefulWidget {
  final String title;
  final int selectedValue;
  final String option1;
  final String option2;
  final Function onChanged;
  String radioValue;
  var activeColor;

  DualRadioButtonCard(
      {Key key,
      this.title,
      this.option1,
      this.option2,
      this.onChanged,
      this.selectedValue,
      this.activeColor})
      : super(key: key);

  @override
  DualRadioOptionCardState createState() => DualRadioOptionCardState();
}

class DualRadioOptionCardState extends State<DualRadioButtonCard> {
  int selectedValue;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    selectedValue = 0;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Card(
      color: Color(0xffE8E4c9),
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(
                  left: SizeConfig.blockSizeHorizontal * 5, top: 10),
              child: Text(
                widget.title,
                style: TextStyle(
                    fontSize: 17,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.bold),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
              Radio(
                value: 0,
                activeColor: widget.activeColor,
                groupValue: widget.selectedValue,
                onChanged: widget.onChanged,
              ),
              Text(widget.option1),
              SizedBox(
                width: 50,
              ),
              Radio(
                value: 1,
                activeColor: Colors.black,
                groupValue: widget.selectedValue,
                onChanged: widget.onChanged,
              ),
              Text(widget.option2),
            ])
          ]),
    );
  }
}
