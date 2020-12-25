import 'package:flutter/cupertino.dart';

import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubtitleForm extends StatelessWidget {
  String textSubtitle;

  SubtitleForm(this.textSubtitle);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        children: <Widget>[
          Text(
            textSubtitle,
            style: GoogleFonts.poppins(color: Colors.black87, fontSize: 15),
          ),
        ],
      ),
    );
  }
}
