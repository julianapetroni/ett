import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/services/token.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/widgets/dialog/alert_dialog_form.dart';
import 'package:ett_app/widgets/formUI/button/button_decoration.dart';
import 'package:ett_app/widgets/formUI/input/input_form_square.dart';
import 'package:ett_app/widgets/formUI/text_pattern/text_row.dart';
import 'package:ett_app/widgets/formUI/text_pattern/title_form_bold.dart';
import 'package:ett_app/widgets/logo_config/logo_ett_form.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/size_config.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import '../../../style/light_colors.dart';
import '../../dashboard/ui/dasboard.page.dart';
import '../../../style/top_container.dart';

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
    SizeConfig().init(context);

    return Scaffold(
        appBar: _buildAppBar(context),
        backgroundColor: Colors.white,
        body: _buildBody(context),
        floatingActionButton: _buildButton(context));
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: LightColors.neonYellowLight,
      elevation: 0.0,
      iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
    );
  }

  Widget _buildBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 1.22;
    final halfMediaWidth = MediaQuery.of(context).size.width;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d/MM/yyyy').format(now);
    String formattedTime = DateFormat('kk:mm:ss').format(now);
    var heightLogoETT = 80.0;

    return ListView(
      children: <Widget>[
        TopContainer(
          padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0),
          width: width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LogoETTForm(heightLogoETT),
              SizedBox(height: 30.0),
              TextRow('Controle de Frequência de Linha', Colors.black87),
              SizedBox(height: 20),
              Container(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: [
                        Flexible(
                          child: InputFormSquare(
                            labelTextForm: 'Nome do Fiscal',
                            keyForm: _nomeKey,
                            controller:
                                TextEditingController(text: '${user.nome}'),
                            validatorForm: composeValidators(
                                'nome', [requiredValidator, stringValidator]),
                            onSavedForm: (value) => _loginData.nome = value,
                            larguraInputForm: width,
                            paddingTop: 10.0,
                            obscureText: false,
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
                          child: InputFormSquare(
                            larguraInputForm: double.infinity,
                            labelTextForm: 'Matrícula',
                            keyForm: _matriculaKey,
//                            controller: TextEditingController(
//                                text: '${_loginData.matricula}'),
                            controller: matriculaController,
                            validatorForm: composeValidators('matricula',
                                [requiredValidator, minLengthValidator]),
                            onSavedForm: (value) =>
                                _loginData.matricula = value,
                            paddingTop: 0.0,
                            obscureText: false,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: InputFormSquare(
                            larguraInputForm: double.infinity,
                            labelTextForm: 'Data',
                            keyForm: _dataKey,
                            controller:
                                TextEditingController(text: formattedDate),
                            validatorForm: composeValidators(
                                'data', [requiredValidator, dataValidator]),
                            onSavedForm: (value) => _loginData.data = value,
                            paddingTop: 8.0,
                            obscureText: false,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: InputFormSquare(
                            larguraInputForm: halfMediaWidth,
                            labelTextForm: 'Hora Início',
                            keyForm: _horaKey,
                            controller:
                                TextEditingController(text: formattedTime),
                            validatorForm: composeValidators('hora', [
                              requiredValidator,
                              horaLengthValidator,
                              horaValidator
                            ]),
                            onSavedForm: (value) => _loginData.hora = value,
                            obscureText: false,
                            paddingTop: 8.0,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Flexible(
                          child: InputFormSquare(
                            larguraInputForm: halfMediaWidth,
                            labelTextForm: 'Hora Término',
                            keyForm: _horaTerminoKey,
                            controller:
                                TextEditingController(text: formattedTime),
                            validatorForm: composeValidators(
                                'hora do término', [
                              requiredValidator,
                              horaLengthValidator,
                              horaValidator
                            ]),
                            onSavedForm: (value) => _loginData.hora = value,
                            obscureText: false,
                            paddingTop: 8.0,
                          ),
                        ),
                      ],
                    )
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
        Container(
            padding: EdgeInsets.only(bottom: 100, left: 5, right: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                RawMaterialButton(
                  onPressed: _addRow,
                  elevation: 2.0,
                  fillColor: Colors.grey[200],
                  child: Icon(
                    Icons.add,
                    size: 35.0,
                  ),
                  padding: EdgeInsets.all(15.0),
                  shape: CircleBorder(),
                ),
              ],
            )

            // FlatButton(
            //   onPressed: _addRow,
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     children: [
            //       Icon(
            //         Icons.add,
            //         color: LightColors.neonETT,
            //       ),
            //       SizedBox(
            //         width: 20,
            //       ),
            //       Text(
            //         'Adicionar linha',
            //         style: TextStyle(
            //           color: LightColors.neonETT,
            //         ),
            //       )
            //     ],
            //   ),
            //   color: Colors.black87,
            // )
            ),
      ],
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: ButtonDecoration(
          buttonTitle: 'ENVIAR',
          shouldHaveIcon: false,
          onPressed: () {
            setState(() {});
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
                  builder: (context) =>
                      DashboardScreen(sol: sol, user: user, token: token),
                ),
              );
            });
          }),
    );
  }
}

String getPrettyJSONString(jsonObject) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String jsonString = encoder.convert(json.decode(jsonObject));
  return jsonString;
}
