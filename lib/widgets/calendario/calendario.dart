import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class Calendario extends StatelessWidget {
  var _selectDate;
  bool dataSelecionada;
  bool fraseSelecao;
  bool linhaVisivel;
  var semData;
  var selectedDate;

  Calendario(this._selectDate, this.dataSelecionada, this.fraseSelecao,
      this.linhaVisivel, this.semData, this.selectedDate);

  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: false,
      data: Theme.of(context).copyWith(
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        colorScheme: ColorScheme.light(
          primary: Colors.black87,
        ),
        primaryColorBrightness: Brightness.light,
        buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme
                .accent //color of the text in the button "OK/CANCEL"
            ),
      ),
      child: new Builder(builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(3.0),
          decoration: semData != null
              ? new BoxDecoration(
                  border: new Border(
                    bottom: BorderSide(
                        color: Colors.red[300], width: double.infinity),
                  ),
                )
              : new BoxDecoration(
                  border: new Border(
                      bottom: BorderSide(color: Colors.grey[300], width: 1.5))),
          child: FlatButton(
            onPressed: () {
              _selectDate(context);
              dataSelecionada = true;
              fraseSelecao = false;
              linhaVisivel = false;
              semData = ' ';
            },
            child: Row(
              children: [
                Visibility(
                    visible: fraseSelecao,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Selecione a data',
                          textAlign: TextAlign.start,
                          style: GoogleFonts.poppins(
                              color: Colors.grey[700], fontSize: 13.0),
                        ),
                      ],
                    )),
                Visibility(
                  visible: dataSelecionada,
                  child: Text(
                    "${DateFormat('EEEE, dd/MM/yyyy', "pt").format(selectedDate).toString()}"
                    //"${selectedDate.toLocal()}"
                    //.split(' ')[0]
                    ,
                    style: GoogleFonts.poppins(
                      color: Colors.grey[800],
                      fontSize: 13.0,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
