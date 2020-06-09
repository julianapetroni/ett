import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/style/lightColors.dart';
import 'package:flutter/services.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import 'ambiente.dart';
import 'avariasOnibus.dart';
import 'login.dart';

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

  class SelecaoMultiplaTagState
  extends State<SelecaoMultiplaTag> {
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

  var _isChecked = new List<bool>.filled(10, false);

  void onChanged(bool value) {
    setState(() {
      _isChecked[0] = value;
    });}
  void onChanged2(bool value) {
    setState(() {
      _isChecked[1] = value;
    });}
  void onChanged3(bool value) {
    setState(() {
      _isChecked[2] = value;
    });}
  void onChanged4(bool value) {
    setState(() {
      _isChecked[3] = value;
    });}

  //Obs.
  final _obsController = TextEditingController();
  TextEditingController _obstextFieldController = TextEditingController();

  //obs.

  int _obscharCount = 700;

  _onChanged(String value) {
    setState(() {
      _obscharCount = 700 - value.length;
    });
  }

  @override
  Widget build(BuildContext context) {
    //selecaomultipla com tag
    List _myActivities;
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


    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: LightColors.kDarkYellow,
        elevation: 0.0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Form(
              key: _formTipoOcorrenciaKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: MultiSelectFormField(
                      fillColor: LightColors.kLightYellow,
                      autovalidate: false,
                      titleText: 'Tipo de ocorrência',
                      validator: (value) {
                        if (value == null || value.length == 0) {
                          return 'Escolha uma ou mais opções';
                        }
                      },
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
                      hintText: 'Escolha uma ou mais opções',
                      border: InputBorder.none,

                      //value: _myActivities,
                      onSaved: (value) {
                        if (value == null) return;
                        setState(() {
                          _myActivities = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),


            Form(
              key: _formCondViaKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: MultiSelectFormField(
                      fillColor: LightColors.kLightYellow,
                      autovalidate: false,
                      titleText: 'Condições da via',
                      validator: (value) {
                        if (value == null || value.length == 0) {
                          return 'Escolha uma ou mais opções';
                        }
                      },
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

                      required: true,
                      hintText: 'Escolha uma ou mais opções',
                      border: InputBorder.none,

                      //value: _myActivities,
                      onSaved: (value) {
                        if (value == null) return;
                        setState(() {
                          _myActivities = value;
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

            Form(
              key: _formSemaforoKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: MultiSelectFormField(
                      fillColor: LightColors.kLightYellow,
                      autovalidate: false,
                      titleText: 'Semáforo',
                      validator: (value) {
                        if (value == null || value.length == 0) {
                          return 'Escolha uma ou mais opções';
                        }
                      },
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

                      required: true,
                      hintText: 'Escolha uma ou mais opções',
                      border: InputBorder.none,

                      //value: _myActivities,
                      onSaved: (value) {
                        if (value == null) return;
                        setState(() {
                          _myActivities = value;
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),

            Form(
              key: _formPlacasKey,
              child: Column(
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.all(16),
                    child: MultiSelectFormField(
                      fillColor: LightColors.kLightYellow,
                      autovalidate: false,
                      titleText: 'Placas',
                      validator: (value) {
                        if (value == null || value.length == 0) {
                          return 'Escolha uma ou mais opções';
                        }
                      },
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

                      required: true,
                      hintText: 'Escolha uma ou mais opções',
                      border: InputBorder.none,

                      //value: _myActivities,
                      onSaved: (value) {
                        if (value == null) return;
                        setState(() {
                          _myActivities = value;
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



            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 40, bottom: 40),
              child: FlatButton(
                onPressed: () {
                  setState(() {
                    _myActivitiesResult = _myActivities.toString();
                  });

                  if (_formTipoOcorrenciaKey.currentState.validate()
                      &&_formCondViaKey.currentState.validate()
                      && _formSemaforoKey.currentState.validate()
                      && _formPlacasKey.currentState.validate()
                  ) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Ambiente(
                            user: user,
                            token: token,
                            sol: sol,
                          )),
                    );
                  }else {
                    final semCadastro =
                    new SnackBar(content: new Text('Escolha as opções para prosseguir!'));
                    _scaffoldKey.currentState.showSnackBar(semCadastro);
                  }
                },
                textColor: Colors.white,
                color: Colors.white,
                child: Container(
                  width: double.infinity,
                  height: 45.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    gradient: LinearGradient(
                      colors: <Color>[
                        Colors.yellow[800],
                        Colors.yellow[700],
                        Colors.yellow[600],
                      ],
                    ),
                  ),
                  //padding: const EdgeInsets.fromLTRB(90.0, 15.0, 90.0, 15.0),
                  child: Center(
                      child: const Text('PROSSEGUIR',
                          style: TextStyle(fontSize: 20))),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}




