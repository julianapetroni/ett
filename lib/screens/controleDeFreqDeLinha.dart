import 'package:ett_app/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/screens/status.dart';
import 'package:ett_app/domains/Usuario.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:json_table/json_table.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

import '../style/lightColors.dart';
import 'myBackButton.dart';
import '../style/topContainer.dart';

class ControleDeFrequenciaDeLinha extends StatefulWidget {
  Usuario user;

  ControleDeFrequenciaDeLinha(
      {Key key,
      // this.value,
      this.user})
      : super(key: key);

  @override
  ControleDeFrequenciaDeLinhaState createState() {
    return ControleDeFrequenciaDeLinhaState(user: user);
  }
}

class ControleDeFrequenciaDeLinhaState
    extends State<ControleDeFrequenciaDeLinha> {
  Usuario user;

  ControleDeFrequenciaDeLinhaState({this.user});

  final GlobalKey<FormFieldState<String>> _nomeKey =
      GlobalKey<FormFieldState<String>>();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = false;

  final _nomeController = TextEditingController();

  @override
  dispose() {
    _nomeController.dispose();

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

  @override
  initState() {
    super.initState();
    fetchData();
  }

  bool toggle = true;

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

  void _addRow() {
    // Built in Flutter Method.
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below.
      _rowList.add(DataRow(cells: <DataCell>[
        DataCell(
          TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
//            focusedBorder: OutlineInputBorder(
//            borderSide: BorderSide(color: Colors.blue, width: 2.0),
//            borderRadius: BorderRadius.circular(25.7),
//          ),
//            enabledBorder: OutlineInputBorder(
//              borderSide: BorderSide(color: Colors.transparent, width: 2.0),
//              borderRadius: BorderRadius.circular(25.7),
//            ),
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
      ]));
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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: LightColors.kDarkYellow,
          elevation: 0.0,
        ),
//      AppBar(
//        iconTheme: new IconThemeData(color: Colors.grey[600]),
//        title: Center(
//            child: Text(
//              ' ',
//              style: TextStyle(color: Colors.grey[400]),
//            )),
//        backgroundColor: Colors.yellow[800],
//        actions: <Widget>[
//          Padding(
//              padding: const EdgeInsets.only(right: 10.0),
//              child: Row(
//                children: <Widget>[],
//              ))
//        ],
//      ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              TopContainer(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0),
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
                            'Controle de Frequência de Linha',
                            style: TextStyle(
                                fontSize: 19.0, fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Container(
                      child: Container(
                        child: Padding(
                          padding:
                              const EdgeInsets.only(bottom: 10.0, top: 10.0),
                          child: Column(
                            children: <Widget>[
                              Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 20.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: TextFormField(
                                          //controller: TextEditingController(text: '${user.nome}'),
                                          decoration: InputDecoration(
                                            labelText: 'Nome do Fiscal',
                                            labelStyle: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey[600]),
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
                                          key: _nomeKey,
                                          controller: TextEditingController(
                                              text: '${user.nome}'),
                                          validator: composeValidators('nome',
                                              [requiredValidator, stringValidator]),
                                          onSaved: (value) => _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        width: halfMediaWidth,
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
//                    key: _nomeKey,
//                    controller: TextEditingController(text: '${user.nome}'),
//                    validator: composeValidators('nome',
//                        [requiredValidator, stringValidator]),
                                          //                   onSaved: (value) => _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                    ),
                                    //SizedBox(width: 3.0,),
                                    Flexible(
                                      child: Padding(
                                        padding: const EdgeInsets.only(
                                            left: 8.0, right: 8.0),
                                        child: Container(
                                          alignment: Alignment.topCenter,
                                          width: halfMediaWidth,
                                          child: TextFormField(
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, top: 8.0),
                                child: Row(
                                  children: <Widget>[
                                    Flexible(
                                      child: Container(
                                        alignment: Alignment.topCenter,
                                        width: halfMediaWidth,
                                        child: TextFormField(
                                          controller: TextEditingController(
                                              text: formattedTime),
                                          decoration: InputDecoration(
                                            labelText: 'Hora Início',
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
                                            controller: TextEditingController(
                                                text: formattedTime),
                                            decoration: InputDecoration(
                                              labelText: 'Hora Término',
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
                            ],
                          ),
                        ),
                      ),
//                      Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          //MyTextField(label: 'Title'),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            crossAxisAlignment: CrossAxisAlignment.end,
//                            children: <Widget>[
////                              Expanded(
////                                child: MyTextField(
////                                  label: 'Date',
////                                  icon: downwardIcon,
////                                ),
////                              ),
//                              //HomePage.calendarIcon(),
//                            ],
//                          )
//                        ],
//                      )
                    )
                  ],
                ),
              ),

              SizedBox(
                height: 20.0,
              ),

//            ListView(
//                scrollDirection: Axis.horizontal,
//                children: <Widget>[
//
//                  Padding(
//                    padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 100.0),
//                    child: Container(
//                      child: Center(
//                        child: DataTable(columns: [
//                          DataColumn(label: Text('Local', style: TextStyle(fontSize: 13.0, color: Colors.orange[600]),)),
//                          DataColumn(label: Text('Carro', style: TextStyle(fontSize: 13.0, color: Colors.orange[600]))),
//                          DataColumn(label: Text('Horário', style: TextStyle(fontSize: 13.0, color: Colors.orange[600]))),
//
//                          //DataColumn(label: Text('Ready')),
//                        ],
//                            rows: _rowList
//                        ),
//                      ),
//                    ),
//                  ),
//
//                ],
//              ),

              Padding(
                padding:
                    const EdgeInsets.only(top: 0.0, left: 20.0, right: 20.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                      child: DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                        label: Text('LOCAL',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                color: Colors.grey[700])),
                      ),
                      DataColumn(
                        label: Text('CARRO',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                color: Colors.grey[700])),
                      ),
                      DataColumn(
                        label: Text('HORÁRIO',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                color: Colors.grey[700])),
                      ),
                      DataColumn(
                        label: Text('EMPRESA',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                color: Colors.grey[700])),
                      ),
                      DataColumn(
                        label: Text('DESTINO',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 13.0,
                                color: Colors.grey[700])),
                      ),
                    ],
                    rows: _rowList,
//                    <DataRow>[
//                      DataRow(cells: [
//                        DataCell(Text('1 Boston')),
//                        DataCell(Text('3')),
//                        DataCell(Text('3')),
//                        DataCell(Text('7')),
//                        DataCell(Text('1')),
//
//                      ]),
//                      DataRow(cells: [
//                        DataCell(Text('2 London')),
//                        DataCell(Text('3')),
//                        DataCell(Text('4')),
//                        DataCell(Text('12')),
//                        DataCell(Text('44')),
//
//                      ]),
//                      DataRow(cells: [
//                        DataCell(Text('3 Rome')),
//                        DataCell(Text('10')),
//                        DataCell(Text('50')),
//                        DataCell(Text('90')),
//                        DataCell(Text('4')),
//
//                      ]),
//                    ]
                  )),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _addRow,
          label: Icon(Icons.add),
          backgroundColor: Colors.orange,
        ));
  }
}

String getPrettyJSONString(jsonObject) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String jsonString = encoder.convert(json.decode(jsonObject));
  return jsonString;
}
