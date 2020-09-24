import 'dart:convert';
import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/screens/dasboardScreen.dart';
import 'package:ett_app/services/token.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/widgets/alertDialogForm.dart';
import 'package:ett_app/widgets/appBarNeon.dart';
import 'package:ett_app/widgets/backgroundDecoration.dart';
import 'package:ett_app/widgets/buttonDecoration.dart';
import 'package:ett_app/widgets/calendarioDataEHoraDecoracao.dart';
import 'package:ett_app/widgets/dropDownForm.dart';
import 'package:ett_app/widgets/hintTextForm.dart';
import 'package:ett_app/widgets/inputForm.dart';
import 'package:ett_app/widgets/logoETTForm.dart';
import 'package:ett_app/widgets/mensagemErroDropDown.dart';
import 'package:ett_app/widgets/subtitleForm.dart';
import 'package:ett_app/widgets/textRow.dart';
import 'package:ett_app/widgets/whiteFormDecoration.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;

class ComunicadoInterno extends StatefulWidget {
  Solicitacao sol;
  Usuario user;
  Token token;

  ComunicadoInterno({Key key, this.sol, this.user, this.token})
      : super(key: key);

  @override
  ComunicadoInternoState createState() {
    return ComunicadoInternoState(sol: sol, user: user, token: token);
  }
}

class ComunicadoInternoState extends State<ComunicadoInterno> {
  Solicitacao sol;
  Usuario user;
  Token token;

  ComunicadoInternoState({this.sol, this.user, this.token});

  final String url = "http://webmyls.com/php/getdata.php";

  List data = List(); //edited line

