import 'dart:async';
import 'package:ett_app/screens/dashboard/ui/dasboard.page.dart';
import 'package:ett_app/services/token.dart';
import 'package:ett_app/widgets/dialog/alert_dialog_form.dart';
import 'package:ett_app/widgets/formUI/text_pattern/subtitle_form.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/style/size_config.dart';
import 'package:ett_app/domains/usuario.dart';
import '../../../style/light_colors.dart';
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
  var cpfController = new MaskedTextController(mask: '000.000.000-00');
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

  int selectedRadio;
  int selectedRadioBus;
  int selectedRadioBafometro;
  int selectedRadioEncaminhar;
  bool _isentoField = false;
  bool _bafometroField = false;
  bool _depJurJustificativa = false;
  bool _justDepJur = false;
  bool _encaminharSeguro = false;
  bool _encaminharReciclagem = false;
  bool _encaminharOutros = false;

  bool _isChecked = false;
  bool _isCheckedSeguro = false;
  bool _isCheckedReciclagem = false;
  bool _isCheckedOutros = false;

  void onChanged(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  void onChangedSeguro(bool value) {
    setState(() {
      _isCheckedSeguro = value;
    });
  }

  void onChangedReciclagem(bool value) {
    setState(() {
      _isCheckedReciclagem = value;
    });
  }

  void onChangedOutros(bool value) {
    setState(() {
      _isCheckedOutros = value;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    selectedRadio = 0;
    selectedRadioBus = 0;
    selectedRadioBafometro = 0;
    selectedRadioEncaminhar = 0;
    _controllerTest1Conclusao.addListener(() => print("Value changed"));
    _controllerTest2Conclusao.addListener(() => print("Value changed"));
  }

  setSelectedRadio(int val) {
    setState(() {
      selectedRadio = val;
    });
  }

  setSelectedRadioBus(int val) {
    setState(() {
      selectedRadioBus = val;
    });
  }

  setSelectedRadioBafometro(int val) {
    setState(() {
      selectedRadioBafometro = val;
    });
  }

  setSelectedRadioEncaminhar(int val) {
    setState(() {
      selectedRadioEncaminhar = val;
    });
  }

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

  //tabela conclusao

  //radio button para tabela conclusoes
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItemBafometro = 'ONE';
  // Group Value for Radio Button.
  int idBafometro = 1;

  String radioButtonItemEstadoCivil = 'ONE';
  // Group Value for Radio Button.
  int idEstadoCivil = 1;

  bool encaminharJustificativa = false;
  bool encaminharJustificativaOutro = false;

  bool numCNH = false;
  bool dataCNH = false;
  bool numCPF = false;
  bool idade = false;

  var checkBoxSeguroValue = false;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: _buildAppBar(context),
      backgroundColor: Colors.white,
      body: _buildBody(context),
      floatingActionButton: _buildButton(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: LightColors.neonYellowLight,
      elevation: 0.0,
      iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
      title: Padding(
        padding:
            const EdgeInsets.only(top: 100, left: 80, right: 120, bottom: 100),
        child: Image.asset(GeneralConfig.logoImage),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 1.2;
    // Default Radio Button Selected Item When App Starts.
    String radioButtonItem;
    String radioButtonItemBus;
    String radioButtonItemEncaminhar;

    return Container(
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
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 40.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    'Conclusões:',
                    style: GoogleFonts.poppins(
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
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(left: 20, right: 20, top: 8),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Radio(
                          value: 1,
                          activeColor: Colors.black87,
                          groupValue: selectedRadio,
                          onChanged: (val) {
                            setState(() {
                              _isentoField = true;
                              radioButtonItem = 'ONE';
                              setSelectedRadio(val);
                            });
                          },
                        ),
                        Flexible(
                            child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _isentoField = true;
                              radioButtonItem = 'ONE';
                              setSelectedRadio(1);
                            });
                          },
                          child: Text('ISENTO',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 14.0)),
                        )),
                        Radio(
                          activeColor: Colors.black87,
                          value: 2,
                          groupValue: selectedRadio,
                          onChanged: (val) {
                            setState(() {
                              _isentoField = true;
                              radioButtonItem = 'TWO';
                              setSelectedRadio(val);
                            });
                          },
                        ),
                        Flexible(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _isentoField = true;
                                radioButtonItem = 'TWO';
                                setSelectedRadio(2);
                              });
                            },
                            child: Text('CULPADO',
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 14.0)),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Divider(
                          thickness: 0.7,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Por quê?',
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: TextFormField(
                                    minLines: 5,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelStyle:
                                            GoogleFonts.poppins(fontSize: 11))))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text('ÔNIBUS ESTAVA COM DEFEITO',
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 14.0)),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          thickness: 0.7,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                'Qual?',
                                style: GoogleFonts.poppins(fontSize: 14),
                              ),
                            ),
                            Expanded(
                                flex: 4,
                                child: TextFormField(
                                    minLines: 5,
                                    maxLines: 5,
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        labelStyle:
                                            GoogleFonts.poppins(fontSize: 11))))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text('BAFÔMETRO (ETILÔMETRO)',
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 14.0)),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          thickness: 0.7,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Radio(
                              activeColor: Colors.black87,
                              value: 1,
                              groupValue: idBafometro,
                              onChanged: (val) {
                                setState(() {
                                  _bafometroField = true;
                                  radioButtonItemBafometro = 'ONE';
                                  idBafometro = 1;
                                });
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _bafometroField = true;
                                  radioButtonItemBafometro = 'ONE';
                                  idBafometro = 1;
                                });
                              },
                              child: Text('SIM',
                                  style: GoogleFonts.poppins(fontSize: 14)),
                            ),
                            Radio(
                              activeColor: Colors.black87,
                              value: 2,
                              groupValue: idBafometro,
                              onChanged: (val) {
                                setState(() {
                                  _bafometroField = true;
                                  radioButtonItemBafometro = 'TWO';
                                  idBafometro = 2;
                                });
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _bafometroField = true;
                                  radioButtonItemBafometro = 'TWO';
                                  idBafometro = 2;
                                });
                              },
                              child: Text('NÃO',
                                  style: GoogleFonts.poppins(fontSize: 14)),
                            ),
                            Radio(
                              activeColor: Colors.black87,
                              value: 3,
                              groupValue: idBafometro,
                              onChanged: (val) {
                                setState(() {
                                  _bafometroField = true;
                                  radioButtonItemBafometro = 'THREE';
                                  idBafometro = 3;
                                });
                              },
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  _bafometroField = true;
                                  radioButtonItemBafometro = 'THREE';
                                  idBafometro = 3;
                                });
                              },
                              child: Text('RECUSOU',
                                  style: GoogleFonts.poppins(fontSize: 14)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text('TESTEMUNHAS',
                                style: TextStyle(fontSize: 14.0)),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          thickness: 0.7,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Testemunha n. 1:',
                              style: GoogleFonts.poppins(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: width,
                              color: Colors.grey[50],
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Matrícula',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.black87),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                'Assinatura da Testemunha',
                                style: GoogleFonts.poppins(fontSize: 14.0),
                              ),
                            ),
                            Spacer(),
                            //CLEAR CANVAS
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(Icons.replay),
                                iconSize: 30,
                                color: Colors.black87,
                                onPressed: () {
                                  setState(
                                      () => _controllerTest1Conclusao.clear());
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //SIGNATURE CANVAS
                        Signature(
                          controller: _controllerTest1Conclusao,
                          height: 180,
                          width: width,
                          backgroundColor: Colors.grey[50],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Divider(
                          thickness: 0.7,
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: <Widget>[
                            Text(
                              'Testemunha n. 2:',
                              style: GoogleFonts.poppins(
                                  color: Colors.black87,
                                  fontSize: 15,
                                  fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              width: width,
                              color: Colors.grey[50],
                              child: TextFormField(
                                decoration: InputDecoration(
                                  labelText: 'Matrícula',
                                  labelStyle: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.black87),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Expanded(
                              flex: 5,
                              child: Text(
                                'Assinatura da Testemunha',
                                style: GoogleFonts.poppins(fontSize: 14.0),
                              ),
                            ),
                            Spacer(),
                            //CLEAR CANVAS
                            Expanded(
                              flex: 1,
                              child: IconButton(
                                icon: const Icon(Icons.replay),
                                iconSize: 30,
                                color: Colors.black87,
                                onPressed: () {
                                  setState(
                                      () => _controllerTest2Conclusao.clear());
                                },
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        //SIGNATURE CANVAS
                        Signature(
                          controller: _controllerTest2Conclusao,
                          height: 180,
                          width: width,
                          backgroundColor: Colors.grey[50],
                        ),

                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 20, top: 20, bottom: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(
                            child: Text('ENCAMINHAR PARA:',
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 16.0))),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey[200],
                          width: double.infinity,
                          child: FlatButton(
                            child: Row(
                              children: [
                                Container(
                                  width: width,
                                  height: 50,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: const Text('JURÍDICO',
                                        style: TextStyle(fontSize: 14.0)),
                                    activeColor: Colors.black,
                                    selected: _isChecked,
                                    value: _isChecked,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _isChecked = value;
                                        _depJurJustificativa =
                                            !_depJurJustificativa;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                _depJurJustificativa = !_depJurJustificativa;
                              });
                            },
                          ),
                        ),
                        Visibility(
                          visible: _depJurJustificativa,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  width: width,
                                  color: Colors.grey[50],
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Sinistro n.',
                                      labelStyle: GoogleFonts.poppins(
                                          fontSize: 14, color: Colors.black87),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Justificativa',
                                        style:
                                            GoogleFonts.poppins(fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: TextFormField(
                                          minLines: 5,
                                          maxLines: 5,
                                          decoration: InputDecoration(
                                              border: InputBorder.none,
                                              labelStyle: GoogleFonts.poppins(
                                                  fontSize: 11)),
                                          onChanged: (value) {
                                            setState(() {
                                              _justDepJur = true;
                                            });
                                          },
                                          onSaved: (value) {
                                            setState(() {
                                              _justDepJur = true;
                                            });
                                          },
                                        ))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey[200],
                          width: double.infinity,
                          child: FlatButton(
                            child: Row(
                              children: [
                                Container(
                                  width: width,
                                  height: 50,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: const Text('SEGURO',
                                        style: TextStyle(fontSize: 14.0)),
                                    activeColor: Colors.black,
                                    selected: _isCheckedSeguro,
                                    value: _isCheckedSeguro,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _isCheckedSeguro = value;
                                        _encaminharSeguro = !_encaminharSeguro;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                _encaminharSeguro = !_encaminharSeguro;
                              });
                            },
                          ),
                        ),
                        Visibility(
                          visible: _encaminharSeguro,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  width: width,
                                  color: Colors.grey[50],
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Sinistro n.',
                                      labelStyle: GoogleFonts.poppins(
                                          fontSize: 14, color: Colors.black87),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Justificativa',
                                        style:
                                            GoogleFonts.poppins(fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: TextFormField(
                                            minLines: 5,
                                            maxLines: 5,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelStyle: GoogleFonts.poppins(
                                                    fontSize: 11))))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey[200],
                          width: double.infinity,
                          child: FlatButton(
                            child: Row(
                              children: [
                                Container(
                                  width: width,
                                  height: 50,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: const Text('RECICLAGEM',
                                        style: TextStyle(fontSize: 14.0)),
                                    activeColor: Colors.black,
                                    selected: _isCheckedReciclagem,
                                    value: _isCheckedReciclagem,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _isCheckedReciclagem = value;
                                        _encaminharReciclagem =
                                            !_encaminharReciclagem;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                _encaminharReciclagem = !_encaminharReciclagem;
                              });
                            },
                          ),
                        ),
                        Visibility(
                          visible: _encaminharReciclagem,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  width: width,
                                  color: Colors.grey[50],
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Sinistro n.',
                                      labelStyle: GoogleFonts.poppins(
                                          fontSize: 14, color: Colors.black87),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Justificativa',
                                        style:
                                            GoogleFonts.poppins(fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: TextFormField(
                                            minLines: 5,
                                            maxLines: 5,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelStyle: GoogleFonts.poppins(
                                                    fontSize: 11))))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Container(
                          color: Colors.grey[200],
                          width: double.infinity,
                          child: FlatButton(
                            child: Row(
                              children: [
                                Container(
                                  width: width,
                                  height: 50,
                                  child: CheckboxListTile(
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: const Text('OUTROS',
                                        style: TextStyle(fontSize: 14.0)),
                                    activeColor: Colors.black,
                                    selected: _isCheckedOutros,
                                    value: _isCheckedOutros,
                                    onChanged: (bool value) {
                                      setState(() {
                                        _isCheckedOutros = value;
                                        _encaminharOutros = !_encaminharOutros;
                                      });
                                    },
                                  ),
                                )
                              ],
                            ),
                            onPressed: () {
                              setState(() {
                                _encaminharOutros = !_encaminharOutros;
                              });
                            },
                          ),
                        ),
                        Visibility(
                          visible: _encaminharOutros,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 20),
                                child: Container(
                                  width: width,
                                  color: Colors.grey[50],
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Sinistro n.',
                                      labelStyle: GoogleFonts.poppins(
                                          fontSize: 14, color: Colors.black87),
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      flex: 2,
                                      child: Text(
                                        'Justificativa',
                                        style:
                                            GoogleFonts.poppins(fontSize: 14),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 4,
                                        child: TextFormField(
                                            minLines: 5,
                                            maxLines: 5,
                                            decoration: InputDecoration(
                                                border: InputBorder.none,
                                                labelStyle: GoogleFonts.poppins(
                                                    fontSize: 11))))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20.0,
                  ),
                  // Row(
                  //   children: <Widget>[
                  //     Radio(
                  //       value: 1,
                  //       activeColor: Colors.black87,
                  //       groupValue: selectedRadioEncaminhar,
                  //       onChanged: (val) {
                  //         setState(() {
                  //           encaminharJustificativa = true;
                  //           // encaminharJustificativaReciclagem = false;
                  //           // encaminharJustificativaSeguro = false;
                  //           encaminharJustificativaOutro = false;
                  //           radioButtonItemEncaminhar = 'ONE';
                  //           setSelectedRadioEncaminhar(val);
                  //         });
                  //       },
                  //     ),
                  //     Flexible(
                  //         child: GestureDetector(
                  //       onTap: () {
                  //         setState(() {
                  //           encaminharJustificativa = true;
                  //           encaminharJustificativaOutro = false;
                  //           radioButtonItemEncaminhar = 'ONE';
                  //           setSelectedRadioEncaminhar(1);
                  //         });
                  //       },
                  //       child: Text('JURÍDICO',
                  //           style: TextStyle(
                  //               color: Colors.grey[800], fontSize: 14.0)),
                  //     )),
                  //     Radio(
                  //       activeColor: Colors.black87,
                  //       value: 2,
                  //       groupValue: selectedRadioEncaminhar,
                  //       onChanged: (val) {
                  //         setState(() {
                  //           encaminharJustificativa = true;
                  //           encaminharJustificativaOutro = false;
                  //           radioButtonItemEncaminhar = 'TWO';
                  //           setSelectedRadioEncaminhar(val);
                  //         });
                  //       },
                  //     ),
                  //     Flexible(
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             encaminharJustificativa = true;
                  //             encaminharJustificativaOutro = false;
                  //             radioButtonItemEncaminhar = 'TWO';
                  //             setSelectedRadioEncaminhar(2);
                  //           });
                  //         },
                  //         child: Text('RECICLAGEM',
                  //             style: TextStyle(
                  //                 color: Colors.grey[800], fontSize: 14.0)),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Row(
                  //   children: [
                  //     Radio(
                  //       activeColor: Colors.black87,
                  //       value: 3,
                  //       groupValue: selectedRadioEncaminhar,
                  //       onChanged: (val) {
                  //         setState(() {
                  //           encaminharJustificativa = true;
                  //           encaminharJustificativaOutro = false;
                  //           radioButtonItemEncaminhar = 'THREE';
                  //           setSelectedRadioEncaminhar(val);
                  //         });
                  //       },
                  //     ),
                  //     Flexible(
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             encaminharJustificativa = true;
                  //             encaminharJustificativaOutro = false;
                  //             radioButtonItemEncaminhar = 'THREE';
                  //             setSelectedRadioEncaminhar(3);
                  //           });
                  //         },
                  //         child: Text('SEGURO',
                  //             style: TextStyle(
                  //                 color: Colors.grey[800], fontSize: 14.0)),
                  //       ),
                  //     ),
                  //     Radio(
                  //       activeColor: Colors.black87,
                  //       value: 4,
                  //       groupValue: selectedRadioEncaminhar,
                  //       onChanged: (val) {
                  //         setState(() {
                  //           encaminharJustificativaOutro = true;
                  //           encaminharJustificativa = false;
                  //           radioButtonItemEncaminhar = 'FOUR';
                  //           setSelectedRadioEncaminhar(val);
                  //         });
                  //       },
                  //     ),
                  //     Flexible(
                  //       child: GestureDetector(
                  //         onTap: () {
                  //           setState(() {
                  //             encaminharJustificativaOutro = true;
                  //             encaminharJustificativa = false;
                  //             radioButtonItemEncaminhar = 'FOUR';
                  //             setSelectedRadioEncaminhar(4);
                  //           });
                  //         },
                  //         child: Text('OUTROS',
                  //             style: TextStyle(
                  //                 color: Colors.grey[800], fontSize: 14.0)),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // Column(
                  //   children: [
                  //     Stack(
                  //       children: [
                  //         Visibility(
                  //           visible: encaminharJustificativa,
                  //           child: Column(
                  //             children: [
                  //               Divider(
                  //                 thickness: 0.7,
                  //               ),
                  //               Padding(
                  //                 padding: const EdgeInsets.only(top: 20),
                  //                 child: Container(
                  //                   width: width,
                  //                   color: Colors.grey[50],
                  //                   child: TextFormField(
                  //                     decoration: InputDecoration(
                  //                       border: InputBorder.none,
                  //                       labelText: 'Sinistro n.',
                  //                       labelStyle: GoogleFonts.poppins(
                  //                           fontSize: 14,
                  //                           color: Colors.black87),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               Padding(
                  //                 padding: const EdgeInsets.only(left: 20),
                  //                 child: Row(
                  //                   children: [
                  //                     Expanded(
                  //                       flex: 2,
                  //                       child: Text(
                  //                         'Justificativa',
                  //                         style:
                  //                             GoogleFonts.poppins(fontSize: 14),
                  //                       ),
                  //                     ),
                  //                     Expanded(
                  //                         flex: 4,
                  //                         child: TextFormField(
                  //                             minLines: 5,
                  //                             maxLines: 5,
                  //                             decoration: InputDecoration(
                  //                                 border: InputBorder.none,
                  //                                 labelStyle:
                  //                                     GoogleFonts.poppins(
                  //                                         fontSize: 11))))
                  //                   ],
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //         Visibility(
                  //           visible: encaminharJustificativaOutro,
                  //           child: Column(
                  //             children: [
                  //               Divider(
                  //                 thickness: 0.7,
                  //               ),
                  //               Padding(
                  //                 padding: const EdgeInsets.only(top: 20),
                  //                 child: Container(
                  //                   width: width,
                  //                   color: Colors.grey[50],
                  //                   child: TextFormField(
                  //                     decoration: InputDecoration(
                  //                       border: InputBorder.none,
                  //                       labelText: 'Sinistro n.',
                  //                       labelStyle: GoogleFonts.poppins(
                  //                           fontSize: 14,
                  //                           color: Colors.black87),
                  //                     ),
                  //                   ),
                  //                 ),
                  //               ),
                  //               Padding(
                  //                 padding: const EdgeInsets.only(left: 20),
                  //                 child: Row(
                  //                   children: [
                  //                     Expanded(
                  //                       flex: 2,
                  //                       child: Text(
                  //                         'Justificativa',
                  //                         style:
                  //                             GoogleFonts.poppins(fontSize: 14),
                  //                       ),
                  //                     ),
                  //                     Expanded(
                  //                         flex: 4,
                  //                         child: TextFormField(
                  //                             minLines: 5,
                  //                             maxLines: 5,
                  //                             decoration: InputDecoration(
                  //                                 border: InputBorder.none,
                  //                                 labelStyle:
                  //                                     GoogleFonts.poppins(
                  //                                         fontSize: 11))))
                  //                   ],
                  //                 ),
                  //               ),
                  //             ],
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text('Documentos pessoais',
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 14.0)),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          thickness: 0.7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 20),
                          child: Row(
                            children: [
                              Container(
                                width: width,
                                color: Colors.grey[50],
                                child: TextFormField(
                                    onSaved: (value) {
                                      setState(() {
                                        numCNH = true;
                                      });
                                    },
                                    onChanged: (value) {
                                      setState(() {
                                        numCNH = true;
                                      });
                                    },
                                    validator: (value) {
                                      if (value.isEmpty) {
                                        return 'Digite a CNH';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                        border: InputBorder.none,
                                        hintText: 'Número de Registro CNH',
                                        hintStyle: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black87))),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                width: width,
                                color: Colors.grey[50],
                                child: TextFormField(
                                  // validator: (value) {
                                  //   if (value.isEmpty) {
                                  //     return 'Digite a Data';
                                  //   }
                                  //   return null;
                                  // },
                                  onSaved: (value) {
                                    setState(() {
                                      dataCNH = true;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      dataCNH = true;
                                    });
                                  },
                                  validator: composeValidators('data',
                                      [requiredValidator, dataValidator]),
                                  controller: dataVencimentoController,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'Data de Vencimento',
                                    hintStyle: GoogleFonts.poppins(
                                        fontSize: 14, color: Colors.black87),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                width: width,
                                color: Colors.grey[50],
                                child: TextFormField(
                                  onSaved: (value) {
                                    setState(() {
                                      numCPF = true;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      numCPF = true;
                                    });
                                  },
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
                                      hintStyle: GoogleFonts.poppins(
                                          fontSize: 14, color: Colors.black87)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                width: width,
                                color: Colors.grey[50],
                                child: TextFormField(
                                  onSaved: (value) {
                                    setState(() {
                                      idade = true;
                                    });
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      idade = true;
                                    });
                                  },
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
                                      hintStyle: GoogleFonts.poppins(
                                          fontSize: 14, color: Colors.black87)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Container(
                                width: width,
                                child: Text(
                                  'Estado Civil',
                                  style: GoogleFonts.poppins(
                                      fontSize: 14, color: Colors.black87),
                                ),
                              ),
                              Row(
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
                                  GestureDetector(
                                    child: Text('SOLTEIRO',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black87)),
                                    onTap: () {
                                      setState(() {
                                        radioButtonItemEstadoCivil = 'ONE';
                                        idEstadoCivil = 1;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
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
                                  GestureDetector(
                                    child: Text('CASADO',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black87)),
                                    onTap: () {
                                      setState(() {
                                        radioButtonItemEstadoCivil = 'TWO';
                                        idEstadoCivil = 2;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
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
                                  GestureDetector(
                                    child: Text('DIVORCIADO',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black87)),
                                    onTap: () {
                                      setState(() {
                                        radioButtonItemEstadoCivil = 'THREE';
                                        idEstadoCivil = 3;
                                      });
                                    },
                                  ),
                                ],
                              ),
                              Row(
                                children: [
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
                                  GestureDetector(
                                    child: Text('VIÚVO',
                                        style: GoogleFonts.poppins(
                                            fontSize: 14,
                                            color: Colors.black87)),
                                    onTap: () {
                                      setState(() {
                                        radioButtonItemEstadoCivil = 'FOUR';
                                        idEstadoCivil = 4;
                                      });
                                    },
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text('Registros do Acidente',
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 14.0)),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          thickness: 0.7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 20),
                          child: Row(
                            children: [
                              Container(
                                width: width,
                                color: Colors.grey[50],
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'BO n.',
                                      labelStyle: GoogleFonts.poppins(
                                          fontSize: 14, color: Colors.black87)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                width: width,
                                color: Colors.grey[50],
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'DP do BO',
                                      labelStyle: GoogleFonts.poppins(
                                          fontSize: 14, color: Colors.black87)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Divider(
                          thickness: 0.7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 20),
                          child: Row(
                            children: [
                              Container(
                                width: width,
                                color: Colors.grey[50],
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'IC',
                                      labelStyle: GoogleFonts.poppins(
                                          fontSize: 14, color: Colors.black87)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                  left: 20,
                  right: 20,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Flexible(
                            child: Text('Dados do Veículo',
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 14.0)),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Divider(
                          thickness: 0.7,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10, top: 20),
                          child: Row(
                            children: [
                              Container(
                                width: width,
                                color: Colors.grey[50],
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Chassi',
                                      labelStyle: GoogleFonts.poppins(
                                          fontSize: 14, color: Colors.black87)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Row(
                            children: [
                              Container(
                                width: width,
                                color: Colors.grey[50],
                                child: TextFormField(
                                  decoration: InputDecoration(
                                      border: InputBorder.none,
                                      labelText: 'Ano Fabricação\/Modelo',
                                      labelStyle: GoogleFonts.poppins(
                                          fontSize: 14, color: Colors.black87)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 30,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(
            height: 80,
          )
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: FlatButton(
        onPressed: () {
          if (_isentoField == true &&
              _bafometroField == true &&
              (encaminharJustificativa == true ||
                  encaminharJustificativaOutro == true) &&
              numCNH == true &&
              dataCNH == true &&
              numCPF == true &&
              idade == true) {
            showDialog(
              context: context,
              builder: (BuildContext context) {
                // return object of type Dialog
                return AlertDialogForm(
                  textAlert: 'Formulário registrado com sucesso!',
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                );
              },
            );
            Future.delayed(const Duration(milliseconds: 3000), () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => //ResumoAnaliseDeMonitoramento
                      DashboardScreen(sol: sol, user: user, token: token
                          //textSucesso: textSucesso,
                          //alertSucessoVisible: alertSucessoVisible,

                          ),
                ),
              );
            });
          } else {
            final semCadastro = new SnackBar(
                content: new Text('Preencha todos os campos para prosseguir!'));
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
          child: Center(
              child: const Text('CONCLUIR', style: TextStyle(fontSize: 20))),
        ),
      ),
    );
  }
}
