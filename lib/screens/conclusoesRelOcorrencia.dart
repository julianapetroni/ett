import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:ett_app/screens/avariasVeiculoTerceiros.dart';
import 'package:ett_app/screens/dasboardScreen.dart';
import 'package:ett_app/screens/selecaoMultiplaComTag.dart';
import 'package:ett_app/screens/testemunhas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/screens/draw.dart';
import 'package:ett_app/screens/login.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/screens/status.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../style/lightColors.dart';
import '../style/topContainer.dart';
import "package:flutter/painting.dart";
import "package:flutter/foundation.dart";
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:signature/signature.dart';

class ConclusoesRelOcorrencia extends StatefulWidget {
  Solicitacao sol;
  Usuario user;
  Token token;

  ConclusoesRelOcorrencia({Key key, this.sol, this.user, this.token})
      : super(key: key);

  @override
  ConclusoesRelOcorrenciaState createState() {
    return ConclusoesRelOcorrenciaState(sol: sol, user: user, token: token);
  }
}

class ConclusoesRelOcorrenciaState extends State<ConclusoesRelOcorrencia> {
  Solicitacao sol;
  Usuario user;
  Token token;

  ConclusoesRelOcorrenciaState({this.sol, this.user, this.token});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //Mask
  var telController = new MaskedTextController(mask: '(00)00000-0000');
  var dataController = new MaskedTextController(mask: '00/00/0000');
  var dataVencimentoController = new MaskedTextController(mask: '00/00/0000');
  var cpfController = new MaskedTextController(mask: '00.000.000-0');
  var idadeController = new MaskedTextController(mask: '00');

  //assinatura
  final SignatureController _controllerTest1Conclusao = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black87,
    exportBackgroundColor: Colors.blue,
  );
  final SignatureController _controllerTest2Conclusao = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black87,
    exportBackgroundColor: Colors.blue,
  );

  @override
  dispose() {
    super.dispose();
  }

