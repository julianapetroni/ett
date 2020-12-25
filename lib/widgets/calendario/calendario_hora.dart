import 'dart:math';

import 'package:flutter/cupertino.dart';

import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalendarioEHora extends StatefulWidget {
  var semDataAc;
  bool fraseHoraEscolhida;
  bool horaEscolhida;
  bool linhaVisivelAc;
  var dateTime;

  CalendarioEHora(
      {Key key,
      this.semDataAc,
      this.fraseHoraEscolhida,
      this.horaEscolhida,
      this.linhaVisivelAc,
      this.dateTime})
      : super(key: key);

  @override
  CalendarioEHoraState createState() {
    return CalendarioEHoraState(
        semDataAc: semDataAc,
        fraseHoraEscolhida: fraseHoraEscolhida,
        horaEscolhida: horaEscolhida,
        linhaVisivelAc: linhaVisivelAc,
        dateTime: dateTime);
  }
}

class CalendarioEHoraState extends State<CalendarioEHora> {
  var semDataAc;
  bool fraseHoraEscolhida;
  bool horaEscolhida;
  bool linhaVisivelAc;
  var dateTime;

  CalendarioEHoraState(
      {this.semDataAc,
      this.fraseHoraEscolhida,
      this.horaEscolhida,
      this.linhaVisivelAc,
      this.dateTime});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(3.0),
      decoration: semDataAc != null
          ? new BoxDecoration(
              border: new Border(
                bottom:
                    BorderSide(color: Colors.red[300], width: double.infinity),
              ),
            )
          : new BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(5.0)),
              border: new Border.all(color: Colors.grey[300], width: 2.0),
            ),
      child: FlatButton(
        child: Row(
          children: [
            Visibility(
              visible: fraseHoraEscolhida,
              child: Text(
                'Selecione o dia e hora',
                style: GoogleFonts.poppins(
                    color: Colors.grey[700], fontSize: 14.0),
              ),
            ),
            Visibility(
              visible: horaEscolhida,
              child: Text(
                '${dateTime.day}/${dateTime.month}/${dateTime.year} - ${dateTime.hour}:${dateTime.minute} horas',
                style: TextStyle(color: Colors.black87),
              ),
            ),
          ],
        ),
        onPressed: () {
          setState(() {
            fraseHoraEscolhida = false;
            horaEscolhida = true;
            linhaVisivelAc = false;
            semDataAc = null;
          });

          showModalBottomSheet(
              context: context,
              builder: (BuildContext builder) {
                return Container(
                  height: 270,
                  child: Column(
                    children: [
                      Container(
                        height: 200,
                        child: CupertinoDatePicker(
                          mode: CupertinoDatePickerMode.dateAndTime,
                          initialDateTime: dateTime,
                          use24hFormat: true,
                          onDateTimeChanged: (dateTime) {
                            setState(() {
                              dateTime = dateTime;
                            });
                          },
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, right: 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5.0),
                          gradient: LinearGradient(
                            colors: <Color>[
                              Colors.black,
                              Colors.black54,
                              Colors.black45,
                            ],
                          ),
                        ),
                        width: double.infinity,
                        height: 40,
                        child: FlatButton(
                          // color: Colors.black,
                          child: Text(
                            "CONFIRMAR HORÁRIO",
                            style: TextStyle(
                                color: Colors.white,
                                letterSpacing: 2,
                                fontSize: 16),
                          ),
                          onPressed: () {
                            setState(() {
                              fraseHoraEscolhida = false;
                              horaEscolhida = true;
                              linhaVisivelAc = false;
                              semDataAc = null;
                            });

                            Navigator.pop(context);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              });
        },
      ),
    );
  }
}
