import 'dart:async';
import 'dart:convert';
import 'package:ett_app/screens/analise_monitoramento/ui/selecao_multipla_com_tag.dart';
import 'package:ett_app/services/token.dart';
import 'package:ett_app/widgets/dialog/alert_dialog_form.dart';
import 'package:ett_app/widgets/formUI/button/button_decoration.dart';
import 'package:ett_app/widgets/calendario/calendario.dart';
import 'package:ett_app/widgets/calendario/calendario_data_hora_decoracao.dart';
import 'package:ett_app/widgets/formUI/text_pattern/hint_text_form.dart';
import 'package:ett_app/widgets/formUI/dropdown/mensagem_erro_dropdown.dart';
import 'package:ett_app/widgets/formUI/text_pattern/text_row.dart';
import 'package:ett_app/widgets/logo_config/logo_ett_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/size_config.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../../../style/light_colors.dart';
import '../../../style/top_container.dart';
import "package:flutter/painting.dart";
import "package:flutter/foundation.dart";
import 'package:flutter_masked_text/flutter_masked_text.dart';
import '../../dashboard/ui/dasboard.page.dart';
import 'package:flutter/widgets.dart';

class RelatorioOcorrenciaTransito extends StatefulWidget {
  Solicitacao sol;
  Usuario user;
  Token token;

  RelatorioOcorrenciaTransito({Key key, this.sol, this.user, this.token})
      : super(key: key);

  @override
  RelatorioOcorrenciaTransitoState createState() {
    return RelatorioOcorrenciaTransitoState(sol: sol, user: user, token: token);
  }
}

class RelatorioOcorrenciaTransitoState
    extends State<RelatorioOcorrenciaTransito> {
  Solicitacao sol;
  Usuario user;
  Token token;

  RelatorioOcorrenciaTransitoState({this.sol, this.user, this.token});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //Form
  final GlobalKey<FormFieldState<String>> _monitorKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _nomeKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _prefixoMonitKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _placaKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _linhaKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _sentidoKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _localAcKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _alturaKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _motorista1Key =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _matriculaKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _matricula1Key =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _matricula3Key =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _motorista2Key =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _matricula2Key =
      GlobalKey<FormFieldState<String>>();

//Form
  TextEditingController _textFieldController = TextEditingController();
  final _nomeController = TextEditingController();
  final _monitorController = TextEditingController();
  final _prefixoController = TextEditingController();
  final _placaController = TextEditingController();
  final _linhaController = TextEditingController();
  final _sentidoController = TextEditingController();
  final _localAcController = TextEditingController();
  final _alturaController = TextEditingController();
  final _motorista1Controller = TextEditingController();
  final _matriculaController = TextEditingController();
  final _matricula1Controller = TextEditingController();
  final _motorista2Controller = TextEditingController();
  final _matricula2Controller = TextEditingController();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = true;
  bool isMessageValidated = false;

  bool validateTextField(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        isMessageValidated = true;
      });
      return false;
    }
    setState(() {
      isMessageValidated = false;
    });
    return true;
  }

  //Mask
  var matriculaController = new MaskedTextController(mask: '000000');
  var matricula1Controller = new MaskedTextController(mask: '000000');
  var matricula2Controller = new MaskedTextController(mask: '000000');
  var matricula3Controller = new MaskedTextController(mask: '000000');
  var matriculaMonitController = new MaskedTextController(mask: '000000');
  var telController = new MaskedTextController(mask: '(00)00000-0000');
  var dataController = new MaskedTextController(mask: '00/00/0000');
  var data1Controller = new MaskedTextController(mask: '00/00/0000');
  var horaController = new MaskedTextController(mask: '00:00');
  var hora1Controller = new MaskedTextController(mask: '00:00');
  var prefixoController = new MaskedTextController(mask: '000000');
  var dataVencimentoController = new MaskedTextController(mask: '00/00/0000');
  var cpfController = new MaskedTextController(mask: '000.000.000-00');
  var idadeController = new MaskedTextController(mask: '00');

  bool complete = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formSOKey = GlobalKey<FormState>();

  @override
  dispose() {
    _nomeController.dispose();
    _monitorController.dispose();
    _matriculaController.dispose();
    _matricula1Controller.dispose();
    _prefixoController.dispose();
    _placaController.dispose();
    _linhaController.dispose();
    _sentidoController.dispose();
    _localAcController.dispose();
    _alturaController.dispose();
    _motorista1Controller.dispose();
    _matricula1Controller.dispose();
    _motorista2Controller.dispose();
    _matricula2Controller.dispose();

    super.dispose();
  }

  bool ocorrencia = false;