  Future<String> getSWData() async {
    var res = await http
        .get(Uri.encodeFull(url), headers: {"Accept": "application/json"});
    var resBody = json.decode(res.body);

    setState(() {
      data = resBody;
    });

    print(resBody);

    return "Sucesso";
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //form
  final _formKey = GlobalKey<FormState>();

  //Erro linha
  String _dropdownError;
  //String _selectedItem;

  //Erro sentido
  String _dropdownErrorSentido;
  //String _selectedItemSentido;

  _validateForm() {
    bool _isValid = _formKey.currentState.validate();

    if (_mySelection == null) {
      setState(() => _dropdownError = "Selecione uma opção");
      _isValid = false;
    }

    if (_mySelectionSentido == null) {
      setState(() => _dropdownErrorSentido = "Selecione uma opção");
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

  var semDataAc;
  DateTime _dateTime = DateTime.now().toLocal();
  bool horaEscolhida = false;
  bool fraseHoraEscolhida = true;
  bool linhaVisivelAc = false;

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = false;

  //Form
  //mask
  var dataController = new MaskedTextController(mask: '00/00/0000');
  var horaController = new MaskedTextController(mask: '00:00:00');

  String _mySelection;
  String _mySelectionSentido;

  final _dataKey = GlobalKey<FormFieldState<String>>();
  final _horaKey = GlobalKey<FormFieldState<String>>();
  final _veiculoKey = GlobalKey<FormFieldState<String>>();
  final _chapaKey = GlobalKey<FormFieldState<String>>();
  final _nomeKey = GlobalKey<FormFieldState<String>>();
  final _localKey = GlobalKey<FormFieldState<String>>();

  final _veiculoController = TextEditingController();
  final _nomeController = TextEditingController();
  final _localController = TextEditingController();

  var chapaController = new MaskedTextController(mask: '000000');

  TextEditingController _textFieldController = TextEditingController();

  var heightLogoETT = 80.0;

  @override
  initState() {
    getSWData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBarNeon(),
      body: BackgroundDecoration(
        SafeArea(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              LogoETTForm(heightLogoETT),
              SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 70.0),
                    width: double.infinity,
                    child: Form(
                      key: _formKey,
                      autovalidate: _autovalidate,
                      child: WhiteFormDecoration(
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            SizedBox(
                              height: 30.0,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                TextRow('Comunicado Interno', Colors.black87),
                                SizedBox(
                                  height: 40.0,
                                ),
                                SubtitleForm('Data: '),

                                Column(
                                  children: [
                                    FlatButton(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Flexible(
                                            child: Visibility(
                                              visible: fraseHoraEscolhida,
                                              child: Text(
                                                'Selecione a data',
                                                style: GoogleFonts.roboto(
                                                    color: Colors.grey[700],
                                                    fontSize: 13.0),
                                              ),
                                            ),
                                          ),
                                          Flexible(
                                            child: Visibility(
                                                visible: horaEscolhida,
                                                child: Container(
                                                  padding: EdgeInsets.only(left: 10.0),
                                                  child: Text(
                                                    '${_dateTime.day}/${_dateTime.month}/${_dateTime.year}',
                                                    style: GoogleFonts.roboto(
                                                        color: Colors.grey[800],
                                                        fontSize: 13.0),
                                                  ),
                                                )),
                                          ),
                                        ],
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          fraseHoraEscolhida = false;
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
                                                      child:
                                                          CupertinoDatePicker(
                                                        mode:
                                                            CupertinoDatePickerMode
                                                                .date,
                                                        initialDateTime:
                                                            _dateTime,
                                                        use24hFormat: true,
                                                        onDateTimeChanged:
                                                            (dateTime) {
                                                          setState(() {
                                                            _dateTime =
                                                                dateTime;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                    Container(
                                                      margin:
                                                          const EdgeInsets.only(
                                                              left: 20,
                                                              right: 20),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5.0),
                                                        gradient:
                                                            LinearGradient(
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
                                                        child: TextRow(
                                                            "CONFIRMAR DATA",
                                                            Colors.white),
                                                        onPressed: () {
                                                          setState(() {
                                                            fraseHoraEscolhida =
                                                                false;
                                                            horaEscolhida =
                                                                true;
                                                            linhaVisivelAc =
                                                                false;
                                                            semDataAc = null;
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            });
                                      },
                                    ),
                                    Container(
                                      margin:
                                          EdgeInsets.only(left: 20, right: 20),
                                      child: Divider(
                                        color: Colors.grey[400],
                                        height: 0,
                                        thickness: 1.1,
                                      ),
                                    ),
                                  ],
                                ),

                                Container(
                                  margin: EdgeInsets.only(left: 20, right: 20),
                                  child: MensagemErroDropDown(
                                      linhaVisivelAc, "Selecione a data!"),
                                ),

//                                InputForm(
//                                  _dataKey,
//                                  dataController,
//                                  composeValidators('a data',
//                                      [requiredValidator, dataValidator]),
//                                  (value) => _loginData.foraDeServico = value,
//                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                SubtitleForm('Hora: '),
                                InputForm(
                                  _horaKey,
                                  horaController,
                                  composeValidators('a hora',
                                      [requiredValidator, horaLegthValidator]),
                                  (value) => _loginData.hora = value,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                SubtitleForm(
                                    'Chapa do funcionário associado: '),
                                InputForm(
                                  _chapaKey,
                                  chapaController,
                                  composeValidators('a chapa', [
                                    minLegthValidator,
                                    maxLegthNumero6Validator
                                  ]),
                                  (value) => _loginData.chapa = value,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                SubtitleForm('Nome: '),
                                InputForm(
                                  _nomeKey,
                                  _nomeController,
                                  composeValidators('o nome',
                                      [nomeLegthValidator, stringValidator]),
                                  (value) => _loginData.veiculo = value,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                SubtitleForm('Veículo: '),
                                InputForm(
                                  _veiculoKey,
                                  _veiculoController,
                                  composeValidators(
                                      'o veículo', [minLegthValidator]),
                                  (value) => _loginData.veiculo = value,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                SubtitleForm('Local da ocorrência: '),
                                InputForm(
                                  _localKey,
                                  _localController,
                                  composeValidators('o local da ocorrência',
                                      [minLegthValidator]),
                                  (value) => _loginData.local = value,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                                SubtitleForm('Linha: '),
                                SizedBox(
                                  height: 20.0,
                                ),
                                DropDownForm(
                                    data.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['item_name']),
                                        value: item['id'].toString(),
                                      );
                                    }).toList(), (newVal) {
                                  setState(() {
                                    _mySelection = newVal;
                                    _dropdownError = null;
                                  });
                                }, _mySelection, true, 'Selecione a linha',
                                    _dropdownError),
                                SizedBox(
                                  height: 20.0,
                                ),
                                SubtitleForm('Sentido: '),
                                SizedBox(
                                  height: 20.0,
                                ),
                                DropDownForm(
                                    data.map((item) {
                                      return new DropdownMenuItem(
                                        child: new Text(item['item_name']),
                                        value: item['id'].toString(),
                                      );
                                    }).toList(), (valSentido) {
                                  setState(() {
                                    _mySelectionSentido = valSentido;
                                    _dropdownErrorSentido = null;
                                  });
                                },
                                    _mySelectionSentido,
                                    true,
                                    'Selecione o sentido',
                                    _dropdownErrorSentido),
                                SizedBox(
                                  height: 20.0,
                                ),
                                SubtitleForm('Mensagem: '),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 25.0),
                                      child: TextField(
                                        maxLines: 5,
                                        controller: _textFieldController,
                                        maxLength: 700,
                                        maxLengthEnforced: true,
                                        inputFormatters: [
                                          LengthLimitingTextInputFormatter(700),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 40.0),
                            FlatButton(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: FlatButton(
                                  onPressed: () {
                                    _validateForm();
                                    if (_formKey.currentState.validate() &&
                                        _mySelection != null &&
                                        _mySelectionSentido != null) {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          // return object of type Dialog
                                          return AlertDialogForm(
                                              'Formulário registrado com sucesso!');
                                        },
                                      );
                                      Future.delayed(
                                          const Duration(milliseconds: 3000),
                                          () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                DashboardScreen(
                                                    sol: sol,
                                                    user: user,
                                                    token: token),
                                          ),
                                        );
                                        //});
                                      });
                                    } else {
                                      final semCadastro = new SnackBar(
                                          content: new Text(
                                              'Preencha todos os campos para prosseguir!'));
                                      _scaffoldKey.currentState
                                          .showSnackBar(semCadastro);
                                    }
                                  },
                                  textColor: Colors.white,
                                  color: Colors.white,
                                  child: ButtonDecoration('ENVIAR'),
                                ),
                              ),
                            ),
                            SizedBox(height: 10.0),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Users {
  int id;
  String name;

  Users({
    this.id,
    this.name,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      id: json['id'],
      name: json['name'],
    );
  }
}
