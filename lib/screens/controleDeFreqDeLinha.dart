import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/services/token.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/widgets/buttonDecoration.dart';
import 'package:ett_app/widgets/inputFormWithDecoration.dart';
import 'package:ett_app/widgets/logoETTForm.dart';
import 'package:ett_app/widgets/textRow.dart';
import 'package:ett_app/widgets/titleFormBold.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../style/lightColors.dart';
import 'dasboardScreen.dart';
import '../style/topContainer.dart';

class ControleDeFrequenciaDeLinha extends StatefulWidget {
  Usuario user;
  Token token;
  Solicitacao sol;

  ControleDeFrequenciaDeLinha(
      {Key key,
      // this.value,
      this.user,
      this.token,
      this.sol})
      : super(key: key);

  @override
  ControleDeFrequenciaDeLinhaState createState() {
    return ControleDeFrequenciaDeLinhaState(user: user, token: token, sol: sol);
  }
}

class ControleDeFrequenciaDeLinhaState
    extends State<ControleDeFrequenciaDeLinha> {
  Usuario user;
  Token token;
  Solicitacao sol;

  ControleDeFrequenciaDeLinhaState({this.user, this.token, this.sol});

  final GlobalKey<FormFieldState<String>> _nomeKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _matriculaKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _horaKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _horaTerminoKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _dataKey =
      GlobalKey<FormFieldState<String>>();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = false;

  final _nomeController = TextEditingController();

  var matriculaController = new MaskedTextController(mask: '000000');

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
    double width = MediaQuery.of(context).size.width / 1.22;
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.5;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM').format(now);
    String formattedTime = DateFormat('kk:mm:ss').format(now);

    SizeConfig().init(context);
    var heightLogoETT = 80.0;

    return Scaffold(
        appBar: AppBar(
          backgroundColor: LightColors.neonYellowLight,
          elevation: 0.0,
          iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: ListView(
            children: <Widget>[
              TopContainer(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0),
                width: width,
                child: Column(
                  children: <Widget>[
                    LogoETTForm(heightLogoETT),
                    SizedBox(height: 30.0),
                    TextRow('Controle de Frequência de Linha', Colors.black87),
                    SizedBox(height: 20),
                    Container(
                      padding: const EdgeInsets.only(
                          left: 8.0, bottom: 10.0, top: 10.0),
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: [
                              Flexible(
                                child: InputFormWithDecoration(
                                  width,
                                  'Nome do Fiscal',
                                  _nomeKey,
                                  TextEditingController(text: '${user.nome}'),
                                  composeValidators('nome',
                                      [requiredValidator, stringValidator]),
                                  (value) => _loginData.nome = value,
                                  true,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: InputFormWithDecoration(
                                  halfMediaWidth,
                                  'Matrícula',
                                  _matriculaKey,
//                            TextEditingController(
//                                text: '${_loginData.matricula}'),
                                  matriculaController,
                                  composeValidators('matricula',
                                      [requiredValidator, minLegthValidator]),
                                  (value) => _loginData.matricula = value,
                                  true,
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Flexible(
                                child: InputFormWithDecoration(
                                  halfMediaWidth,
                                  'Data',
                                  _dataKey,
                                  TextEditingController(text: formattedDate),
                                  composeValidators('data',
                                      [requiredValidator, dataValidator]),
                                  (value) => _loginData.data = value,
                                  true,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Row(
                            children: [
                              Flexible(
                                child: InputFormWithDecoration(
                                  halfMediaWidth,
                                  'Hora Início',
                                  _horaKey,
                                  TextEditingController(text: formattedTime),
                                  composeValidators('hora', [
                                    requiredValidator,
                                    horaLegthValidator,
                                    horaValidator
                                  ]),
                                  (value) => _loginData.hora = value,
                                  true,
                                ),
                              ),
                              SizedBox(
                                width: 8.0,
                              ),
                              Flexible(
                                child: InputFormWithDecoration(
                                  halfMediaWidth,
                                  'Hora Término',
                                  _horaTerminoKey,
                                  TextEditingController(text: formattedTime),
                                  composeValidators('hora do término', [
                                    requiredValidator,
                                    horaLegthValidator,
                                    horaValidator
                                  ]),
                                  (value) => _loginData.hora = value,
                                  true,
                                ),
                              ),
                            ],
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Container(
                    padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                    child: DataTable(
                      columns: <DataColumn>[
                        DataColumn(
                          label: TitleFormBold('LOCAL'),
                        ),
                        DataColumn(
                          label: TitleFormBold('CARRO'),
                        ),
                        DataColumn(
                          label: TitleFormBold('HORÁRIO'),
                        ),
                        DataColumn(
                          label: TitleFormBold('EMPRESA'),
                        ),
                        DataColumn(
                          label: TitleFormBold('DESTINO'),
                        ),
                      ],
                      rows: _rowList,
                    )),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 40, bottom: 40),
                child: FlatButton(
                  onPressed: () {
                    setState(() {
                      // _myActivitiesResult = _myActivities.toString();
                    });
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
                  textColor: Colors.white,
                  color: Colors.white,
                  child: ButtonDecoration('ENVIAR'),
                ),
              ),
            ],
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: _addRow,
          label: Icon(
            Icons.add,
            color: LightColors.neonETT,
          ),
          backgroundColor: Colors.black87,
        ));
  }
}

String getPrettyJSONString(jsonObject) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String jsonString = encoder.convert(json.decode(jsonObject));
  return jsonString;
}
