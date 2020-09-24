import 'dart:async';
import 'dart:convert';
import 'package:ett_app/screens/selecaoMultiplaComTag.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/services/token.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../style/lightColors.dart';
import '../style/topContainer.dart';
import "package:flutter/painting.dart";
import "package:flutter/foundation.dart";
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'dasboardScreen.dart';
import 'package:flutter/widgets.dart';

class ResumoRelatorioOcorrenciaTransito extends StatefulWidget {
  Solicitacao sol;
  Usuario user;
  Token token;

  ResumoRelatorioOcorrenciaTransito({Key key, this.sol, this.user, this.token})
      : super(key: key);

  @override
  ResumoRelatorioOcorrenciaTransitoState createState() {
    return ResumoRelatorioOcorrenciaTransitoState(sol: sol, user: user, token: token);
  }
}

class ResumoRelatorioOcorrenciaTransitoState
    extends State<ResumoRelatorioOcorrenciaTransito> {
  Solicitacao sol;
  Usuario user;
  Token token;

  ResumoRelatorioOcorrenciaTransitoState({this.sol, this.user, this.token});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //Form
  final GlobalKey<FormFieldState<String>> _monitorKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _nomeKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _prefixoKey =
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
  final _nomeController = TextEditingController();
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
  var cpfController = new MaskedTextController(mask: '00.000.000-0');
  var idadeController = new MaskedTextController(mask: '00');

  bool complete = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> _formSOKey = GlobalKey<FormState>();

  @override
  dispose() {
    _nomeController.dispose();
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

  List _data;

  Future<void> fetchData() async {
    try {
      final response =
      await http.get("https://jsonplaceholder.typicode.com/todos");
      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          _data = jsonDecode(response.body) as List;
        });
      } else {
        print("Erro: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  bool toggle = true;

  bool monitoramento = true;
  bool ocorrencia = false;
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem;
  // Group Value for Radio Button.
  int id = 1;

  bool linhaVisivel = false;
  bool linhaVisivelAc = false;

  DateTime selectedDate = DateTime.now().toLocal();
  DateTime selectedDateAc = DateTime.now().toLocal();

  bool dataSelecionada = false;
  //bool dataSelecionadaAc = false;
  bool fraseSelecao = true;
  //bool fraseSelecaoAc = true;

  DateTime picked;
  DateTime pickedAc;
  var semData;
  var semDataAc;
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
    double width = MediaQuery.of(context).size.width;
    final halfMediaWidth = MediaQuery.of(context).size.width*0.5;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('dd/MM/yyyy').format(now);
    String formattedTime = DateFormat('kk:mm:ss').format(now);

    @override
    void initState() {
      super.initState();
      fetchData();
    }

    SizeConfig().init(context);
    return MaterialApp(
      theme: ThemeData(
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
          //Letra dentro das tags
          body2: const TextStyle(
            fontSize: 14,
          ),
        ),
        primaryColor: LightColors.kDarkYellow,
        primarySwatch: Colors.orange,
        accentColor: Colors.amber,
        accentColorBrightness: Brightness.dark,
        fontFamily: 'Roboto',
        canvasColor: Colors.white,
        scaffoldBackgroundColor: LightColors.kLightYellow2,
        hintColor: Colors.grey[600],
        hoverColor: Colors.amber,
        splashColor: LightColors.kDarkYellow,
        dividerColor: LightColors.kLightYellow2,
      ),
      home: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
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
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: ListView(children: <Widget>[
              TopContainer(
                padding: EdgeInsets.only(bottom: 40.0),
                width: width,
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 80.0,
                      width: double.infinity,
                      child: Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Image(
                              image: AssetImage('images/logo-slim.png'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Flexible(
                          child: Text(
                            'Resumo da Ocorrência',
                            style: GoogleFonts.raleway(
                                color: Colors.black87,
                                fontSize: 19.0,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 1,
                                wordSpacing: 3),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Padding(
                      padding: const EdgeInsets.only(left: 20, right: 20),
                      child: Form(
                        key: _formSOKey,
                        autovalidate: true,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //Monitor
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Monitor',
                                      labelStyle: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.grey[600]),
                                      focusedBorder:
                                      OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[600],
                                            width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(
                                            5.0),
                                      ),
                                      enabledBorder:
                                      OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[300],
                                            width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(
                                            5.0),
                                      ),
                                    ),
                                    key: _monitorKey,
                                    validator: composeValidators(
                                        'monitor', [
                                      requiredValidator,
                                      stringValidator
                                    ]),
                                    onSaved: (value) =>
                                    _loginData.monitor = value,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            //Matricula
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: 'Matrícula',
                                      labelStyle: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.grey[600]),
                                      focusedBorder:
                                      OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[600],
                                            width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(
                                            5.0),
                                      ),
                                      enabledBorder:
                                      OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[300],
                                            width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(
                                            5.0),
                                      ),
                                    ),
                                    key: _matriculaKey,
                                    controller: matriculaController,
                                    validator: composeValidators(
                                        'matricula', [
                                      requiredValidator,
                                      numberValidator,
                                      minLegthValidator
                                    ]),
                                    onSaved: (value) =>
                                    _loginData.matricula = value,
                                  ),
                                ),
                                //SizedBox(width: 3.0,),
                              ],
                            ),
                            SizedBox(height: 8,),
                            //Nome
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: TextFormField(
                                    controller: TextEditingController(
                                        text: '${user.nome}'),
                                    decoration: InputDecoration(
                                      labelText: 'Nome',
                                      labelStyle: TextStyle(
                                          fontSize: 13.0,
                                          color: Colors.grey[600]),
                                      focusedBorder:
                                      OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[600],
                                            width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(
                                            5.0),
                                      ),
                                      enabledBorder:
                                      OutlineInputBorder(
                                        borderSide: BorderSide(
                                            color: Colors.grey[300],
                                            width: 2.0),
                                        borderRadius:
                                        BorderRadius.circular(
                                            5.0),
                                      ),
                                    ),
                                    key: _nomeKey,
                                    validator: composeValidators(
                                        'nome', [
                                      requiredValidator,
                                      stringValidator
                                    ]),
                                    onSaved: (value) =>
                                    _loginData.nome = value,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 8,),
                            Theme(
                              data: Theme.of(context).copyWith(
                                materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                                colorScheme: ColorScheme.light(
                                  primary: Colors.black87,
                                  //Color(0xFFFF7F1019),
                                ),
                                primaryColorBrightness:
                                Brightness.light,
//                                          primaryColor: LightColors.neonETT, //color of the main banner
//                                          accentColor: LightColors.neonETT, //color of circle indicating the selected date
                                buttonTheme: ButtonThemeData(
                                    textTheme: ButtonTextTheme
                                        .accent //color of the text in the button "OK/CANCEL"
                                ),
                              ),
                              child: Builder(builder: (context) {
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
                                      setState(() {
                                        dataSelecionada = true;
                                        fraseSelecao = false;
                                        linhaVisivel = false;
                                        semData = ' ';
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        Visibility(
                                            visible: fraseSelecao,
                                            child: Text(
                                              'Selecione o dia da Semana',
                                              style: GoogleFonts.roboto(
                                                  color: Colors.grey[700],
                                                  fontSize: 14.0),
                                            )),
                                        Visibility(
                                          visible: dataSelecionada,
                                          child: Text(
                                            "${DateFormat('EEEE, dd/MM/yyyy', "pt").format(selectedDate).toString()}"
                                            //"${selectedDate.toLocal()}"
                                            //.split(' ')[0]
                                            ,
                                            style: GoogleFonts.roboto(
                                              color: Colors.black87,
                                              fontSize: 16.0,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8),
                              child: Visibility(
                                visible: linhaVisivel,
                                child: Column(
                                  children: [
                                    Divider(
                                      color: Colors.red[800],
                                      height: 0,
                                      thickness: 1.1,
                                    ),
                                    SizedBox(height: 8,),
                                    Row(
                                      children: [
                                        Text(
                                          "Selecione uma data!",
                                          style: GoogleFonts.raleway(
                                            color: Colors.red[800],
                                            fontSize: 12.0,
                                            //fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(3.0),
                              decoration: semDataAc != null
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
                              child:  FlatButton(
                                child: Row(
                                  children: [
                                    Visibility(
                                      visible: fraseHoraEscolhida,
                                      child: Text(
                                        'Selecione o dia e hora',
                                        style: GoogleFonts.roboto(
                                            color: Colors.grey[700],
                                            fontSize: 14.0),
                                      ),

                                    ),
                                    Visibility(
                                      visible: horaEscolhida,
                                      child: Text('${_dateTime.day}/${_dateTime.month}/${_dateTime.year} - ${_dateTime.hour}:${_dateTime.minute} horas', style: TextStyle(color: Colors.black87),),

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
//                                                          MediaQuery.of(context)
//                                                                  .copyWith()
//                                                                  .size
//                                                                  .height /
//                                                              3,
                                                child: CupertinoDatePicker(
                                                  //mode: CupertinoDatePickerMode.dateAndTime,
                                                  initialDateTime:
                                                  _dateTime,
                                                  use24hFormat: true,
                                                  onDateTimeChanged:
                                                      (dateTime) {
                                                    setState(() {
                                                      _dateTime = dateTime;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(left: 20, right: 20),
                                                child: Container(
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
                                                      "CONFIRMAR HORÁRIO", style: TextStyle(color: Colors.white, letterSpacing: 2, fontSize: 16),),
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
                                              ),
                                            ],
                                          ),
                                        );
//
                                      });
                                },
                              ),

                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 8),
                              child: Visibility(
                                visible: linhaVisivelAc,
                                child: Column(
                                  children: [
                                    Divider(
                                      color: Colors.red[800],
                                      height: 0,
                                      thickness: 1.1,
                                    ),
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(top: 8),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Selecione a data e o horário!",
                                            style: GoogleFonts.raleway(
                                              color: Colors.red[800],
                                              fontSize: 12.0,
                                              //fontWeight: FontWeight.w700,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height:8),
                            Row(
                              children: <Widget>[
                                Flexible(
                                  child: Container(
                                    width: halfMediaWidth,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Prefixo',
                                        labelStyle: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.grey[600]),
                                        focusedBorder:
                                        OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[600],
                                              width: 2.0),
                                          borderRadius:
                                          BorderRadius.circular(
                                              5.0),
                                        ),
                                        enabledBorder:
                                        OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Colors.grey[300],
                                              width: 2.0),
                                          borderRadius:
                                          BorderRadius.circular(
                                              5.0),
                                        ),
                                      ),

                                      key: _prefixoMonitKey,
                                      controller: prefixoController,
                                      validator: composeValidators(
                                          'prefixo', [
                                        requiredValidator,
                                        numberValidator,
                                        minLegthValidator
                                      ]),
                                      onSaved: (value) => _loginData
                                          .prefixoMonit = value,
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.0,),
                                Flexible(
                                  child: Container(
                                    alignment: Alignment.topCenter,
                                    width: halfMediaWidth,
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        labelText: 'Matrícula',
                                        labelStyle: TextStyle(
                                            fontSize: 13.0,
                                            color:
                                            Colors.grey[600]),
                                        focusedBorder:
                                        OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                              Colors.grey[600],
                                              width: 2.0),
                                          borderRadius:
                                          BorderRadius.circular(
                                              5.0),
                                        ),
                                        enabledBorder:
                                        OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color:
                                              Colors.grey[300],
                                              width: 2.0),
                                          borderRadius:
                                          BorderRadius.circular(
                                              5.0),
                                        ),
                                      ),
                                      key: _matricula3Key,
                                      //maxLength: 7,
                                      controller:
                                      matricula3Controller,
                                      validator: composeValidators(
                                          'placa', [
                                        requiredValidator,
                                        placaValidator,
                                        minLegthValidator
                                      ]),
                                      onSaved: (value) =>
                                      _loginData.placa = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            //Ocorrencia
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 10, right: 20),
                              child: Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceEvenly,
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
                                  Flexible(
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
                                              color: Colors.grey[800],
                                              fontSize: 14.0)),
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
                                  Flexible(
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
                                              color: Colors.grey[800],
                                              fontSize: 14.0)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Form(
                      key: _formKey,
                      autovalidate: true,
                      child: Container(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 10.0, top: 10.0, left: 20, right: 20),
                          child: Column(
                            children: <Widget>[
                              //If Com Ocorrência
                              Visibility(
                                visible: ocorrencia,
                                child: Column(
                                  children: <Widget>[
                                    //Placa
                                    Row(
                                      children: [
                                        Flexible(
                                          child: Container(
                                            alignment:
                                            Alignment.topCenter,
                                            width: double.infinity,
                                            child: TextFormField(
                                              decoration:
                                              InputDecoration(
                                                labelText: 'Placa',
                                                labelStyle: TextStyle(
                                                    fontSize: 13.0,
                                                    color: Colors
                                                        .grey[600]),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .grey[600],
                                                      width: 2.0),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      5.0),
                                                ),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .grey[300],
                                                      width: 2.0),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      5.0),
                                                ),
                                              ),
                                              key: _placaKey,
                                              //maxLength: 7,
//                    controller: TextEditingController(text: '${user.nome}'),
                                              validator:
                                              composeValidators(
                                                  'placa', [
                                                requiredValidator,
                                                placaValidator
                                              ]),
                                              onSaved: (value) =>
                                              _loginData.placa =
                                                  value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    // Linha e Sentido
                                    SizedBox(height: 8,),
                                    Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: Container(
                                            width: halfMediaWidth,
                                            child: TextFormField(
                                              decoration:
                                              InputDecoration(
                                                labelText: 'Linha',
                                                labelStyle: TextStyle(
                                                    fontSize: 13.0,
                                                    color: Colors
                                                        .grey[600]),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .grey[
                                                      600],
                                                      width: 2.0),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      5.0),
                                                ),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .grey[
                                                      300],
                                                      width: 2.0),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      5.0),
                                                ),
                                              ),
                                              key: _linhaKey,
                                              validator:
                                              composeValidators(
                                                  'linha', [
                                                requiredValidator,
                                                stringValidator
                                              ]),
                                              onSaved: (value) =>
                                              _loginData.linha =
                                                  value,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 8.0,),
                                        Flexible(
                                          child:  Container(
                                            alignment: Alignment
                                                .topCenter,
                                            width: halfMediaWidth,
                                            child: TextFormField(
                                              decoration:
                                              InputDecoration(
                                                labelText:
                                                'Sentido',
                                                labelStyle: TextStyle(
                                                    fontSize:
                                                    13.0,
                                                    color: Colors
                                                        .grey[
                                                    600]),
                                                focusedBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .grey[
                                                      600],
                                                      width: 2.0),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      5.0),
                                                ),
                                                enabledBorder:
                                                OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors
                                                          .grey[
                                                      300],
                                                      width: 2.0),
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
                                                      5.0),
                                                ),
                                              ),
                                              key: _sentidoKey,
//                    controller: TextEditingController(text: '${user.nome}'),
                                              validator:
                                              composeValidators(
                                                  'sentido', [
                                                requiredValidator,
                                                stringValidator
                                              ]),
                                              onSaved: (value) =>
                                              _loginData
                                                  .sentido =
                                                  value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Local do acidente
                                    SizedBox(height: 8,),
                                    Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: TextFormField(
                                            //controller: TextEditingController(text: ''),
                                            decoration:
                                            InputDecoration(
                                              labelText:
                                              'Local do acidente',
                                              labelStyle: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors
                                                      .grey[600]),
                                              focusedBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .grey[600],
                                                    width: 2.0),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    5.0),
                                              ),
                                              enabledBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .grey[300],
                                                    width: 2.0),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    5.0),
                                              ),
                                            ),
                                            key: _localAcKey,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                            validator:
                                            composeValidators(
                                                'local', [
                                              requiredValidator,
                                              enderecoValidator
                                            ]),
                                            onSaved: (value) =>
                                            _loginData.localAc =
                                                value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Altura/Próximo a
                                    SizedBox(height: 8,),
                                    Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: TextFormField(
                                            //controller: TextEditingController(text: '${user.nome}'),
                                            decoration:
                                            InputDecoration(
                                              labelText:
                                              'Altura \/ Próximo a ',
                                              labelStyle: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors
                                                      .grey[600]),
                                              focusedBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .grey[600],
                                                    width: 2.0),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    5.0),
                                              ),
                                              enabledBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .grey[300],
                                                    width: 2.0),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    5.0),
                                              ),
                                            ),
                                            key: _alturaKey,
