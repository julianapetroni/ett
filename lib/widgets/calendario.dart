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


  Calendario(this._selectDate, this.dataSelecionada, this.fraseSelecao, this.linhaVisivel,  this.semData, this.selectedDate);

//  Future<Null> _selectDate(BuildContext context) async {
//    final DateTime picked = await showDatePicker(
//        context: context,
//        initialDate: selectedDate,
//        firstDate: DateTime(2000, 8),
//        lastDate: DateTime(2101));
//    if (picked != null && picked != selectedDate)
//      setState(() {
//        dataSelecionada = true;
//        fraseSelecao = false;
//        selectedDate = picked;
//        linhaVisivel = false;
//        semData = null;
//      });
//  }


  @override
  Widget build(BuildContext context) {
    return Theme(
      isMaterialAppTheme: false,
      data: Theme.of(context).copyWith(
        materialTapTargetSize:
        MaterialTapTargetSize.shrinkWrap,
        colorScheme: ColorScheme.light(
          primary: Colors.black87,
        ),
        primaryColorBrightness:
        Brightness.light,
        buttonTheme: ButtonThemeData(
            textTheme: ButtonTextTheme
                .accent //color of the text in the button "OK/CANCEL"
        ),
      ),
      child: new Builder(
          builder: (BuildContext context) {
        return Container(
          width: double.infinity,
          padding: const EdgeInsets.all(3.0),
          decoration: semData != null
              ? new BoxDecoration(
            border: new Border(
              bottom: BorderSide(
                  color:
                  Colors.red[300],
                  width:
                  double.infinity),
            ),
          )
              : new BoxDecoration(
            borderRadius:
            BorderRadius.all(
                Radius.circular(
                    5.0)),
            border: new Border.all(
                color: Colors.grey[300],
                width: 2.0),
          ),
          child: FlatButton(
            onPressed: () {
              _selectDate(context);
             // estado(() {
                dataSelecionada = true;
                fraseSelecao = false;
                linhaVisivel = false;
                semData = ' ';
             // });
            },
            child: Row(
              children: [
                Visibility(
                    visible: fraseSelecao,
                    child: Text(
                      'Selecione o dia da Semana',
                      style: GoogleFonts.roboto(
                          color: Colors.grey[700],
                          fontSize: 13.0),
                    )),
                Visibility(
                  visible: dataSelecionada,
                  child: Text(
                    "${DateFormat('EEEE, dd/MM/yyyy', "pt").format(selectedDate).toString()}"
                    //"${selectedDate.toLocal()}"
                    //.split(' ')[0]
                    ,
                    style: GoogleFonts.roboto(
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