//  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem;
//  // Group Value for Radio Button.
  int id = 1;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        //locale: Locale("pt"),
        initialDate: selectedDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        dataSelecionada = true;
        fraseSelecao = false;
        selectedDate = picked;
        linhaVisivel = false;
        semData = null;
      });
  }

  bool dataSelecionada = false;
  bool fraseSelecao = true;
  bool linhaVisivel = false;
  var semData;
  DateTime selectedDate = DateTime.now().toLocal();

  DateTime picked;
  DateTime pickedAc;

  var semDataAc;
  bool linhaVisivelAc = false;
  DateTime selectedDateAc = DateTime.now().toLocal();

  _validateForm() {
    bool _isValid = _formKey.currentState.validate();

    if (dataSelecionada == false) {
      setState(() {
        linhaVisivel = true;
        semData = ' ';
      });
      _isValid = false;
    }

    if (horaEscolhida == false) {
      setState(() {
        linhaVisivelAc = true;
        semDataAc = ' ';
//        fraseHoraEscolhida = true;
      });
      _isValid = false;
    }

    if (_isValid) {
      //form is valid
    }
  }

  DateTime _dateTime = DateTime.now().toLocal();
  bool horaEscolhida = false;
  bool fraseHoraEscolhida = true;

  @override
  Widget build(BuildContext context) {
    @override
    void initState() {
      super.initState();
    }

    SizeConfig().init(context);
    return Scaffold(
      // key: _scaffoldKey,
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: LightColors.neonYellowLight,
      elevation: 0.0,
      iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
      leading: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DashboardScreen(
                      user: user,
                      token: token,
                      sol: sol,
                    )),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 10),
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

  Widget _buildBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final halfMediaWidth = MediaQuery.of(context).size.width * 0.5;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String formattedTime = DateFormat('kk:mm:ss').format(now);
    int selectedValue;
    String _mySelectionSentido;

    return ListView(children: <Widget>[
      TopContainer(
        padding: EdgeInsets.only(bottom: 40.0),
        width: width,
        child: Column(
          children: <Widget>[
            LogoETTForm(80.0),
            SizedBox(height: 30.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Expanded(
                  child: TextRow('Análise de Monitoramento', Colors.black87),
                ),
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.only(left: 24, right: 24),
              child: Form(
                key: _formKey,
                // autovalidate: true,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    //Matricula
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Matrícula',
                              labelStyle: TextStyle(
                                  fontSize: 13.0, color: Colors.grey[600]),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[600], width: 2.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[300], width: 2.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            keyboardType: TextInputType.number,
                            controller: matriculaController,
                            validator: composeValidators('matricula', [
                              requiredValidator,
                              numberValidator,
                              minLengthValidator
                            ]),
                            onSaved: (value) => _loginData.matricula = value,
                          ),
                          // key: _matriculaKey,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),
//Monitor
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            controller: _monitorController,
                            validator: composeValidators('monitor',
                                [requiredValidator, stringValidator]),
                            decoration: InputDecoration(
                              labelText: 'Monitor',
                              labelStyle: TextStyle(
                                  fontSize: 13.0, color: Colors.grey[600]),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[600], width: 2.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[300], width: 2.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            onSaved: (value) => _loginData.monitor = value,
                          ),
                          // key: _monitorKey,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 8,
                    ),

//Nome
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Nome',
                              labelStyle: TextStyle(
                                  fontSize: 13.0, color: Colors.grey[600]),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[600], width: 2.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.grey[300], width: 2.0),
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                            ),
                            controller:
                                TextEditingController(text: '${user.nome}'),
                            validator: composeValidators(
                                'nome', [requiredValidator, stringValidator]),
                            onSaved: (value) => _loginData.nome = value,
                          ),
                          // key: _nomeKey,
                        ),
                      ],
                    ),

                    SizedBox(
                      height: 8.0,
                    ),

                    Container(
                      decoration: linhaVisivel == false
                          ? BoxDecoration(
                              border: new Border(
                              left: BorderSide(
                                  color: Colors.grey[300], width: 1.5),
                              right: BorderSide(
                                  color: Colors.grey[300], width: 1.5),
                              top: BorderSide(
                                  color: Colors.grey[300], width: 1.5),
                            ))
                          : BoxDecoration(
                              border: new Border(
                                  bottom: BorderSide(
                                      color: Colors.grey[300], width: 1.5))),
                      child: Calendario(_selectDate, dataSelecionada,
                          fraseSelecao, linhaVisivel, semData, selectedDate),
                    ),

                    MensagemErroDropDown(linhaVisivel, "Selecione uma data!"),
                    SizedBox(height: 8),

                    CalendarioDataEHoraDecoracao(
                      semDataAc,
                      FlatButton(
                        child: HintTextForm(fraseHoraEscolhida,
                            'Selecione o dia e hora', horaEscolhida, _dateTime),
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
                                          mode: CupertinoDatePickerMode
                                              .dateAndTime,
                                          initialDateTime: _dateTime,
                                          use24hFormat: true,
                                          onDateTimeChanged: (dateTime) {
                                            setState(() {
                                              _dateTime = dateTime;
                                            });
                                          },
                                        ),
                                      ),
                                      Container(
                                        margin: const EdgeInsets.only(
                                            left: 20, right: 20),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5.0),
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
                                          child: TextRow("CONFIRMAR HORÁRIO",
                                              Colors.white),
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
                    ),

                    MensagemErroDropDown(
                        linhaVisivelAc, "Selecione a data e o horário!"),
                    SizedBox(height: 8),
                    Row(
                      children: <Widget>[
                        Expanded(
                          child: Container(
                            width: halfMediaWidth,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Prefixo',
                                labelStyle: TextStyle(
                                    fontSize: 13.0, color: Colors.grey[600]),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[600], width: 2.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[300], width: 2.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              // key: _prefixoMonitKey,
                              keyboardType: TextInputType.number,
                              controller: prefixoController,
                              validator: composeValidators('prefixo', [
                                requiredValidator,
                                numberValidator,
                                minLengthValidator
                              ]),
                              onSaved: (value) =>
                                  _loginData.prefixoMonit = value,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8.0,
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.topCenter,
                            width: halfMediaWidth,
                            child: TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Matrícula',
                                labelStyle: TextStyle(
                                    fontSize: 13.0, color: Colors.grey[600]),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[600], width: 2.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.grey[300], width: 2.0),
                                  borderRadius: BorderRadius.circular(5.0),
                                ),
                              ),
                              // key: _matricula2Key,
                              //maxLength: 7,
                              keyboardType: TextInputType.number,
                              controller: matricula2Controller,
                              validator: composeValidators('matrícula', [
                                requiredValidator,
                                placaValidator,
                                minLengthValidator
                              ]),
                              onSaved: (value) => _loginData.placa = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                            ),
                          ),
                        ),
                      ],
                    ),

