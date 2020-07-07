import 'dart:convert';

import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/screens/formCheckBoxComunicadoInterno.dart';
import 'package:ett_app/screens/formComunicadoInterno.dart';
import 'package:ett_app/screens/login.dart';
import 'package:ett_app/screens/status.dart';
import 'package:ett_app/style/lightColors.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'appBar.dart';

class ComunicadoInterno extends StatefulWidget {
  Solicitacao sol;
  Usuario user;
  Token token;

  ComunicadoInterno(
      {Key key,
      // this.value,
      this.sol,
      this.user,
      this.token})
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
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

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

    if (_isValid) {
      //form is valid
    }
  }

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = true;

  //Form
  //mask
  var dataController = new MaskedTextController(mask: '00/00/0000');
  var horaController = new MaskedTextController(mask: '00:00:00');

  int _charCount = 700;

  _onChanged(String value) {
    setState(() {
      _charCount = 700 - value.length;
    });
  }

  String _mySelection;
  String _mySelectionSentido;

  final GlobalKey<FormFieldState<String>> _dataKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _horaKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _veiculoKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _chapaKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _nomeKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _localKey =
      GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _mensagemKey =
      GlobalKey<FormFieldState<String>>();

  final _dataController = TextEditingController();
  final _horaController = TextEditingController();
  final _veiculoController = TextEditingController();
  final _chapaController = TextEditingController();
  final _nomeController = TextEditingController();
  final _localController = TextEditingController();
  final _mensagemController = TextEditingController();

  var chapaController = new MaskedTextController(mask: '000000');

  TextEditingController _textFieldController = TextEditingController();

  @override
  initState() {
    getSWData();
    super.initState();
  }

  _submit() {
    final form = _formKey.currentState;
    if (form.validate()) {
      form.save();
    } else {
      setState(() => _autovalidate = true);
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: LightColors.neonYellowLight,
        //Colors.black,
        iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
        elevation: 0,
      ),
      // backgroundColor: LightColors.neonETT,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
//              Colors.black,
//              Colors.black54,
              LightColors.neonYellowLight,
              LightColors.neonETT,
              LightColors.neonETT,
            ],
          ),
        ),
        child: SafeArea(
          child: ListView(
            shrinkWrap: true,
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
              SizedBox(height: 10.0),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 70.0),
                    child: Container(
                      width: double.infinity,
                      //margin: EdgeInsets.fromLTRB(0.0, 0.0, 40.0, 0.0),
                      child: Form(
                        key: _formKey,
                        autovalidate: _autovalidate,
                        child: Padding(
                          padding: const EdgeInsets.all(25.0),
                          child: Container(
                            width: double.infinity,
                            height: 1320,
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8.0),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0.0, 15.0),
                                      blurRadius: 15.0),
                                  BoxShadow(
                                      color: Colors.black12,
                                      offset: Offset(0.0, -10.0),
                                      blurRadius: 10.0),
                                ]),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: 16.0, right: 16.0, top: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  SizedBox(
                                    height: 30.0,
                                  ),

                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[

                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0),
                                        child: Text(
                                          "Comunicado Interno",
                                          textAlign: TextAlign.start,
                                          style: GoogleFonts.raleway (color: Colors.black87,
                                              fontSize: 19.0, fontWeight: FontWeight.w700, letterSpacing: 0.7)
                                        ),
                                      ),
                                      SizedBox(
                                        height: 30.0,
                                      ),
                                      SizedBox(height: 10),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Data: *',
                                              style:  GoogleFonts.raleway(color: Colors.black87, fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: TextFormField(
                                          key: _dataKey,
                                          controller: dataController,
                                          validator: composeValidators(
                                              'a data', [
                                            requiredValidator,
                                            dataValidator
                                          ]),
                                          onSaved: (value) =>
                                              _loginData.foraDeServico = value,
                                          decoration:
                                              InputDecoration(hintText: ''),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Hora: *',
                                              style:  GoogleFonts.raleway(color: Colors.black87, fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: TextFormField(
                                          key: _horaKey,
                                          controller: horaController,
                                          validator: composeValidators(
                                              'a hora', [
                                            requiredValidator,
                                            minLegthValidator
                                          ]),
                                          onSaved: (value) =>
                                              _loginData.hora = value,
                                          decoration:
                                              InputDecoration(hintText: ''),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: Row(
                                          children: <Widget>[
                                            Flexible(
                                              child: Text(
                                                'Chapa do funcionário associado:',
                                                style:  GoogleFonts.raleway(color: Colors.black87, fontSize: 15),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0, top: 10.0),
                                        child: TextFormField(
                                          key: _chapaKey,
                                          controller: chapaController,
                                          validator: composeValidators(
                                              'a chapa', [minLegthValidator, maxLegthNumero6Validator]),
                                          onSaved: (value) =>
                                              _loginData.chapa = value,
                                          decoration:
                                              InputDecoration(hintText: ''),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Nome:',
                                              style:  GoogleFonts.raleway(color: Colors.black87, fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0, top: 10.0),
                                        child: TextFormField(
                                          key: _nomeKey,
                                          controller: _nomeController,
                                          validator: composeValidators(
                                              'o nome', [minLegthValidator]),
                                          onSaved: (value) =>
                                              _loginData.veiculo = value,
                                          decoration:
                                              InputDecoration(hintText: ''),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Veículo:',
                                              style:  GoogleFonts.raleway(color: Colors.black87, fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0, top: 10.0),
                                        child: TextFormField(
                                          key: _veiculoKey,
                                          controller: _veiculoController,
                                          validator: composeValidators(
                                              'o veículo', [minLegthValidator]),
                                          onSaved: (value) =>
                                              _loginData.veiculo = value,
                                          decoration:
                                              InputDecoration(hintText: ''),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Local da ocorrência:',
                                              style:  GoogleFonts.raleway(color: Colors.black87, fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0, top: 10.0),
                                        child: TextFormField(
                                          key: _localKey,
                                          controller: _localController,
                                          validator: composeValidators(
                                              'o local da ocorrência',
                                              [minLegthValidator]),
                                          onSaved: (value) =>
                                              _loginData.local = value,
                                          decoration:
                                              InputDecoration(hintText: ''),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Linha:',
                                              style:  GoogleFonts.raleway(color: Colors.black87, fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: DropdownButton(
                                          items: data.map((item) {
                                            return new DropdownMenuItem(
                                              child:
                                                  new Text(item['item_name']),
                                              value: item['id'].toString(),
                                            );
                                          }).toList(),
                                          onChanged: (newVal) {
                                            setState(() {
                                              _mySelection = newVal;
                                              _dropdownError = null;
                                            });
                                          },
                                          value: _mySelection,
                                          isExpanded: true,
                                          hint: Text('Selecione a linha'),
                                        ),
                                      ),
                                      _dropdownError == null
                                          ? SizedBox.shrink()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Text(
                                                _dropdownError ?? "",
                                                style: TextStyle(
                                                    color: Colors.red[800],
                                                    fontSize: 12),
                                              ),
                                            ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Sentido:',
                                              style:  GoogleFonts.raleway(color: Colors.black87, fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: DropdownButton(
                                          items: data.map((item) {
                                            return new DropdownMenuItem(
                                              child:
                                                  new Text(item['item_name']),
                                              value: item['id'].toString(),
                                            );
                                          }).toList(),
                                          onChanged: (valSentido) {
                                            setState(() {
                                              _mySelectionSentido = valSentido;
                                              _dropdownErrorSentido = null;
                                            });
                                          },
                                          value: _mySelectionSentido,
                                          isExpanded: true,
                                          hint: Text('Selecione o sentido'),
                                        ),
                                      ),
                                      _dropdownErrorSentido == null
                                          ? SizedBox.shrink()
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20.0),
                                              child: Text(
                                                _dropdownErrorSentido ?? "",
                                                style: TextStyle(
                                                    color: Colors.red[800],
                                                    fontSize: 12),
                                              ),
                                            ),
                                      SizedBox(
                                        height: 20.0,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(
                                            left: 20.0, right: 20.0),
                                        child: Row(
                                          children: <Widget>[
                                            Text(
                                              'Mensagem:',
                                              style:  GoogleFonts.raleway(color: Colors.black87, fontSize: 15),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 25.0),
                                            child: TextField(
                                              maxLines: 5,
                                              controller: _textFieldController,
                                              onChanged: _onChanged,
                                              inputFormatters: [
                                                LengthLimitingTextInputFormatter(
                                                    700),
                                              ],
                                            ),
                                          ),
                                          SizedBox(height: 20.0),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Text(
                                                _charCount.toString() +
                                                    " caracteres restantes",
                                                style: TextStyle(
                                                    color: Colors.grey[600],
                                                    fontSize: 12.0)),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: 40.0),
                                  FlatButton(
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 20.0),
                                      child: FlatButton(
                                        onPressed: () {
                                          _validateForm();
                                          if (_formKey.currentState
                                                  .validate() &&
                                              _mySelection != null &&
                                              _mySelectionSentido != null) {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                // return object of type Dialog
                                                return AlertDialog(
                                                  title: Center(
                                                      child: new Icon(
                                                    Icons.check_circle,
                                                    size: 50.0,
                                                    color: Colors.green,
                                                  )),
                                                  content: Row(
                                                    children: <Widget>[
                                                      Flexible(
                                                        child: new Text(
                                                          'Formulário registrado com sucesso!',
                                                          style: TextStyle(
                                                              fontSize: 16.0,
                                                              color: Colors
                                                                  .grey[600],
                                                              fontFamily:
                                                                  "Poppins-Bold",
                                                              letterSpacing:
                                                                  .6),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  actions: <Widget>[
                                                    // usually buttons at the bottom of the dialog
                                                    new FlatButton(
                                                      child: new Text(
                                                        "Ok",
                                                        style: TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                      ),
                                                      onPressed: () {
                                                        Navigator.of(context)
                                                            .pop();
                                                      },
                                                    ),
                                                  ],
                                                );
                                              },
                                            );
                                            Future.delayed(
                                                const Duration(
                                                    milliseconds: 3000), () {
                                              //setState(() {

                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) => Status(
                                                      sol: sol,
                                                      user: user,
                                                      token: token
                                                      //textSucesso: textSucesso,
                                                      //alertSucessoVisible: alertSucessoVisible,

                                                      ),
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
                                        child: Container(
                                          width: double.infinity,
                                          height: 45.0,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(25.0),
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
                                                style: TextStyle(fontSize: 20)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 10.0),
                                ],
                              ),
                            ),
                          ),
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
