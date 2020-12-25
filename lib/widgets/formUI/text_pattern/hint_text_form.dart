import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HintTextForm extends StatelessWidget {
  var fraseHoraEscolhida;
  var textoHint;
  var horaEscolhida;
  var _dateTime;

  HintTextForm(this.fraseHoraEscolhida, this.textoHint, this.horaEscolhida,
      this._dateTime);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Visibility(
          visible: fraseHoraEscolhida,
          child: Row(
            children: [
              Text(
                textoHint,
                style: GoogleFonts.poppins(
                    color: Colors.grey[700], fontSize: 13.0),
              ),
            ],
          ),
        ),
        Visibility(
            visible: horaEscolhida,
            child: Text(
              '${_dateTime.day}/${_dateTime.month}/${_dateTime.year} - ${_dateTime.hour}:${_dateTime.minute} horas',
              style:
                  GoogleFonts.poppins(color: Colors.grey[800], fontSize: 13.0),
            )),
      ],
    );
  }
}