//                          Ocorrência
                    Container(
                      padding: const EdgeInsets.only(top: 10, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Radio(
                            value: 1,
                            activeColor: Colors.black87,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                ocorrencia = false;
                                radioButtonItem = 'ONE';
                                id = 1;
                              });
                            },
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  ocorrencia = false;
                                  radioButtonItem = 'ONE';
                                  id = 1;
                                });
                              },
                              child: Text('Sem Ocorrência',
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 14.0)),
                            ),
                          ),
                          Radio(
                            activeColor: Colors.black87,
                            value: 2,
                            groupValue: id,
                            onChanged: (val) {
                              setState(() {
                                ocorrencia = true;
                                radioButtonItem = 'TWO';
                                id = 2;
                              });
                            },
                          ),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  ocorrencia = true;
                                  radioButtonItem = 'TWO';
                                  _autovalidate = false;
                                  id = 2;
                                });
                              },
                              child: Text('Com Ocorrência',
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 14.0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding: const EdgeInsets.only(
                          bottom: 10.0,
                          top: 10.0,
                        ),
                        child: Column(
                          children: <Widget>[
                            //If Com Ocorrência
                            Visibility(
                              visible: ocorrencia,
                              child: Column(
                                children: <Widget>[
                                  SizedBox(height: 30.0),
                                  //Mensagem
                                  Row(
                                    children: <Widget>[
                                      Text('Mensagem:',
                                          style: GoogleFonts.poppins(
                                              color: Colors.black54,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w500,
                                              letterSpacing: 0.7)),
                                    ],
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 5.0),
                                        child: TextField(
                                          maxLines: 5,
                                          controller: _textFieldController,
                                          decoration: InputDecoration(
                                              enabledBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[300]),
                                              ),
                                              focusedBorder:
                                                  UnderlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[300]),
                                              ),
                                              errorText: isMessageValidated
                                                  ? 'Digite uma mensagem!'
                                                  : null),

                                          // controller: _obstextFieldController,
                                          maxLengthEnforced: true,
                                          maxLength: 700,
                                        ),
                                      ),
                                      // SizedBox(height: 20.0),
                                    ],
                                  ),

                                  SizedBox(height: 30.0),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Expanded(
                                        child: Text(
                                            'FO23 - Relatório de ocorrência de trânsito',
                                            textAlign: TextAlign.start,
                                            style: GoogleFonts.poppins(
                                                color: Colors.black87,
                                                fontSize: 19.0,
                                                fontWeight: FontWeight.w700,
                                                letterSpacing: 0.7)),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 20),
                                  //Placa
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          width: double.infinity,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Placa',
                                              labelStyle: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.grey[600]),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[600],
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[300],
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                            ),
                                            // key: _placaKey,
                                            //maxLength: 7,
