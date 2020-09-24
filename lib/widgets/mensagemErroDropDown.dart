import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MensagemErroDropDown extends StatelessWidget {
  bool linhaVisivel;
  String mensagemErro;

  MensagemErroDropDown(this.linhaVisivel, this.mensagemErro);

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: linhaVisivel,
      child: Column(
        children: [
          Divider(
            color: Colors.red[800],
            height: 0,
            thickness: 1.1,
          ),
          SizedBox(height: 8,),
          Row(
            children: [
              Text(
                mensagemErro,
                style: GoogleFonts.raleway(
                  color: Colors.red[800],
                  fontSize: 12.0,
                  //fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
