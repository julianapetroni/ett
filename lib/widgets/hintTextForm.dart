import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HintTextForm extends StatelessWidget {
  var fraseHoraEscolhida;
  var textoHint;
  var horaEscolhida;
  var _dateTime;

  HintTextForm(this.fraseHoraEscolhida, this.textoHint, this.horaEscolhida, this._dateTime);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          child: Visibility(
            visible: fraseHoraEscolhida,
            child: Text(
              textoHint,
              style: GoogleFonts.roboto(
                  color: Colors.grey[700],
                  fontSize: 13.0
              ),
            ),
          ),
        ),
        Flexible(
          child: Visibility(
              visible: horaEscolhida,
              child: Text('${_dateTime.day}/${_dateTime.month}/${_dateTime.year} - ${_dateTime.hour}:${_dateTime.minute} horas', style: GoogleFonts.roboto(
                  color: Colors.grey[800],
                  fontSize: 13.0),
              )),
        ),
      ],
    );
  }
}