//                                                      validator: composeValidators(
//                                                          'altura', [
//                                                        requiredValidator,
//                                                        enderecoValidator
//                                                      ]),
                                            onSaved: (value) =>
                                            _loginData.altura =
                                                value,
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Motorista
                                    SizedBox(height: 8,),
                                    Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: TextFormField(
                                            //controller: TextEditingController(text: '${user.nome}'),
                                            decoration:
                                            InputDecoration(
                                              labelText:
                                              'Motorista',
                                              labelStyle: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors
                                                      .grey[600]),
                                              focusedBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .grey[600],
                                                    width: 2.0),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    5.0),
                                              ),
                                              enabledBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .grey[300],
                                                    width: 2.0),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    5.0),
                                              ),
                                            ),
                                            key: _motorista1Key,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                            validator:
                                            composeValidators(
                                                'motorista', [
                                              requiredValidator,
                                              stringValidator
                                            ]),
                                            onSaved: (value) =>
                                            _loginData
                                                .motorista1 =
                                                value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Matricula
                                    SizedBox(height: 8,),
                                    Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: TextFormField(
                                            decoration:
                                            InputDecoration(
                                              labelText:
                                              'Matrícula',
                                              labelStyle: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors
                                                      .grey[600]),
                                              focusedBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .grey[600],
                                                    width: 2.0),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    5.0),
                                              ),
                                              enabledBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .grey[300],
                                                    width: 2.0),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    5.0),
                                              ),
                                            ),
                                            key: _matricula1Key,
                                            controller:
                                            matricula1Controller,
                                            validator:
                                            composeValidators(
                                                'matricula', [
                                              requiredValidator,
                                              numberValidator,
                                              minLegthValidator
                                            ]),
                                            onSaved: (value) =>
                                            _loginData
                                                .matricula1 =
                                                value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                          ),
                                        ),
                                        //SizedBox(width: 3.0,),
                                      ],
                                    ),
                                    //Cobrador
                                    SizedBox(height: 8,),
                                    Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: TextFormField(
                                            //controller: TextEditingController(text: '${user.nome}'),
                                            decoration:
                                            InputDecoration(
                                              labelText: 'Cobrador',
                                              labelStyle: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors
                                                      .grey[600]),
                                              focusedBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .grey[600],
                                                    width: 2.0),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    5.0),
                                              ),
                                              enabledBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .grey[300],
                                                    width: 2.0),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    5.0),
                                              ),
                                            ),
                                            key: _motorista2Key,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                            validator:
                                            composeValidators(
                                                'motorista', [
                                              requiredValidator,
                                              stringValidator
                                            ]),
                                            onSaved: (value) =>
                                            _loginData
                                                .motorista2 =
                                                value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                          ),
                                        ),
                                      ],
                                    ),
                                    //Matricula
                                    SizedBox(height: 8,),
                                    Row(
                                      children: <Widget>[
                                        Flexible(
                                          child: TextFormField(
                                            decoration:
                                            InputDecoration(
                                              labelText:
                                              'Matrícula',
                                              labelStyle: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors
                                                      .grey[600]),
                                              focusedBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .grey[600],
                                                    width: 2.0),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    5.0),
                                              ),
                                              enabledBorder:
                                              OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors
                                                        .grey[300],
                                                    width: 2.0),
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    5.0),
                                              ),
                                            ),
                                            key: _matricula2Key,
                                            controller:
                                            matricula2Controller,
                                            validator:
                                            composeValidators(
                                                'matrícula', [
                                              requiredValidator,
                                              numberValidator,
                                              minLegthValidator
                                            ]),
                                            onSaved: (value) =>
                                            _loginData
                                                .matricula2 =
                                                value,
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
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 40, bottom: 40),
                child: FlatButton(
                  onPressed: () {
                    _validateForm();
                    if (ocorrencia == false &&
                        _formSOKey.currentState.validate()) {
                      final relatorioSucesso = new SnackBar(
                          content:
                          new Text('Relatório enviado com sucesso!'));
                      _scaffoldKey.currentState
                          .showSnackBar(relatorioSucesso);
                      Future.delayed(const Duration(seconds: 3), () {
                        setState(() {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => DashboardScreen(
                                  user: user,
                                  token: token,
                                  sol: sol,
                                )),
                          );
                        });
                      });
                    } else if (_formSOKey.currentState.validate() &&
                        _formKey.currentState.validate() &&
                        ocorrencia == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SelecaoMultiplaTag(
                              user: user,
                              token: token,
                              sol: sol,
                            )),
                      );
                    } else {
                      final semCadastro = new SnackBar(
                          content: new Text(
                              'Preencha todos os campos para prosseguir!'));
                      _scaffoldKey.currentState.showSnackBar(semCadastro);
                    }
                  },
                  textColor: Colors.white,
                  color: Colors.white,
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
                        child: const Text('ENVIAR',
                            style: TextStyle(fontSize: 20))),
                  ),
                ),
              ),
            ]),
          )),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        DefaultCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('pt'),
      ],
    );
  }
}

String getPrettyJSONString(jsonObject) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String jsonString = encoder.convert(json.decode(jsonObject));
  return jsonString;
}
