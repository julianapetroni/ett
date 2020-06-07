import 'package:ett_app/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/domains/Usuario.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:ett_app/style/lightColors.dart';
import 'package:ett_app/style/topContainer.dart';

class Stepper extends StatefulWidget {
  Usuario user;

  Stepper({
    Key key,
    // this.value,

    this.user,
  }) : super(key: key);

  @override
  StepperState createState() {
    return StepperState(user: user);
  }
}

class StepperState
    extends State<Stepper> {
  Usuario user;

  StepperState({this.user});

  final GlobalKey<FormFieldState<String>> _motoristaKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _cobradorKey =
      GlobalKey<FormFieldState<String>>();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = false;

  final _motoristaController = TextEditingController();
  final _cobradorController = TextEditingController();

  @override
  dispose() {
    _motoristaController.dispose();
    _cobradorController.dispose();

    super.dispose();
  }

  List _data;

  //stepper
//  int currentStep = 0;
//  bool complete = false;
//
//  next() {
//    currentStep + 1 != steps.length
//        ? goTo(currentStep + 1)
//        : setState(() => complete = true);
//  }
//
//  cancel() {
//    if (currentStep > 0) {
//      goTo(currentStep - 1);
//    }
//  }
//
//  goTo(int step) {
//    setState(() {
//      currentStep = step;
//    });
//  }
//
//  List<Step> steps = [
//    Step(
//      title: const Text('Tipo de Ocorrência'),
//      isActive: true,
//      state: StepState.indexed,
//      content: Column(
//        children: <Widget>[
////          TextFormField(
////            decoration: InputDecoration(labelText: 'Email Address'),
////          ),
////          TextFormField(
////            decoration: InputDecoration(labelText: 'Password'),
////          ),
//        ],
//      ),
//    ),
//    Step(
//      isActive: true,
//      state: StepState.indexed,
//      title: const Text('Condições da Via'),
//      content: Column(
//        children: <Widget>[
//          TextFormField(
//            decoration: InputDecoration(labelText: 'Home Address'),
//          ),
//          TextFormField(
//            decoration: InputDecoration(labelText: 'Postcode'),
//          ),
//        ],
//      ),
//    ),
//    Step(
//      state: StepState.indexed,
//      isActive: true,
//      title: const Text('Semáforo'),
//      //subtitle: const Text("Error!"),
//      content: Column(
//        children: <Widget>[
//          CircleAvatar(
//            backgroundColor: Colors.green,
//          )
//        ],
//      ),
//    ),
//    Step(
//      state: StepState.indexed,
//      title: const Text('Placas'),
//      isActive: true,
//      //subtitle: const Text("Error!"),
//      content: Column(
//        children: <Widget>[
//          CircleAvatar(
//            backgroundColor: Colors.yellow,
//          )
//        ],
//      ),
//    ),
//    Step(
//      state: StepState.indexed,
//      title: const Text('Tempo'),
//      isActive: true,
//      //subtitle: const Text("Error!"),
//      content: Column(
//        children: <Widget>[
//          CircleAvatar(
//            backgroundColor: Colors.yellow,
//          )
//        ],
//      ),
//    ),
//    Step(
//      state: StepState.indexed,
//      title: const Text('Ambiente'),
//      isActive: true,
//      //subtitle: const Text("Error!"),
//      content: Column(
//        children: <Widget>[
//          CircleAvatar(
//            backgroundColor: Colors.yellow,
//          )
//        ],
//      ),
//    ),
//    Step(
//      state: StepState.indexed,
//      title: const Text('Descrição do Acidente'),
//      isActive: true,
//      //subtitle: const Text("Error!"),
//      content: Column(
//        children: <Widget>[
//          TextField(),
//        ],
//      ),
//    ),
//    Step(
//      state: StepState.indexed,
//      title: const Text('Croqui do Acidente'),
//      isActive: true,
//      content: Column(
//        children: <Widget>[
//          TextField(),
//        ],
//      ),
//    ),
 // ];

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

  @override
  initState() {
    super.initState();
    fetchData();
  }

  bool toggle = true;

  //checkbox
  bool _isChecked = false;

  void onChanged(bool value) {
    setState(() {
      _isChecked = value;
    });
  }


  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.5;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM').format(now);
    String formattedTime = DateFormat('kk:mm:ss').format(now);

    SizeConfig().init(context);
    return MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: Scaffold(
          appBar: AppBar(
            backgroundColor: LightColors.kDarkYellow,
            elevation: 0.0,
          ),
          backgroundColor: Colors.white,
          body: SafeArea(
            child: Stack(
              children: <Widget>[
                ListView(
                  children: <Widget>[
                    TopContainer(
                      padding: EdgeInsets.only(
                          left: 20.0, right: 20.0, bottom: 40.0),
                      width: width,
                      child: Column(
                        children: <Widget>[
                          //MyBackButton(),
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
                                      fontSize: 19.0,
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 20),
                          Container(
                            child: Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    bottom: 10.0, top: 10.0),
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
                                                controller:
                                                    TextEditingController(
                                                        text: formattedDate),
                                                decoration: InputDecoration(
                                                  labelText: 'Data',
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
                                          //SizedBox(width: 5.0,),
                                          Flexible(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0, right: 8.0),
                                              child: Container(
                                                alignment: Alignment.topCenter,
                                                width: halfMediaWidth,
                                                child: TextFormField(
                                                  controller:
                                                      TextEditingController(
                                                          text: formattedTime),
                                                  decoration: InputDecoration(
                                                    labelText: 'Hora',
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
                                              // key: _motoristaKey,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                              validator: composeValidators(
                                                  'endereço', [
                                                requiredValidator,
                                                stringValidator
                                              ]),
                                              //onSaved: (value) => _loginData.nome = value,
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
                                                labelText:
                                                    'Altura \/ Próximo a ',
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
                                              // key: _motoristaKey,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                              validator: composeValidators(
                                                  'nome', [
                                                requiredValidator,
                                                stringValidator
                                              ]),
                                              //onSaved: (value) => _loginData.nome = value,
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
                                              key: _motoristaKey,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                              validator: composeValidators(
                                                  'nome', [
                                                requiredValidator,
                                                stringValidator
                                              ]),
                                              onSaved: (value) =>
                                                  _loginData.nome = value,
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
                                              key: _cobradorKey,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                              validator: composeValidators(
                                                  'nome', [
                                                requiredValidator,
                                                stringValidator
                                              ]),
                                              onSaved: (value) =>
                                                  _loginData.nome = value,
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

//                    Container(
//                      child: complete
//                          ? Center(
//                              child: AlertDialog(
//                                title: new Text("Atenção"),
//                                content: new Text(
//                                  "Ocorrência registrada com sucesso!",
//                                ),
//                                actions: <Widget>[
//                                  new FlatButton(
//                                    child: new Text("Fechar"),
//                                    onPressed: () {
//                                      setState(() => complete = false);
//                                    },
//                                  ),
//                                ],
//                              ),
//                            )
//                          : Stepper(
//                              steps: steps,
//                              currentStep: currentStep,
//                              onStepContinue: next,
//                              onStepTapped: (step) => goTo(step),
//                              onStepCancel: cancel,
//                            ),
//                    ),

                  SizedBox(height: 30.0,),
                  ],
                ),
              ],
            ),
          ),
          ),
    );
  }
}

String getPrettyJSONString(jsonObject) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String jsonString = encoder.convert(json.decode(jsonObject));
  return jsonString;
}