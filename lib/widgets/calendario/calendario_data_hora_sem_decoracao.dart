import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';

class CalendarioDataEHoraSemDecoracao extends StatelessWidget {
  var faltaData;
  var conteudo;

  CalendarioDataEHoraSemDecoracao(this.faltaData, this.conteudo);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 3, bottom: 3),
        decoration: faltaData != null
            ? new BoxDecoration(
                border: new Border(
                  bottom: BorderSide(
                      color: Colors.red[300], width: double.infinity),
                ),
              )
            : new BoxDecoration(
                border: Border(
                    bottom: BorderSide(color: Colors.grey[300], width: 2.0)),
              ),
        child: Container(child: conteudo));
  }
}
