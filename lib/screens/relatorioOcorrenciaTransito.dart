import 'dart:async';
import 'dart:convert';
import 'package:ett_app/screens/selecaoMultiplaComTag.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/screens/login.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/screens/status.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import '../style/lightColors.dart';
import '../style/topContainer.dart';
import "package:flutter/painting.dart";
import "package:flutter/foundation.dart";
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:signature/signature.dart';

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
  final GlobalKey<FormFieldState<String>> _nomeKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _prefixoKey =
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
  final GlobalKey<FormFieldState<String>> _matricula1Key =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _motorista2Key =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _matricula2Key =
      GlobalKey<FormFieldState<String>>();


//Form
  final _prefixoController = TextEditingController();
  final _placaController = TextEditingController();
  final _linhaController = TextEditingController();
  final _sentidoController = TextEditingController();
  final _localAcController = TextEditingController();
  final _alturaController = TextEditingController();
  final _motorista1Controller = TextEditingController();
  final _matricula1Controller = TextEditingController();
  final _motorista2Controller = TextEditingController();
  final _matricula2Controller = TextEditingController();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = false;



  //Mask
  var telController = new MaskedTextController(mask: '(00)00000-0000');
  var dataController = new MaskedTextController(mask: '00/00/0000');
  var dataVencimentoController = new MaskedTextController(mask: '00/00/0000');
  var cpfController = new MaskedTextController(mask: '00.000.000-0');
  var idadeController = new MaskedTextController(mask: '00');

  bool complete = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  dispose() {
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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.5;
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
                    color: Colors.black,
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
          canvasColor: LightColors.kLightYellow,
          scaffoldBackgroundColor: LightColors.kLightYellow2,
          hintColor: Colors.grey[600],
          hoverColor: Colors.amber,
          splashColor: LightColors.kDarkYellow,
          dividerColor: LightColors.kLightYellow2,
        ),
        home: Scaffold(
          key: _scaffoldKey,
            appBar: AppBar(
              backgroundColor: LightColors.kDarkYellow,
              elevation: 0.0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Status(
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
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: ListView(children: <Widget>[
                TopContainer(
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0),
                  width: width,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Relatório de Ocorrência de Trânsito',
                              style: TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Form(
                        key: _formKey,
                        autovalidate: _autovalidate,
                        child: Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10.0, top: 10.0),
                            child: Column(
                              children: <Widget>[
                                //Data e Hora
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Container(
                                          //alignment: Alignment.topCenter,
                                          width: halfMediaWidth,
                                          child: TextFormField(
//                                            controller: dataController,
                                            controller: TextEditingController(
                                                text: formattedDate),
                                            decoration: InputDecoration(
                                              labelText: 'Data',
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
//                    key: _nomeKey,
//                    controller: TextEditingController(text: '${user.nome}'),
                    validator: composeValidators('data',
                        [requiredValidator, dataValidator]),
                                            //                   onSaved: (value) => _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                          ),
                                        ),
                                      ),
                                      //SizedBox(width: 5.0,),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Container(
                                            alignment: Alignment.topCenter,
                                            width: halfMediaWidth,
                                            child: TextFormField(
                                              controller: TextEditingController(
                                                  text: formattedTime),
                                              decoration: InputDecoration(
                                                labelText: 'Hora',
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
//                    key: _nomeKey,
//                    controller: TextEditingController(text: '${user.nome}'),
//                    validator: composeValidators('nome',
//                        [requiredValidator, stringValidator]),
                                              //                   onSaved: (value) => _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Prefixo e Placa
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Container(
                                          //alignment: Alignment.topCenter,
                                          width: halfMediaWidth,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Prefixo',
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
                                            key: _prefixoKey,
                                            //controller: TextEditingController(text: '${user.nome}'),
                                            validator: composeValidators(
                                                'prefixo', [
                                              requiredValidator,
                                              stringValidator
                                            ]),
                                            onSaved: (value) =>
                                                _loginData.prefixo = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                          ),
                                        ),
                                      ),
                                      //SizedBox(width: 5.0,),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Container(
                                            alignment: Alignment.topCenter,
                                            width: halfMediaWidth,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: 'Placa',
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
                                              key: _placaKey,
                                              //maxLength: 7,
//                    controller: TextEditingController(text: '${user.nome}'),
                                              validator: composeValidators(
                                                  'placa', [
                                                requiredValidator,
                                                placaValidator
                                              ]),
                                              onSaved: (value) =>
                                                  _loginData.placa = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Linha e Sentido
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Container(
                                          //alignment: Alignment.topCenter,
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
                                            key: _linhaKey,
//                    controller: TextEditingController(text: '${user.linha}'),
                                            validator: composeValidators(
                                                'linha', [
                                              requiredValidator,
                                              stringValidator
                                            ]),
                                            onSaved: (value) =>
                                                _loginData.linha = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                          ),
                                        ),
                                      ),
                                      //SizedBox(width: 5.0,),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Container(
                                            alignment: Alignment.topCenter,
                                            width: halfMediaWidth,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: 'Sentido',
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
                                              key: _sentidoKey,
//                    controller: TextEditingController(text: '${user.nome}'),
                                              validator: composeValidators(
                                                  'sentido', [
                                                requiredValidator,
                                                stringValidator
                                              ]),
                                              onSaved: (value) =>
                                                  _loginData.sentido = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Local do acidente
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 20.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
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
                                          key: _localAcKey,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                          validator: composeValidators(
                                              'local', [
                                            requiredValidator,
                                            enderecoValidator
                                          ]),
                                          onSaved: (value) =>
                                              _loginData.localAc = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Altura/Próximo a
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 20.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
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
                                          key: _alturaKey,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                          validator: composeValidators(
                                              'altura', [
                                            requiredValidator,
                                            enderecoValidator
                                          ]),
                                          onSaved: (value) =>
                                              _loginData.altura = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Motorista
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 20.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
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
                                          key: _motorista1Key,
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
                                ),
                                //Matricula
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 20.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        // alignment: Alignment.topCenter,
                                        //width: width,
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
                                          key: _matricula1Key,
//                    controller: TextEditingController(text: '${user.nome}'),
                                          validator: composeValidators(
                                              'matricula', [
                                            requiredValidator,
                                            numberValidator
                                          ]),
                                          onSaved: (value) =>
                                              _loginData.matricula1 = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                      //SizedBox(width: 3.0,),
                                    ],
                                  ),
                                ),
                                //Cobrador
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 20.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
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
                                          key: _motorista2Key,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                          validator: composeValidators(
                                              'motorista', [
                                            requiredValidator,
                                            stringValidator
                                          ]),
                                          onSaved: (value) =>
                                              _loginData.motorista2 = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Matricula
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 20.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        // alignment: Alignment.topCenter,
                                        //width: width,
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
                                          key: _matricula2Key,
//                    controller: TextEditingController(text: '${user.nome}'),
                                          validator: composeValidators(
                                              'matrícula', [
                                            requiredValidator,
                                            numberValidator
                                          ]),
                                          onSaved: (value) =>
                                              _loginData.matricula2 = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                      //SizedBox(width: 3.0,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
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

                      if (_formKey.currentState.validate()) {
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
                      else {
                        final semCadastro =
                        new SnackBar(content: new Text('Preencha todos os campos para prosseguir!'));
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
              ]),
            )));
  }
}

String getPrettyJSONString(jsonObject) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String jsonString = encoder.convert(json.decode(jsonObject));
  return jsonString;
}
