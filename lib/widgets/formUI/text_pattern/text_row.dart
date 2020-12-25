import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

//cor padrao Colors.black87

class TextRow extends StatelessWidget {
  String textTitle;
  var cor;

  TextRow(this.textTitle, this.cor);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Text(textTitle,
          textAlign: TextAlign.start,
          style: GoogleFonts.poppins(
              color: cor,
              fontSize: 19.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.7)),
    );
  }
}