//                    controller: TextEditingController(text: '${user.nome}'),
//                                             validator:
//                                                 composeValidators('placa', [
//                                               // requiredValidator,
//                                               placaValidator
//                                             ]),
                                            onSaved: (value) =>
                                                _loginData.placa = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  // Linha e Sentido
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: Container(
                                          width: halfMediaWidth,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Linha',
                                              labelStyle: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.grey[600]),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[600],
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[300],
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                            ),
                                            // key: _linhaKey,
                                            validator: composeValidators(
                                                'linha', [
                                              requiredValidator,
                                              stringValidator
                                            ]),
                                            onSaved: (value) =>
                                                _loginData.linha = value,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 8.0,
                                      ),
//                                       Expanded(
//                                         child: Container(
//                                           alignment: Alignment.topCenter,
//                                           width: halfMediaWidth,
//                                           child: TextFormField(
//                                             decoration: InputDecoration(
//                                               labelText: 'Sentido',
//                                               labelStyle: TextStyle(
//                                                   fontSize: 13.0,
//                                                   color: Colors.grey[600]),
//                                               focusedBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                     color: Colors.grey[600],
//                                                     width: 2.0),
//                                                 borderRadius:
//                                                     BorderRadius.circular(5.0),
//                                               ),
//                                               enabledBorder: OutlineInputBorder(
//                                                 borderSide: BorderSide(
//                                                     color: Colors.grey[300],
//                                                     width: 2.0),
//                                                 borderRadius:
//                                                     BorderRadius.circular(5.0),
//                                               ),
//                                             ),
//                                             // key: _sentidoKey,
// //                    controller: TextEditingController(text: '${user.nome}'),
//                                             validator:
//                                                 composeValidators('sentido', [
//                                               // requiredValidator,
//                                               stringValidator
//                                             ]),
//                                             onSaved: (value) =>
//                                                 _loginData.sentido = value,
// //                                        decoration: InputDecoration(hintText: '${user.nome}'),
//                                           ),
//                                         ),
//                                       ),
                                      Material(
                                          color: LightColors.neonMedium,
                                          clipBehavior: Clip.hardEdge,
                                          borderOnForeground: false,
                                          child: Container(
                                            padding:
                                                const EdgeInsets.only(left: 20),
                                            width: halfMediaWidth,
                                            height: 60,
                                            //aqui
                                            decoration: BoxDecoration(
                                              border: new Border(
                                                  left: BorderSide(
                                                      color: Colors.grey[300],
                                                      width: 1.5),
                                                  right: BorderSide(
                                                      color: Colors.grey[300],
                                                      width: 1.5),
                                                  top: BorderSide(
                                                      color: Colors.grey[300],
                                                      width: 1.5),
                                                  bottom: BorderSide(
                                                      color: Colors.grey[300],
                                                      width: 1.5)),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                DropdownButtonHideUnderline(
                                                  child:
                                                      DropdownButtonFormField<
                                                          String>(
                                                    items: ['Ida', 'Volta']
                                                        .map((label) =>
                                                            DropdownMenuItem(
                                                              child:
                                                                  Text(label),
                                                              value: label,
                                                            ))
                                                        .toList(),

                                                    dropdownColor: LightColors
                                                        .neonYellowLight,

                                                    decoration: InputDecoration(
                                                      enabledBorder:
                                                          InputBorder.none,
                                                    ),
                                                    onChanged: (valSentido) {
                                                      setState(() {
                                                        _mySelectionSentido =
                                                            valSentido;
                                                      });
                                                    },
                                                    value: _mySelectionSentido,
                                                    isExpanded: true,
                                                    hint: Text(
                                                      'Selecione o sentido',
                                                      style: TextStyle(
                                                          fontSize: 13.0,
                                                          color:
                                                              Colors.grey[600]),
                                                    ),

                                                    // _dropdownErrorSentido
                                                  ),
                                                ),
                                              ],
                                            ),
                                          )),
                                    ],
                                  ),
                                  //Local do acidente
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextFormField(
                                          //controller: TextEditingController(text: ''),
                                          decoration: InputDecoration(
                                            labelText: 'Local do acidente',
                                            labelStyle: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey[600]),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[600],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          // key: _localAcKey,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                          validator:
                                              composeValidators('local', [
                                            requiredValidator,
                                            // enderecoValidator
                                          ]),
                                          onSaved: (value) =>
                                              _loginData.localAc = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //Altura/Próximo a
                                  SizedBox(
                                    height: 8,
                                  ),

                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextFormField(
                                          //controller: TextEditingController(text: '${user.nome}'),
                                          decoration: InputDecoration(
                                            labelText: 'Altura \/ Próximo a ',
                                            labelStyle: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey[600]),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[600],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          // key: _alturaKey,
//                                                      validator: composeValidators(
//                                                          'altura', [
//                                                        requiredValidator,
//                                                        enderecoValidator
//                                                      ]),
                                          onSaved: (value) =>
                                              _loginData.altura = value,
                                        ),
                                      ),
                                    ],
                                  ),
                                  //Motorista
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextFormField(
                                          //controller: TextEditingController(text: '${user.nome}'),
                                          decoration: InputDecoration(
                                            labelText: 'Motorista',
                                            labelStyle: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey[600]),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[600],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          // key: _motorista1Key,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                          validator: composeValidators(
                                              'motorista', [
                                            requiredValidator,
                                            stringValidator
                                          ]),
                                          onSaved: (value) =>
                                              _loginData.motorista1 = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //Matricula
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Matrícula',
                                            labelStyle: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey[600]),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[600],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          // key: _matricula1Key,
                                          keyboardType: TextInputType.number,
                                          controller: matricula1Controller,
                                          validator: composeValidators(
                                              'matricula', [
                                            requiredValidator,
                                            numberValidator,
                                            minLengthValidator
                                          ]),
                                          onSaved: (value) =>
                                              _loginData.matricula1 = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                      //SizedBox(width: 3.0,),
                                    ],
                                  ),
                                  //Cobrador
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextFormField(
                                          //controller: TextEditingController(text: '${user.nome}'),
                                          decoration: InputDecoration(
                                            labelText: 'Cobrador',
                                            labelStyle: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey[600]),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[600],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          // key: _motorista2Key,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
//                                           validator: composeValidators(
//                                               'motorista', [
//                                             requiredValidator,
//                                             stringValidator
//                                           ]),
                                          onSaved: (value) =>
                                              _loginData.motorista2 = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                  //Matricula
                                  SizedBox(
                                    height: 8,
                                  ),
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Matrícula',
                                            labelStyle: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey[600]),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[600],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          // key: _matricula3Key,
                                          keyboardType: TextInputType.number,
                                          controller: matricula3Controller,
                                          validator: notRequiredValidators(
                                              'matrícula', [
                                            numberValidator,
                                            minLengthValidator
                                          ]),
                                          // composeValidators('matrícula', [
                                          // requiredValidator,
                                          // numberValidator,
                                          // minLengthValidator
                                          // ]),
                                          onSaved: (value) =>
                                              _loginData.matricula2 = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                      //SizedBox(width: 3.0,),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      ButtonDecoration(
        buttonTitle: 'ENVIAR',
        shouldHaveIcon: false,
        // onPressed: () {
        //   // Navigator.push(
        //   //   context,
        //   //   MaterialPageRoute(
        //   //       builder: (context) => SelecaoMultiplaTag(
        //   //             user: user,
        //   //             token: token,
        //   //             sol: sol,
        //   //           )),
        //   // );
        //   _validateForm();
        //   //aqui
        //   if (ocorrencia == false && _formSOKey.currentState.validate()) {
        //     final relatorioSucesso = new SnackBar(
        //         content: new Text('Relatório enviado com sucesso!'));
        //     _scaffoldKey.currentState.showSnackBar(relatorioSucesso);
        //     Future.delayed(const Duration(seconds: 3), () {
        //       setState(() {
        //         Navigator.push(
        //           context,
        //           MaterialPageRoute(
        //               builder: (context) => DashboardScreen(
        //                     user: user,
        //                     token: token,
        //                     sol: sol,
        //                   )),
        //         );
        //       });
        //     });
        //   } else if (_formSOKey.currentState.validate() &&
        //       _formKey.currentState.validate() &&
        //       ocorrencia == true) {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(
        //           builder: (context) => SelecaoMultiplaTag(
        //                 user: user,
        //                 token: token,
        //                 sol: sol,
        //               )),
        //     );
        //   } else {
        //     final semCadastro = new SnackBar(
        //         content:
        //             new Text('Preencha todos os campos para prosseguir!'));
        //     _scaffoldKey.currentState.showSnackBar(semCadastro);
        //   }
        // }

        onPressed: () {
          _validateForm();
          validateTextField(_textFieldController.text);
          if (_formKey.currentState.validate() //&&
              // _mySelection != null &&
              // _mySelectionSentido != null
              ) {
            if (ocorrencia == false) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
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
                    builder: (context) =>
                        DashboardScreen(sol: sol, user: user, token: token),
                  ),
                );
                //});
              });
            } else {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SelecaoMultiplaTag(
                          user: user,
                          token: token,
                          sol: sol,
                        )),
              );
            }
          } else {
            final semCadastro = new SnackBar(
                content: new Text('Preencha todos os campos para prosseguir!'));
            _scaffoldKey.currentState.showSnackBar(semCadastro);
          }
        },
      ),
    ]);
  }
}

String getPrettyJSONString(jsonObject) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String jsonString = encoder.convert(json.decode(jsonObject));
  return jsonString;
}
