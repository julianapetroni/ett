import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/domains/usuario.dart';

import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/style/light_colors.dart';
import 'package:flutter/services.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'ambiente.page.dart';
import 'package:ett_app/services/token.dart';

class SelecaoMultiplaTag extends StatefulWidget {
  Solicitacao sol;
  Usuario user;
  Token token;

  SelecaoMultiplaTag({Key key, this.sol, this.user, this.token})
      : super(key: key);

  @override
  SelecaoMultiplaTagState createState() {
    return SelecaoMultiplaTagState(sol: sol, user: user, token: token);
  }
}

class SelecaoMultiplaTagState extends State<SelecaoMultiplaTag> {
  Solicitacao sol;
  Usuario user;
  Token token;

  SelecaoMultiplaTagState({this.sol, this.user, this.token});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _formTipoOcorrenciaKey = GlobalKey<FormState>();
  final _formCondViaKey = GlobalKey<FormState>();
  final _formSemaforoKey = GlobalKey<FormState>();
  final _formPlacasKey = GlobalKey<FormState>();
  final _formAmbienteKey = GlobalKey<FormState>();

  final _formTipoOcorrenciaController = TextEditingController();
  final _formCondViaKeyController = TextEditingController();
  final _formSemaforoKeyController = TextEditingController();
  final _formPlacasKeyController = TextEditingController();
  final _formAmbienteKeyController = TextEditingController();

  @override
  dispose() {
    //Form
    _obsController.dispose();
    _formTipoOcorrenciaController.dispose();
    _formCondViaKeyController.dispose();
    _formSemaforoKeyController.dispose();
    _formPlacasKeyController.dispose();
    _formAmbienteKeyController.dispose();

    super.dispose();
  }

  //radio button
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItemAmbiente = 'ONE';
  // Group Value for Radio Button.
  int idAmbiente = 1;
  bool rbAmbiente = false;

  bool _tipoOcorrencia = false;

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

  //Obs.
  final _obsController = TextEditingController();
  TextEditingController _obstextFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    //selecaomultipla com tag
    List _myActivities;
    List _condicoesViaValue;
    List _semaforoValue;
    List _placasValue;
    String _myActivitiesResult;
    final formKey = new GlobalKey<FormState>();

    _saveForm() {
      var form = formKey.currentState;
      if (form.validate()) {
        form.save();
        setState(() {
          _myActivitiesResult = _myActivities.toString();
        });
      }
    }

    @override
    void initState() {
      super.initState();
      _myActivities = [];
      _myActivitiesResult = '';
    }