//tabela
  final _formCNHKey = GlobalKey<FormState>();
  final _formDtVencKey = GlobalKey<FormState>();
  final _formCPFKey = GlobalKey<FormState>();
  final _formIdadeKey = GlobalKey<FormState>();
  final _formBOKey = GlobalKey<FormState>();
  final _formDPBOKey = GlobalKey<FormState>();
  final _formChassiKey = GlobalKey<FormState>();
  final _formAnoFabrKey = GlobalKey<FormState>();

  List<DataRow> _rowList = [
    DataRow(cells: <DataCell>[
      DataCell(
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
      DataCell(
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
      DataCell(
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
      DataCell(
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
      DataCell(
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    ]),
  ];

  //tabela conclusao

  //radio button para tabela conclusoes
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItemBafometro = 'ONE';
  // Group Value for Radio Button.
  int idBafometro = 1;

  String radioButtonItemEstadoCivil = 'ONE';
  // Group Value for Radio Button.
  int idEstadoCivil = 1;

  var _isChecked = new List<bool>.filled(10, false);

  void onChanged(bool value) {
    setState(() {
      _isChecked[0] = value;
    });
  }

  void onChanged2(bool value) {
    setState(() {
      _isChecked[1] = value;
    });
  }

  void onChanged3(bool value) {
    setState(() {
      _isChecked[2] = value;
    });
  }

  void onChanged4(bool value) {
    setState(() {
      _isChecked[3] = value;
    });
  }

  void onChanged5(bool value) {
    setState(() {
      _isChecked[4] = value;
    });
  }

  void onChanged6(bool value) {
    setState(() {
      _isChecked[5] = value;
    });
  }

  void onChanged7(bool value) {
    setState(() {
      _isChecked[6] = value;
    });
  }

  void onChanged8(bool value) {
    setState(() {
      _isChecked[7] = value;
    });
  }

  void onChanged9(bool value) {
    setState(() {
      _isChecked[8] = value;
    });
  }

  void onChanged10(bool value) {
    setState(() {
      _isChecked[9] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();

      _controllerTest1Conclusao.addListener(() => print("Value changed"));
      _controllerTest2Conclusao.addListener(() => print("Value changed"));
    }

    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: LightColors.neonYellowLight,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
        title: Padding(
          padding: const EdgeInsets.only(
              top: 100, left: 80, right: 120, bottom: 100),
          child: Image.asset('images/logo-slim.png'),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                LightColors.neonYellowLight,
                LightColors.neonETT,
              ],
            ),
          ),
          child: ListView(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Conclusões:',
                        style: GoogleFonts.raleway(
                            color: Colors.black87,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              //Tabela de conclusão
              Padding(
                padding: const EdgeInsets.only(bottom: 50, top: 20),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    color: Colors.white,
                    child: DataTable(
//                        sortColumnIndex: 0,
//                        sortAscending: true,
//                      columnSpacing: widget.columnSpacing,
//                      horizontalMargin: widget.horizontalMargin,
                      dataRowHeight: 50.0,
                      columns: [
                        DataColumn(label: Text(' '), numeric: true),
                        DataColumn(
                            label: Text(
                          ' ',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800]),
                        )),
                        DataColumn(
                            label: Text(
                              ' ',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey[800]),
                            ),
                            numeric: true),
                      ],
                      rows: [
                        DataRow(
                            //selected: true,
                            cells: [
                              DataCell(
                                CheckboxListTile(
                                    title: new Text(
                                      ' ',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    value: _isChecked[0],
                                    activeColor: Colors.black87,
                                    onChanged: (bool value) {
                                      onChanged(value);
                                    }),
                              ),
                              DataCell(Text(
                                'Isento',
                                style: GoogleFonts.raleway(fontSize: 14),
                              )),
                              DataCell(
                                TextFormField(
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelText: 'Por quê?',
                                        labelStyle:
                                            GoogleFonts.raleway(fontSize: 11))),
                              ),
                            ]),
                        DataRow(cells: [
                          DataCell(
                            CheckboxListTile(
                                title: new Text(
                                  ' ',
                                  style: GoogleFonts.raleway(fontSize: 14),
                                ),
                                value: _isChecked[1],
                                activeColor: Colors.black87,
                                onChanged: (bool value) {
                                  onChanged2(value);
                                }),
                          ),
                          DataCell(Text(
                            'Culpado',
                            style: GoogleFonts.raleway(fontSize: 14),
                          )),
                          DataCell(
                            TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Por quê?',
                                  labelStyle:
                                      GoogleFonts.raleway(fontSize: 11)),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            CheckboxListTile(
                                title: new Text(
                                  ' ',
                                  style: GoogleFonts.raleway(fontSize: 14),
                                ),
                                value: _isChecked[2],
                                activeColor: Colors.black87,
                                onChanged: (bool value) {
                                  onChanged3(value);
                                }),
                          ),
                          DataCell(Text(
                            'Ônibus estava com defeito',
                            style: GoogleFonts.raleway(fontSize: 14),
                          )),
                          DataCell(
                            TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Qual?',
                                  labelStyle:
                                      GoogleFonts.raleway(fontSize: 11)),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            CheckboxListTile(
                                title: new Text(
                                  ' ',
                                  style: GoogleFonts.raleway(fontSize: 14),
                                ),
                                value: _isChecked[3],
                                activeColor: Colors.black87,
                                onChanged: (bool value) {
                                  onChanged4(value);
                                }),
                          ),
                          DataCell(Text(
                            'Bafômetro (etilômetro)',
                            style: GoogleFonts.raleway(fontSize: 14),
                          )),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Radio(
                                  activeColor: Colors.black87,
                                  value: 1,
                                  groupValue: idBafometro,
                                  onChanged: (val) {
                                    setState(() {
                                      radioButtonItemBafometro = 'ONE';
                                      idBafometro = 1;
                                    });
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
                                    radioButtonItemBafometro = 'ONE';
                                    idBafometro = 1;
                                  },
                                  child: Text('Sim',
                                      style: GoogleFonts.raleway(fontSize: 14)),
                                ),
                                Radio(
                                  activeColor: Colors.black87,
                                  value: 2,
                                  groupValue: idBafometro,
                                  onChanged: (val) {
                                    setState(() {
                                      radioButtonItemBafometro = 'TWO';
                                      idBafometro = 2;
                                    });
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
                                    radioButtonItemBafometro = 'TWO';
                                    idBafometro = 2;
                                  },
                                  child: Text('Não',
                                      style: GoogleFonts.raleway(fontSize: 14)),
                                ),
                                Radio(
                                  activeColor: Colors.black87,
                                  value: 3,
                                  groupValue: idBafometro,
                                  onChanged: (val) {
                                    setState(() {
                                      radioButtonItemBafometro = 'THREE';
                                      idBafometro = 3;
                                    });
                                  },
                                ),
                                GestureDetector(
                                  onTap: () {
                                    radioButtonItemBafometro = 'THREE';
                                    idBafometro = 3;
                                  },
                                  child: Text('Recusou',
                                      style: GoogleFonts.raleway(fontSize: 14)),
                                ),
                              ],
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            CheckboxListTile(
                                title: new Text(
                                  ' ',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                value: _isChecked[4],
                                activeColor: Colors.black87,
                                onChanged: (bool value) {
                                  onChanged5(value);
                                }),
                          ),
                          DataCell(Text(
                            'Testemunha 1',
                            style: GoogleFonts.raleway(fontSize: 14),
                          )),
                          DataCell(
                            TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Matrícula',
                                  labelStyle:
                                      GoogleFonts.raleway(fontSize: 14)),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(' ')),
                          DataCell(Row(
                            children: <Widget>[
                              Text(
                                'Assinatura da Testemunha 1',
                                style: GoogleFonts.raleway(fontSize: 14),
                              ),
                              Spacer(),
                              //CLEAR CANVAS
                              IconButton(
                                icon: const Icon(Icons.replay),
                                iconSize: 30,
                                color: Colors.black87,
                                onPressed: () {
                                  setState(
                                      () => _controllerTest1Conclusao.clear());
                                },
                              ),
                            ],
                          )),
                          DataCell(Row(
                            children: <Widget>[
                              //SIGNATURE CANVAS
                              Flexible(
                                child: Signature(
                                  controller: _controllerTest1Conclusao,
                                  height: 50,
                                  width: double.infinity,
                                  backgroundColor: Colors.grey[100],
                                ),
                              ),
                            ],
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            CheckboxListTile(
                                title: new Text(
                                  ' ',
                                  style: GoogleFonts.raleway(fontSize: 14),
                                ),
                                value: _isChecked[5],
                                activeColor: Colors.black87,
                                onChanged: (bool value) {
                                  onChanged6(value);
                                }),
                          ),
                          DataCell(Text(
                            'Testemunha 2',
                            style: GoogleFonts.raleway(fontSize: 14),
                          )),
                          DataCell(
                            TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Matrícula',
                                  labelStyle:
                                      GoogleFonts.raleway(fontSize: 14)),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(' ')),
                          DataCell(Row(
                            children: <Widget>[
                              Text(
                                'Assinatura da Testemunha 2',
                                style: GoogleFonts.raleway(fontSize: 14),
                              ),
                              Spacer(),
                              //CLEAR CANVAS
                              IconButton(
                                icon: const Icon(Icons.replay),
                                iconSize: 30,
                                color: Colors.black87,
                                onPressed: () {
                                  setState(
                                      () => _controllerTest2Conclusao.clear());
                                },
                              ),
                            ],
                          )),
                          DataCell(Row(
                            children: <Widget>[
                              //SIGNATURE CANVAS
                              Flexible(
                                child: Signature(
                                  controller: _controllerTest2Conclusao,
                                  height: 50,
                                  width: double.infinity,
                                  backgroundColor: Colors.grey[100],
                                ),
                              ),
                            ],
                          )),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            CheckboxListTile(
                                title: new Text(
                                  ' ',
                                  style: GoogleFonts.raleway(fontSize: 14),
                                ),
                                value: _isChecked[6],
                                activeColor: Colors.black87,
                                onChanged: (bool value) {
                                  onChanged7(value);
                                }),
                          ),
                          DataCell(Text(
                            'Encaminhar ao Departamento Jurídico',
                            style: GoogleFonts.raleway(fontSize: 14),
                          )),
                          DataCell(
                            TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: ' ',
                                  labelStyle:
                                      GoogleFonts.raleway(fontSize: 14)),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            CheckboxListTile(
                                title: new Text(
                                  ' ',
                                  style: GoogleFonts.raleway(fontSize: 14),
                                ),
                                value: _isChecked[7],
                                activeColor: Colors.black87,
                                onChanged: (bool value) {
                                  onChanged8(value);
                                }),
                          ),
                          DataCell(Text(
                            'Encaminhar para reciclagem',
                            style: GoogleFonts.raleway(fontSize: 14),
                          )),
                          DataCell(
                            TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: ' ',
                                  labelStyle: TextStyle(
                                      fontSize: 9.0, color: Colors.grey[900])),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            CheckboxListTile(
                                title: new Text(
                                  ' ',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                value: _isChecked[8],
                                activeColor: Colors.black87,
                                onChanged: (bool value) {
                                  onChanged9(value);
                                }),
                          ),
                          DataCell(Text(
                            'Outros',
                            style: GoogleFonts.raleway(fontSize: 14),
                          )),
                          DataCell(
                            TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: ' ',
                                  labelStyle: TextStyle(
                                      fontSize: 13.0, color: Colors.grey[900])),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(
                            CheckboxListTile(
                                title: new Text(
                                  ' ',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.w600),
                                ),
                                value: _isChecked[9],
                                activeColor: Colors.black87,
                                onChanged: (bool value) {
                                  onChanged10(value);
                                }),
                          ),
                          DataCell(Text(
                            'Encaminhar para seguro',
                            style: GoogleFonts.raleway(fontSize: 14),
                          )),
                          DataCell(
                            TextFormField(
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Sinistro n.',
                                labelStyle: GoogleFonts.raleway(
                                    fontSize: 14, color: Colors.black87),
                              ),
                            ),
                          )
                        ]),
                        DataRow(cells: [
                          DataCell(Text(' ')),
                          DataCell(
                            Form(
                              key: _formCNHKey,
                              child: TextFormField(
                                  validator: (value) {
                                    if (value.isEmpty) {
                                      return 'Digite a CNH';
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      hintText: 'Número do registro CNH',
                                      hintStyle: GoogleFonts.raleway(
                                          fontSize: 14,
                                          color: Colors.black87))),
                            ),
                          ),
                          DataCell(
                            Form(
                              key: _formDtVencKey,
                              child: TextFormField(
//                          validator: (value) {
//                            if (value.isEmpty) {
//                              return 'Digite a Data';
//                            }
//                            return null;
//                          },
                                validator: composeValidators(
                                    'nome', [requiredValidator, dataValidator]),
                                controller: dataVencimentoController,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: 'Data de Vencimento',
                                  hintStyle: GoogleFonts.raleway(
                                      fontSize: 14, color: Colors.black87),
                                ),
                              ),
                            ),
                          )
                        ]),
                        DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(
                            Form(
                              key: _formCPFKey,
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Digite o CPF';
                                  }
                                  return null;
                                },
                                controller: cpfController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'CPF',
                                    hintStyle: GoogleFonts.raleway(
                                        fontSize: 14, color: Colors.black87)),
                              ),
                            ),
                          ),
                          DataCell(
                            Form(
                              key: _formIdadeKey,
                              child: TextFormField(
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Digite a Idade';
                                  }
                                  return null;
                                },
                                controller: idadeController,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Idade',
                                    hintStyle: GoogleFonts.raleway(
                                        fontSize: 14, color: Colors.black87)),
                              ),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(' ')),
                          DataCell(Text(
                            'Estado Civil',
                            style: GoogleFonts.raleway(
                                fontSize: 14, color: Colors.black87),
                          )),
                          DataCell(
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: <Widget>[
                                Radio(
                                  activeColor: Colors.black87,
                                  value: 1,
                                  groupValue: idEstadoCivil,
                                  onChanged: (val) {
                                    setState(() {
                                      radioButtonItemEstadoCivil = 'ONE';
                                      idEstadoCivil = 1;
                                    });
                                  },
                                ),
                                Text('Solteiro',
                                    style: GoogleFonts.raleway(
                                        fontSize: 14, color: Colors.black87)),
                                Radio(
                                  activeColor: Colors.black87,
                                  value: 2,
                                  groupValue: idEstadoCivil,
                                  onChanged: (val) {
                                    setState(() {
                                      radioButtonItemEstadoCivil = 'TWO';
                                      idEstadoCivil = 2;
                                    });
                                  },
                                ),
                                Text('Casado',
                                    style: GoogleFonts.raleway(
                                        fontSize: 14, color: Colors.black87)),
                                Radio(
                                  activeColor: Colors.black87,
                                  value: 3,
                                  groupValue: idEstadoCivil,
                                  onChanged: (val) {
                                    setState(() {
                                      radioButtonItemEstadoCivil = 'THREE';
                                      idEstadoCivil = 3;
                                    });
                                  },
                                ),
                                Text('Divorciado',
                                    style: GoogleFonts.raleway(
                                        fontSize: 14, color: Colors.black87)),
                                Radio(
                                  activeColor: Colors.black87,
                                  value: 4,
                                  groupValue: idEstadoCivil,
                                  onChanged: (val) {
                                    setState(() {
                                      radioButtonItemEstadoCivil = 'FOUR';
                                      idEstadoCivil = 4;
                                    });
                                  },
                                ),
                                Text('Viúvo',
                                    style: GoogleFonts.raleway(
                                        fontSize: 14, color: Colors.black87)),
                              ],
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(
                            TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'BO n.',
                                  labelStyle: GoogleFonts.raleway(
                                      fontSize: 14, color: Colors.black87)),
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'DP do BO',
                                  labelStyle: GoogleFonts.raleway(
                                      fontSize: 14, color: Colors.black87)),
                            ),
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(
                            TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'IC',
                                  labelStyle: GoogleFonts.raleway(
                                      fontSize: 14, color: Colors.black87)),
                            ),
                          ),
                          DataCell(Text(' ')),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(
                            TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Chassi',
                                  labelStyle: GoogleFonts.raleway(
                                      fontSize: 14, color: Colors.black87)),
                            ),
                          ),
                          DataCell(
                            TextFormField(
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  labelText: 'Ano Fabricação\/Modelo',
                                  labelStyle: GoogleFonts.raleway(
                                      fontSize: 14, color: Colors.black87)),
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(
                    top: 40, bottom: 40, left: 10, right: 10),
                child: FlatButton(
                  onPressed: () {
                    if (_formCNHKey.currentState.validate() &&
                        _formDtVencKey.currentState.validate() &&
                        _formCPFKey.currentState.validate() &&
                        _formIdadeKey.currentState.validate()) {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          // return object of type Dialog
                          return AlertDialog(
                            title: Center(
                                child: new Icon(
                              Icons.check_circle,
                              size: 50.0,
                              color: Colors.green,
                            )),
                            content: Row(
                              children: <Widget>[
                                Flexible(
                                  child: new Text(
                                    'Formulário registrado com sucesso!',
                                    style: GoogleFonts.raleway(
                                        color: Colors.black87,
                                        fontSize: 17.0,
                                        fontWeight: FontWeight.w500,
                                        letterSpacing: 0.7),
                                  ),
                                ),
                              ],
                            ),
                            actions: <Widget>[
                              // usually buttons at the bottom of the dialog
                              new FlatButton(
                                child: new Text(
                                  "Ok",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                      Future.delayed(const Duration(milliseconds: 3000), () {
                        //setState(() {

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DashboardScreen(
                                sol: sol, user: user, token: token
                                //textSucesso: textSucesso,
                                //alertSucessoVisible: alertSucessoVisible,

                                ),
                          ),
                        );
                        //});
                      });
                    } else {
                      final semCadastro = new SnackBar(
                          content: new Text(
                              'Preencha todos os campos para prosseguir!'));
                      _scaffoldKey.currentState.showSnackBar(semCadastro);
                    }
                  },
                  textColor: Colors.white,
                  child: Container(
                    width: double.infinity,
                    height: 45.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.grey[600],
                          Colors.grey[500],
                          Colors.grey[300],
                        ],
                      ),
                    ),
                    //padding: const EdgeInsets.fromLTRB(90.0, 15.0, 90.0, 15.0),
                    child: Center(
                        child: const Text('CONCLUIR',
                            style: TextStyle(fontSize: 20))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
