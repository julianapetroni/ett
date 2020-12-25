import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/screens/dashboard/ui/dasboard.page.dart';
import 'package:ett_app/style/light_colors.dart';
import 'package:ett_app/widgets/dialog/alert_dialog_form.dart';
import 'package:ett_app/widgets/app_bar/app_bar_neon.dart';
import 'package:ett_app/widgets/formUI/text_pattern/subtitle_form.dart';
import 'package:ett_app/widgets/formUI/text_pattern/text_row.dart';
import 'package:ett_app/widgets/formUI/white_form/white_form_decoration.dart';
import 'package:ett_app/widgets/logo_config/logo_ett_form.dart';
import 'package:ett_app/widgets/neon_gradient_decoration/background_decoration.dart';
import 'package:ett_app/widgets/calendario/calendario.dart';
import 'package:ett_app/widgets/formUI/button/button_decoration.dart';
import 'package:ett_app/widgets/formUI/input/input_form.dart';
import 'package:ett_app/widgets/formUI/dropdown/mensagem_erro_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/size_config.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:ett_app/services/token.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;

import 'enviar_alteracao_escala.strings.dart';

class EnviarAlteracaoEscala extends StatefulWidget {
  Usuario user;
  Token token;
  Solicitacao sol;

  EnviarAlteracaoEscala(
      {Key key,
      // this.value,
      this.user,
      this.token,
      this.sol})
      : super(key: key);

  @override
  EnviarAlteracaoEscalaState createState() {
    return EnviarAlteracaoEscalaState(user: user, token: token, sol: sol);
  }
}

class EnviarAlteracaoEscalaState extends State<EnviarAlteracaoEscala> {
  Usuario user;
  Token token;
  Solicitacao sol;

  EnviarAlteracaoEscalaState({this.user, this.token, this.sol});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _foraDeServicoKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _veiculoKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _outrosMotivosKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _descricaoKey =
      GlobalKey<FormFieldState<String>>();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = false;

  final _foraDeServicoController = TextEditingController();
  final _veiculoController = TextEditingController();
  final _outrosMotivosController = TextEditingController();
  final _descricaoController = TextEditingController();

  //mask
  var dataController = new MaskedTextController(mask: '00/00/0000');

  @override
  initState() {
    super.initState();
    this.getSWData();
  }

  @override
  dispose() {
    _foraDeServicoController.dispose();
    _veiculoController.dispose();
    _outrosMotivosController.dispose();
    _descricaoController.dispose();

    super.dispose();
  }

  //Motivo
  String _dropdownError;
  bool linhaVisivelMotivo = false;