    return MaterialApp(
      theme: _buildTheme(context),
      home: Scaffold(
        key: _scaffoldKey,
        appBar: _buildAppBar(context),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Expanded(
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
                child: Theme(
                    data: Theme.of(context).copyWith(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      colorScheme: ColorScheme.light(
                        primary: Colors.black87,
                      ),
                      primaryColorBrightness: Brightness.light,
//                                          primaryColor: LightColors.neonETT, //color of the main banner
//                                          accentColor: LightColors.neonETT, //color of circle indicating the selected date
                      buttonTheme: ButtonThemeData(
                          textTheme: ButtonTextTheme
                              .accent //color of the text in the button "OK/CANCEL"
                          ),
                    ),
                    child: Builder(builder: (context) {
                      return SingleChildScrollView(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              child: Form(
                                // key: formKey,
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      padding: EdgeInsets.all(16),
                                      child: MultiSelectFormField(
                                        fillColor:
                                            Colors.white.withOpacity(0.7),
                                        title: Text('Tipo de ocorrência'),
                                        dataSource: [
                                          {
                                            "display": "Albarroamento",
                                            "value": "Albarroamento",
                                          },
                                          {
                                            "display": "Atropelamento",
                                            "value": "Atropelamento",
                                          },
                                          {
                                            "display": "Choque",
                                            "value": "Choque",
                                          },
                                          {
                                            "display": "Colisão Frontal",
                                            "value": "Colisão Frontal",
                                          },
                                          {
                                            "display": "Colisão Lateral",
                                            "value": "Colisão Lateral",
                                          },
                                          {
                                            "display": "Colisão Traseira",
                                            "value": "Colisão Traseira",
                                          },
                                          {
                                            "display": "Engavetamento",
                                            "value": "Engavetamento",
                                          },
                                          {
                                            "display": "Roubo ou Assalto",
                                            "value": "Roubo ou Assalto",
                                          },
                                          {
                                            "display": "Tombamento",
                                            "value": "Tombamento",
                                          },
                                          {
                                            "display": "Vandalismo",
                                            "value": "Vandalismo",
                                          },
                                        ],
                                        textField: 'display',
                                        valueField: 'value',
                                        okButtonLabel: 'OK',
                                        cancelButtonLabel: 'CANCELAR',
                                        required: true,
                                        hintWidget:
                                            Text('Escolha uma ou mais opções'),
                                        border: InputBorder.none,
                                        onSaved: (value) {
                                          if (value != null) {
                                            setState(() {
                                              _tipoOcorrencia = true;
                                              _myActivities = value;
                                            });
                                          }
                                          print('save');
                                          print(_tipoOcorrencia);
                                        },
                                        change: (value) {
                                          if (value != null) {
                                            setState(() {
                                              _tipoOcorrencia = true;
                                              _myActivities = value;
                                            });
                                          }
                                          print('change');
                                          print(_tipoOcorrencia);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Form(
                              // key: _formCondViaKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    child: MultiSelectFormField(
                                      fillColor: Colors.white.withOpacity(0.7),
                                      autovalidate: false,
                                      title: Text('Condições da via'),
                                      // validator: (value) {
                                      //   if (value == null ||
                                      //       value.length == 0) {
                                      //     return 'Escolha uma ou mais opções';
                                      //   }
                                      //   return '';
                                      // },
                                      dataSource: [
                                        {
                                          "display": "Asfalto",
                                          "value": "Asfalto",
                                        },
                                        {
                                          "display": "Cascalho",
                                          "value": "Cascalho",
                                        },
                                        {
                                          "display": "Paralelepípedo",
                                          "value": "Paralelepípedo",
                                        },
                                        {
                                          "display": "Terra",
                                          "value": "Terra",
                                        },
                                        {
                                          "display": "Em obras",
                                          "value": "Em obras",
                                        },
                                        {
                                          "display": "Boa",
                                          "value": "Boa",
                                        },
                                        {
                                          "display": "Seca",
                                          "value": "Seca",
                                        },
                                        {
                                          "display": "Molhada",
                                          "value": "Molhada",
                                        },
                                        {
                                          "display": "Oleosa",
                                          "value": "Oleosa",
                                        },
                                        {
                                          "display": "Lombada",
                                          "value": "Lombada",
                                        },
                                      ],

                                      textField: 'display',
                                      valueField: 'value',
                                      okButtonLabel: 'OK',
                                      cancelButtonLabel: 'CANCELAR',
                                      required: false,
                                      hintWidget:
                                          Text('Escolha uma ou mais opções'),
                                      border: InputBorder.none,

                                      onSaved: (value) {
                                        if (value == null) return;
                                        setState(() {
                                          _condicoesViaValue = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Form(
                              // key: _formSemaforoKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    child: MultiSelectFormField(
                                      fillColor: Colors.white.withOpacity(0.7),
                                      autovalidate: false,
                                      title: Text('Semáforo'),
                                      // validator: (value) {
                                      //   if (value == null ||
                                      //       value.length == 0) {
                                      //     return 'Escolha uma ou mais opções';
                                      //   }
                                      //   return '';
                                      // },
                                      dataSource: [
                                        {
                                          "display": "Existente",
                                          "value": "Existente",
                                        },
                                        {
                                          "display": "Inexistente",
                                          "value": "Inexistente",
                                        },
                                        {
                                          "display": "Funcionando",
                                          "value": "Funcionando",
                                        },
                                        {
                                          "display": "Intermitente",
                                          "value": "Intermitente",
                                        },
                                      ],

                                      textField: 'display',
                                      valueField: 'value',
                                      okButtonLabel: 'OK',
                                      cancelButtonLabel: 'CANCELAR',

                                      required: false,
                                      hintWidget:
                                          Text('Escolha uma ou mais opções'),
                                      border: InputBorder.none,

                                      onSaved: (value) {
                                        if (value == null) return;
                                        setState(() {
                                          _semaforoValue = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Form(
                              // key: _formPlacasKey,
                              child: Column(
                                children: <Widget>[
                                  Container(
                                    padding: EdgeInsets.all(16),
                                    child: MultiSelectFormField(
                                      fillColor: Colors.white.withOpacity(0.7),
                                      autovalidate: false,
                                      title: Text('Placas'),
                                      // validator: (value) {
                                      //   if (value == null ||
                                      //       value.length == 0) {
                                      //     return 'Escolha uma ou mais opções';
                                      //   }
                                      //   return '';
                                      // },
                                      dataSource: [
                                        {
                                          "display": "Regulamentação",
                                          "value": "Regulamentação",
                                        },
                                        {
                                          "display": "Advertência",
                                          "value": "Advertência",
                                        },
                                        {
                                          "display": "Sinalização",
                                          "value": "Sinalização",
                                        },
                                        {
                                          "display": "Nenhuma",
                                          "value": "Nenhuma",
                                        },
                                      ],

                                      textField: 'display',
                                      valueField: 'value',
                                      okButtonLabel: 'OK',
                                      cancelButtonLabel: 'CANCELAR',

                                      required: false,
                                      hintWidget:
                                          Text('Escolha uma ou mais opções'),
                                      border: InputBorder.none,

                                      onSaved: (value) {
                                        if (value == null) return;
                                        setState(() {
                                          _placasValue = value;
                                        });
                                      },
                                    ),
                                  ),
//                    Container(
//                      padding: EdgeInsets.all(8),
//                      child: RaisedButton(
//                        child: Text('Save'),
//                        onPressed: _saveForm,
//                      ),
//                    ),
//                    Container(
//                      padding: EdgeInsets.all(16),
//                      child: Text(_myActivitiesResult),
//                    )
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    })),
              ),
            ),
          ],
        ),
        floatingActionButton: Padding(
          padding: const EdgeInsets.only(left: 20, bottom: 10),
          child: FlatButton(
            onPressed: () {
              setState(() {
                _myActivitiesResult = _myActivities.toString();
              });

              if (_tipoOcorrencia == true
                  //_formTipoOcorrenciaKey.currentState.validate()
                  // &&
                  // _formCondViaKey.currentState.validate() &&
                  // _formSemaforoKey.currentState.validate() &&
                  // _formPlacasKey.currentState.validate()
                  ) {
                print(_myActivities);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Ambiente(
                            user: user,
                            token: token,
                            sol: sol,
                          )),
                );
              } else {
                print(_myActivities);
                final semCadastro = new SnackBar(
                    content: new Text('Escolha as opções para prosseguir!'));
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
                  child:
                      const Text('PROSSEGUIR', style: TextStyle(fontSize: 20))),
            ),
          ),
        ),
      ),
    );
  }

  _buildTheme(BuildContext context) {
    return ThemeData(
      // primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
      textTheme: TextTheme(
        title: TextStyle(
          fontFamily: "stonehenge",
          fontWeight: FontWeight.bold,
          fontSize: 16.0,
        ),
        //título
        body1: Theme.of(context).textTheme.body1.merge(
              const TextStyle(
                color: Colors.black87,
              ),
            ),
      ),
      primaryColor: Colors.black,
      primarySwatch: Colors.orange,
      accentColor: Colors.black,
      accentColorBrightness: Brightness.dark,
      fontFamily: 'poppins',
      canvasColor: Colors.white,
      scaffoldBackgroundColor: LightColors.kLightYellow2,
      hintColor: Colors.grey[600],
      hoverColor: Colors.amber,
      splashColor: LightColors.kDarkYellow,
      dividerColor: LightColors.kLightYellow2,
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding:
            const EdgeInsets.only(top: 130, left: 90, right: 150, bottom: 130),
        child: Image.asset(GeneralConfig.logoImage),
      ),
      iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
      backgroundColor: LightColors.neonYellowLight,
      elevation: 0.0,
      leading: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Align(
            alignment: Alignment.centerLeft,
            child: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: LightColors.neonYellowDark,
            ),
          ),
        ),
      ),
    );
  }
}
