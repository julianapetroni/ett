import 'package:flutter/material.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:google_fonts/google_fonts.dart';

class FormCheckBoxComunicadoInterno extends StatefulWidget {

  Usuario user;

  FormCheckBoxComunicadoInterno(
      {Key key,
        // this.value,
        this.user})
      : super(key: key);

  @override
  FormCheckBoxComunicadoInternoState createState() {
    return FormCheckBoxComunicadoInternoState(user: user);
  }
}

class FormCheckBoxComunicadoInternoState extends State<FormCheckBoxComunicadoInterno> {
  Usuario user;

  FormCheckBoxComunicadoInternoState({this.user});

  @override
  initState() {
    super.initState();
  }

  //Checkbox
  bool _isCheckedDir = false;
  bool _isCheckedOf = false;
  bool _isCheckedOp = false;
  bool _isCheckedPl = false;
  bool _isCheckedTI = false;

  void onChangedDIR(bool value) {
    setState(() {
      _isCheckedDir = value;
    });
  }

  void onChangedOF(bool value) {
    setState(() {
      _isCheckedOf = value;
    });
  }

  void onChangedOP(bool value) {
    setState(() {
      _isCheckedOp = value;
    });
  }

  void onChangedPL(bool value) {
    setState(() {
      _isCheckedPl = value;
    });
  }

  void onChangedTI(bool value) {
    setState(() {
      _isCheckedTI = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Padding(
        padding: EdgeInsets.only(top: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 20.0, bottom: 10.0),
              child: Row(
                  children: <Widget>[

                    Flexible(
                      child: Text(
                        'Quem pode ver esse relatório:',
                        style:  GoogleFonts.raleway(color: Colors.black87, fontSize: 15),
                      ),
                    ),
                  ],
                ),
            ),


            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  new CheckboxListTile(
                      title: new Text(
                        'Diretoria',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600),
                      ),
                      value: _isCheckedDir,
                      activeColor: Colors.yellow[700],
                      onChanged: (bool value) {
                        onChangedDIR(value);
                      }),

                  new CheckboxListTile(
                      title: new Text(
                        'Oficina',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600),
                      ),
                      value: _isCheckedOf,
                      activeColor: Colors.yellow[700],
                      onChanged: (bool value) {
                        onChangedOF(value);
                      }
                  ),

                  new CheckboxListTile(
                      title: new Text(
                        'Operacional',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600),
                      ),
                      value: _isCheckedOp,
                      activeColor: Colors.yellow[700],
                      onChanged: (bool value) {
                        onChangedOP(value);
                      }
                  ),

                  new CheckboxListTile(
                      title: new Text(
                        'Plantão',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600),
                      ),
                      value: _isCheckedPl,
                      activeColor: Colors.yellow[700],
                      onChanged: (bool value) {
                        onChangedPL(value);
                      }
                  ),

                  new CheckboxListTile(
                      title: new Text(
                        'TI',
                        style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 13.0,
                            fontWeight: FontWeight.w600),
                      ),
                      value: _isCheckedTI,
                      activeColor: Colors.yellow[700],
                      onChanged: (bool value) {
                        onChangedTI(value);
                      }
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }
}