  bool linhaVisivelDtInicioMaiorDtFim = false;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        dataSelecionada = true;
        fraseSelecao = false;
        selectedDate = picked;
        linhaVisivel = false;
        linhaVisivelDtInicioMaiorDtFim = false;
        semData = null;
      });
  }

  bool dataSelecionada = false;
  bool fraseSelecao = true;
  bool linhaVisivel = false;
  var semData;
  DateTime selectedDate = DateTime.now().toLocal();

  Future<Null> _selectDateFim(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDateFim,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDateFim)
      setState(() {
        dataSelecionadaFim = true;
        fraseSelecaoFim = false;
        selectedDateFim = picked;
        linhaVisivelFim = false;
        semDataFim = null;
      });
  }

  bool dataSelecionadaFim = false;
  bool fraseSelecaoFim = true;
  bool linhaVisivelFim = false;
  var semDataFim;
  DateTime selectedDateFim = DateTime.now().toLocal();

  Future<Null> _selectDateOutOfService(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2000, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate)
      setState(() {
        dataSelecionadaOutOfService = true;
        fraseSelecaoOutOfService = false;
        selectedDateOutOfService = picked;
        linhaVisivelOutOfService = false;
        semDataOutOfService = null;
      });
  }

  bool dataSelecionadaOutOfService = false;
  bool fraseSelecaoOutOfService = true;
  bool linhaVisivelOutOfService = false;
  var semDataOutOfService;
  DateTime selectedDateOutOfService = DateTime.now().toLocal();

  _validateForm() {
    bool _isValid = _formKey.currentState.validate();

    // if (_mySelection == null) {
    //   setState(() => _dropdownError = "Selecione uma opção");
    //   _isValid = false;
    // }
    if (_motivo == null) {
      setState(() => linhaVisivelMotivo = true);
      _isValid = false;
    }

    if (selectedDateFim.isBefore(selectedDate)) {
      setState(() {
        linhaVisivelDtInicioMaiorDtFim = true;
      });
      _isValid = false;
    }

    if (dataSelecionada == false) {
      setState(() {
        linhaVisivel = true;
        semData = ' ';
      });
      _isValid = false;
    }

    if (dataSelecionadaFim == false) {
      setState(() {
        linhaVisivelFim = true;
        semDataFim = ' ';
      });
      _isValid = false;
    }

    if (dataSelecionadaOutOfService == false) {
      setState(() {
        linhaVisivelOutOfService = true;
        semDataOutOfService = ' ';
      });
      _isValid = false;
    }

    if (_isValid) {
      //form is valid
    }
  }

  // Initially is obscure
  bool _obscureText = true;

  // Toggles show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  var heightLogoETT = 80.0;

  String _mySelection;
  String _motivo;
  bool _showOutros = false;

  final String url = "http://webmyls.com/php/getdata.php";

  List data; //edited line

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
      ListView(
        shrinkWrap: true,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              LogoETTForm(heightLogoETT),
              Container(
                padding: const EdgeInsets.only(top: 20.0),
                width: double.infinity,
                child: Form(
                  key: _formKey,
                  autovalidate: _autovalidate,
                  child: WhiteFormDecoration(
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          TextRow(EnviarAlteracaoEscalaStrings.title,
                              Colors.black87),
                          SizedBox(
                            height: 40.0,
                          ),
                          SubtitleForm(EnviarAlteracaoEscalaStrings.bus),
                          InputForm(
                            _veiculoKey,
                            _veiculoController,
                            composeValidators('a placa',
                                [requiredValidator, onlyNumberValidator]),
                            (value) => _loginData.veiculo = value,
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SubtitleForm(EnviarAlteracaoEscalaStrings.dataInicio),

                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Calendario(
                                _selectDate,
                                dataSelecionada,
                                fraseSelecao,
                                linhaVisivel,
                                semData,
                                selectedDate),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: MensagemErroDropDown(
                                linhaVisivel, "Selecione uma data!"),
                          ),

                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: MensagemErroDropDown(
                                linhaVisivelDtInicioMaiorDtFim,
                                "A data de início não pode ser posterior à do fim!"),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SubtitleForm(EnviarAlteracaoEscalaStrings.dataFim),

                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Calendario(
                                _selectDateFim,
                                dataSelecionadaFim,
                                fraseSelecaoFim,
                                linhaVisivelFim,
                                semDataFim,
                                selectedDateFim),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: MensagemErroDropDown(
                                linhaVisivelFim, "Selecione uma data!"),
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SubtitleForm(EnviarAlteracaoEscalaStrings.reason),

                          Material(
                              color: Colors.white,
                              clipBehavior: Clip.hardEdge,
                              borderOnForeground: false,
                              child: Container(
                                padding:
                                    const EdgeInsets.only(left: 20, right: 0),
                                child: DropdownButtonFormField<String>(
                                  items: [
                                    '018 - Revisão Preventiva',
                                    '043 - Inspeção e Lubrificação / Duas Pegadas',
                                    'Duas Pegadas',
                                    'Outros'
                                  ]
                                      .map((label) => DropdownMenuItem(
                                            child: Text(label),
                                            value: label,
                                          ))
                                      .toList(),
                                  dropdownColor: LightColors.neonYellowLight,
                                  onChanged: (value) {
                                    setState(() {
                                      linhaVisivelMotivo = false;
                                      _motivo = value;
                                      if (value == 'Outros') {
                                        _showOutros = true;
                                      } else {
                                        _showOutros = false;
                                      }
                                    });
                                  },
                                  onSaved: (value) {
                                    setState(() {
                                      _motivo = value;
                                    });
                                  },
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: MensagemErroDropDown(
                                linhaVisivelMotivo, "Selecione o motivo!"),
                          ),
                          SizedBox(
                            height: 8.0,
                          ),
                          Visibility(
                            visible: _showOutros,
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Column(
                                children: [
                                  SubtitleForm(
                                      EnviarAlteracaoEscalaStrings.otherReason),
                                  InputForm(
                                    _outrosMotivosKey,
                                    _outrosMotivosController,
                                    composeValidators(
                                        'o motivo', [requiredValidator]),
                                    (value) => _loginData.outrosMotivos = value,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          // DropDownForm(
                          //     data.map((item) {
                          //       return new DropdownMenuItem(
                          //         child: new Text(item['item_name']),
                          //         value: item['id'].toString(),
                          //       );
                          //     }).toList(), (newVal) {
                          //   setState(() {
                          //     _mySelection = newVal;
                          //     _dropdownError = null;
                          //   });
                          // },
                          //     _mySelection,
                          //     true,
                          //     EnviarAlteracaoEscalaStrings.selectReason,
                          //     _dropdownError),
                          SizedBox(
                            height: 20.0,
                          ),
                          SubtitleForm(
                              EnviarAlteracaoEscalaStrings.outOfService),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: Calendario(
                                _selectDateOutOfService,
                                dataSelecionadaOutOfService,
                                fraseSelecaoOutOfService,
                                linhaVisivelOutOfService,
                                semDataOutOfService,
                                selectedDateOutOfService),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 20, right: 20),
                            child: MensagemErroDropDown(
                                linhaVisivelOutOfService,
                                "Selecione uma data!"),
                          ),

                          // InputForm(
                          //   _foraDeServicoKey,
                          //   dataController,
                          //   composeValidators(
                          //       'a data', [requiredValidator, dataValidator]),
                          //   (value) => _loginData.foraDeServico = value,
                          // ),
                          SizedBox(
                            height: 20.0,
                          ),
                          SubtitleForm(
                              EnviarAlteracaoEscalaStrings.description),
                          InputForm(
                            _descricaoKey,
                            _descricaoController,
                            composeValidators('a descrição',
                                [requiredValidator, minLengthValidator]),
                            (value) => _loginData.descricao = value,
                            maxLength: 200,
                          ),
                          SizedBox(height: 30.0),
                          ButtonDecoration(
                            buttonTitle:
                                EnviarAlteracaoEscalaStrings.buttonTitle,
                            shouldHaveIcon: false,
                            onPressed: () {
                              _validateForm();
                              if (_formKey.currentState.validate()) {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    // return object of type Dialog
                                    return AlertDialogForm(
                                      textAlert:
                                          EnviarAlteracaoEscalaStrings.succes,
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
                                          sol: sol, user: user, token: token
                                          //textSucesso: textSucesso,
                                          //alertSucessoVisible: alertSucessoVisible,

                                          ),
                                    ),
                                  );
                                });
                              } else {
                                final semCadastro = new SnackBar(
                                    content: new Text(
                                        EnviarAlteracaoEscalaStrings.error));
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
              ),
            ],
          ),
        ],
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
