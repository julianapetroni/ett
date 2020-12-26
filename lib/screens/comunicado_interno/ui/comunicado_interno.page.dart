import 'dart:convert';
import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/screens/dashboard/ui/dasboard.page.dart';
import 'package:ett_app/services/token.dart';
import 'package:ett_app/style/light_colors.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/widgets/dialog/alert_dialog_form.dart';
import 'package:ett_app/widgets/app_bar/app_bar_neon.dart';
import 'package:ett_app/widgets/logo_config/logo_ett_form.dart';
import 'package:ett_app/widgets/neon_gradient_decoration/background_decoration.dart';
import 'package:ett_app/widgets/calendario/calendario_data_hora_sem_decoracao.dart';
import 'package:ett_app/widgets/formUI/button/button_decoration.dart';
import 'package:ett_app/widgets/formUI/dropdown/drop_down_form.dart';
import 'package:ett_app/widgets/formUI/text_pattern/subtitle_form.dart';
import 'package:ett_app/widgets/formUI/text_pattern/text_row.dart';
import 'package:ett_app/widgets/formUI/white_form/white_form_decoration.dart';
import 'package:ett_app/widgets/formUI/text_pattern/hint_text_form.dart';
import 'package:ett_app/widgets/formUI/input/input_form.dart';
import 'package:ett_app/widgets/formUI/dropdown/mensagem_erro_dropdown.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/size_config.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
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

  //Erro sentido
  String _dropdownErrorSentido;

  //Erro grupo
  String _dropdownErrorGrupo;

  bool _linhaVisivelSentido = false;
  bool _linhaVisivel = false;
  bool _linhaVisivelGrupo = false;
  bool userNameValidate = false;
  bool isUserNameValidate = false;

  bool validateTextField(String userInput) {
    if (userInput.isEmpty) {
      setState(() {
        isUserNameValidate = true;
      });
      return false;
    }
    setState(() {
      isUserNameValidate = false;
    });
    return true;
  }

  _validateForm() {
    bool _isValid = _formKey.currentState.validate();

    if (_mySelection == null) {
      setState(() => _dropdownError = "Selecione uma opção");
      _isValid = false;
    }

    if (_mySelectionSentido == null) {
      setState(() {
        _dropdownErrorSentido = "Selecione uma opção";
        _linhaVisivelSentido = true;
      });
      _isValid = false;
    }

    if (_mySelectionGrupo == null) {
      setState(() {
        _dropdownErrorGrupo = "Selecione uma opção";
        _linhaVisivelGrupo = true;
      });
      _isValid = false;
    }

    if (_mySelection == null) {
      setState(() {
        _dropdownError = "Selecione uma opção";
        _linhaVisivel = true;
      });
      _isValid = false;
    }

    if (horaEscolhida == false) {
      setState(() {
        linhaVisivelAc = true;
        semDataAc = ' ';
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
  String _mySelectionGrupo;
  String _mySelectionSentido;

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
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return BackgroundDecoration(
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
                                height: 20.0,
                              ),
                              SubtitleForm('Grupo: '),
                              Material(
                                  color: Colors.white,
                                  clipBehavior: Clip.hardEdge,
                                  borderOnForeground: false,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                      left: 20,
                                    ),
                                    child: DropdownButtonFormField<String>(
                                      items: [
                                        'Grupo 1',
                                        'Grupo 2',
                                        'Grupo 3',
                                      ]
                                          .map((label) => DropdownMenuItem(
                                                child: Text(label),
                                                value: label,
                                              ))
                                          .toList(),
                                      dropdownColor:
                                          LightColors.neonYellowLight,
                                      onChanged: (newVal) {
                                        setState(() {
                                          _mySelectionGrupo = newVal;
                                          _dropdownErrorGrupo = null;
                                          _linhaVisivelGrupo = false;
                                        });
                                      },
                                      value: _mySelectionGrupo,
                                      isExpanded: true,
                                      hint: Text('Selecione o grupo'),
                                    ),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: MensagemErroDropDown(
                                    _linhaVisivelGrupo, "Selecione o grupo!"),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              SubtitleForm('Data e Hora: '),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: CalendarioDataEHoraSemDecoracao(
                                  semDataAc,
                                  FlatButton(
                                    child: HintTextForm(fraseHoraEscolhida,
                                        'Selecione ', horaEscolhida, _dateTime),
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
                                                      mode:
                                                          CupertinoDatePickerMode
                                                              .dateAndTime,
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
                                                  Container(
                                                    margin:
                                                        const EdgeInsets.only(
                                                            left: 20,
                                                            right: 20),
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5.0),
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
                                                      child: TextRow(
                                                          "CONFIRMAR HORÁRIO",
                                                          Colors.white),
                                                      onPressed: () {
                                                        setState(() {
                                                          fraseHoraEscolhida =
                                                              false;
                                                          horaEscolhida = true;
                                                          linhaVisivelAc =
                                                              false;
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
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: MensagemErroDropDown(linhaVisivelAc,
                                    "Selecione a data e o horário!"),
                              ),
                              SizedBox(height: 8),
                              SizedBox(
                                height: 20.0,
                              ),
                              SubtitleForm('Chapa do funcionário associado: '),
                              InputForm(
                                _chapaKey,
                                chapaController,
                                composeValidators('a chapa', [
                                  minLengthValidator,
                                  maxLengthNumero6Validator
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
                                    [nomeLengthValidator, stringValidator]),
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
                                    'o veículo', [minLengthValidator]),
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
                                    [minLengthValidator]),
                                (value) => _loginData.local = value,
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              SubtitleForm('Linha: '),
                              SizedBox(
                                height: 20.0,
                              ),
                              Material(
                                  color: Colors.white,
                                  clipBehavior: Clip.hardEdge,
                                  borderOnForeground: false,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 0),
                                    child: DropdownButtonFormField<String>(
                                      items: [
                                        '101',
                                        '102',
                                        '103',
                                        '104',
                                        '105',
                                        '106',
                                        '107',
                                        '108',
                                        '109',
                                        '110',
                                        '111',
                                        '112',
                                        '113',
                                        '260',
                                        '321',
                                        '407',
                                        '448',
                                        '449',
                                        '450',
                                        '455',
                                        '456',
                                        '497',
                                        '498',
                                        '528',
                                        '542',
                                        '559',
                                      ]
                                          .map((label) => DropdownMenuItem(
                                                child: Text(label),
                                                value: label,
                                              ))
                                          .toList(),
                                      dropdownColor:
                                          LightColors.neonYellowLight,
                                      onChanged: (newVal) {
                                        setState(() {
                                          _mySelection = newVal;
                                          _dropdownError = null;
                                          _linhaVisivel = false;
                                        });
                                      },
                                      value: _mySelection,
                                      isExpanded: true,
                                      hint: Text('Selecione a linha'),
                                    ),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: MensagemErroDropDown(
                                    _linhaVisivel, "Selecione a linha!"),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              SubtitleForm('Sentido: '),
                              SizedBox(
                                height: 20.0,
                              ),
                              Material(
                                  color: Colors.white,
                                  clipBehavior: Clip.hardEdge,
                                  borderOnForeground: false,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        left: 20, right: 0),
                                    child: DropdownButtonFormField<String>(
                                      items: ['Ida', 'Volta']
                                          .map((label) => DropdownMenuItem(
                                                child: Text(label),
                                                value: label,
                                              ))
                                          .toList(),
                                      dropdownColor:
                                          LightColors.neonYellowLight,
                                      onChanged: (valSentido) {
                                        setState(() {
                                          _mySelectionSentido = valSentido;
                                          _dropdownErrorSentido = null;
                                          _linhaVisivelSentido = false;
                                        });
                                      },
                                      value: _mySelectionSentido,
                                      isExpanded: true,
                                      hint: Text('Selecione o sentido'),

                                      // _dropdownErrorSentido
                                    ),
                                  )),
                              Padding(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 20),
                                child: MensagemErroDropDown(
                                    _linhaVisivelSentido,
                                    "Selecione o sentido!"),
                              ),
                              SizedBox(
                                height: 20.0,
                              ),
                              SubtitleForm('Mensagem: '),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 25.0),
                                    child: TextField(
                                      maxLines: 5,
                                      controller: _textFieldController,
                                      maxLength: 250,
                                      maxLengthEnforced: true,
                                      inputFormatters: [
                                        LengthLimitingTextInputFormatter(700),
                                      ],
                                      decoration: InputDecoration(
                                          errorText: isUserNameValidate
                                              ? 'Digite uma mensagem!'
                                              : null),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          SizedBox(height: 40.0),
                          ButtonDecoration(
                            buttonTitle: 'ENVIAR',
                            shouldHaveIcon: false,
                            onPressed: () {
                              _validateForm();
                              validateTextField(_textFieldController.text);
                              if (_formKey.currentState.validate() &&
                                  _mySelection != null &&
                                  _mySelectionSentido != null) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // return object of type Dialog
                                    return AlertDialogForm(
                                      textAlert:
                                          'Formulário registrado com sucesso!',
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    );
                                  },
                                );
                                Future.delayed(
                                    const Duration(milliseconds: 3000), () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DashboardScreen(
                                          sol: sol, user: user, token: token),
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
