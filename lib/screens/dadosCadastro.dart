import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:ett_app/screens/login.dart';
import 'package:ett_app/domains/Estado.dart';
import 'package:ett_app/domains/Perfil.dart';
import 'package:ett_app/domains/Usuario.dart';
import 'package:ett_app/domains/Cidade.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/screens/termosDeUso.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:http/http.dart' as http;

class DadosCadastro extends StatefulWidget {
  @override
  DadosCadastroState createState() => new DadosCadastroState();
}

class DadosCadastroState extends State<DadosCadastro> {

  int idCity;
  int idState;


  List<Cidade> _fieldListCidade = List();
  String _selectedFieldCidade = null;
  Cidade citySel;


  List<Estado> _fieldListEstado = List();
  String _selectedFieldEstado = null;
  Estado estadoSel;


  bool _isChecked = false;

  void onChanged(bool value) {
    setState(() {
      _isChecked = value;
    });
  }

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _passwordKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _confirmPasswordKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _emailKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _nomeKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _rgKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _cpfKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _telefoneKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _cepKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _enderecoKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _complementoKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _bairroKey =
  GlobalKey<FormFieldState<String>>();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _nomeController = TextEditingController();
  final _rgController = TextEditingController();
  final _cpfController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _cepController = TextEditingController();
  final _enderecoController = TextEditingController();
  final _cidadeController = TextEditingController();
  final _complementoController = TextEditingController();
  final _bairroController = TextEditingController();
  final _estadoController = TextEditingController();

  @override
  initState() {
    super.initState();
    _getFieldsCidade();
    _getFieldsEstado();
  }


  Future<String> _getDropDownCidade() async {
    var res = await http.get('https://www.accio.com.br:447/api/cadastros/cidades/status/ATIVO/?access_token=d16e3966-eb87-4337-bfee-bee54b5a4052');
    print(res.body);
    return res.body;
  }
  void _getFieldsCidade() {
    _getDropDownCidade().then((nome) {
      final items = jsonDecode(nome).cast<Map<String, dynamic>>();
      var fieldListCidade = items.map<Cidade>((json) {
        return Cidade.fromJson(json);
      }).toList();
      _selectedFieldCidade = fieldListCidade[0].nome;

      // update widget
      if(mounted) {
        setState(() {
          _fieldListCidade = fieldListCidade;
        });
      }
    });
  }

  Future<String> _getDropDownEstado() async {
    var res = await http.get('https://www.accio.com.br:447/api/cadastros/estados/status/ATIVO/?access_token=d16e3966-eb87-4337-bfee-bee54b5a4052');
    print(res.body);
    return res.body;
  }
  void _getFieldsEstado() {
    _getDropDownEstado().then((sigla) {
      final items = jsonDecode(sigla).cast<Map<String, dynamic>>();
      var fieldListEstado = items.map<Estado>((json) {
        return Estado.fromJson(json);
      }).toList();
      _selectedFieldEstado = fieldListEstado[0].sigla;

      // update widget
      if(mounted) {
        setState(() {
          _fieldListEstado = fieldListEstado;
        });
      }
    });
  }


  @override
  dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _nomeController.dispose();
    _rgController.dispose();
    _cpfController.dispose();
    _telefoneController.dispose();
    _cepController.dispose();
    _enderecoController.dispose();
    _cidadeController.dispose();
    _complementoController.dispose();
    _bairroController.dispose();
    _estadoController.dispose();

    super.dispose();
  }


  // Initially password is obscure
  bool _obscureText = true;

  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  bool _cidadeSelecionada = false;
  bool _estadoSelecionado = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.grey[600]),
        title: Center(
            child: Text(
              ' ',
              style: TextStyle(color: Colors.grey[400]),
            )),
        backgroundColor: Colors.grey[100],
        actions: <Widget>[
          Padding(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
              child: Row(
                children: <Widget>[],
              ))
        ],
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(top: 20.0),
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 5,
                  child: Container(
                    height: 450.0,
                    width: double.infinity,
                    child: ListView(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          child: Form(
                            key: _formKey,
                            autovalidate: _autovalidate,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Container(
                                  height: 80.0,
                                  width: double.infinity,
                                  child: Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Image(
                                          image: AssetImage('images/ETT.png'),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30.0),
                                Padding(
                                  padding:
                                  const EdgeInsets.only(left: 20.0, top: 10.0),
                                  child: Row(
                                    children: <Widget>[
                                      Text("Cadastro",
                                          textAlign: TextAlign.start,
                                          style: TextStyle(
                                              fontSize: 22.0,
                                              color: Colors.yellow[800],
                                              fontFamily: "Poppins-Bold",
                                              letterSpacing: .6)),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 30.0,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, bottom: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.person,
                                            color: Colors.grey[400],
                                            size: 19.0,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'Nome',
                                            style:
                                            TextStyle(color: Colors.grey[500]),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        key: _nomeKey,
                                        validator: composeValidators('nome',
                                            [requiredValidator, stringValidator]),
                                        onSaved: (value) => _loginData.nome = value,
                                        decoration: InputDecoration(hintText: ' '),
                                      ),
                                    ],
                                  ),
                                ),
//                            Padding(
//                              padding: const EdgeInsets.only(
//                                  left: 20.0, right: 20.0, bottom: 10.0),
//                              child: Column(
//                                children: <Widget>[
//                                  Row(
//                                    children: <Widget>[
//                                      Icon(
//                                        Icons.assignment_ind,
//                                        color: Colors.grey[400],
//                                        size: 19.0,
//                                      ),
//                                      SizedBox(
//                                        width: 10.0,
//                                      ),
//                                      Text(
//                                        'RG',
//                                        style:
//                                            TextStyle(color: Colors.grey[500]),
//                                      ),
//                                    ],
//                                  ),
//                                  TextFormField(
//                                    key: _rgKey,
//                                    validator: composeValidators(
//                                        'rg', [requiredValidator, rgValidator]),
//                                    onSaved: (value) => _loginData.rg = value,
//                                    decoration: InputDecoration(hintText: ' '),
//                                  ),
//                                ],
//                              ),
//                            ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, bottom: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.assignment_ind,
                                            color: Colors.grey[400],
                                            size: 19.0,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'CPF',
                                            style:
                                            TextStyle(color: Colors.grey[500]),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        key: _cpfKey,
                                        validator: composeValidators('cpf',
                                            [requiredValidator, cpfValidator]),
                                        onSaved: (value) => _loginData.cpf = value,
                                        decoration: InputDecoration(hintText: ' '),
                                      ),
                                    ],
                                  ),
                                ),
//                            Padding(
//                              padding: const EdgeInsets.only(
//                                  left: 20.0, right: 20.0, bottom: 10.0),
//                              child: Column(
//                                children: <Widget>[
//                                  Row(
//                                    children: <Widget>[
//                                      Icon(
//                                        Icons.phone,
//                                        color: Colors.grey[400],
//                                        size: 19.0,
//                                      ),
//                                      SizedBox(
//                                        width: 10.0,
//                                      ),
//                                      Text(
//                                        'Telefone',
//                                        style:
//                                            TextStyle(color: Colors.grey[500]),
//                                      ),
//                                    ],
//                                  ),
//                                  TextFormField(
//                                    key: _telefoneKey,
//                                    validator: composeValidators('telefone', [
//                                      requiredValidator,
//                                      minLegthValidator,
//                                      numberValidator
//                                    ]),
//                                    onSaved: (value) =>
//                                        _loginData.telefone = value,
//                                    decoration: InputDecoration(hintText: ''),
//                                  ),
//                                ],
//                              ),
//
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, bottom: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.home,
                                            color: Colors.grey[400],
                                            size: 19.0,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'Endereço',
                                            style:
                                            TextStyle(color: Colors.grey[500]),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        key: _enderecoKey,
                                        validator: composeValidators('endereço', [
                                          requiredValidator,
                                        ]),
                                        onSaved: (value) =>
                                        _loginData.endereco = value,
                                        decoration: InputDecoration(
                                          // border: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.circular(5.0)),
                                          //labelText: 'E-mail',
                                          //border: InputBorder.none,
                                            hintText: ' '),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, bottom: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.home,
                                            color: Colors.grey[400],
                                            size: 19.0,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'Complemento',
                                            style:
                                            TextStyle(color: Colors.grey[500]),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        key: _complementoKey,
                                        validator: composeValidators('complemento', [
                                          requiredValidator,
                                        ]),
                                        onSaved: (value) =>
                                        _loginData.complemento = value,
                                        decoration: InputDecoration(
                                          // border: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.circular(5.0)),
                                          //labelText: 'E-mail',
                                          //border: InputBorder.none,
                                            hintText: ' '),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, bottom: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.home,
                                            color: Colors.grey[400],
                                            size: 19.0,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'Bairro',
                                            style:
                                            TextStyle(color: Colors.grey[500]),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        key: _bairroKey,
                                        validator: composeValidators('bairro', [
                                          requiredValidator, stringValidator,
                                        ]),
                                        onSaved: (value) =>
                                        _loginData.bairro = value,
                                        decoration: InputDecoration(
                                            hintText: ' '),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, bottom: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.pin_drop,
                                            color: Colors.grey[400],
                                            size: 19.0,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'Cidade',
                                            style:
                                            TextStyle(color: Colors.grey[500]),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20.0),
                                        child: Form(
                                          //key: _cidadeKey,
                                          child: Container(
                                            decoration: new BoxDecoration(
                                                border: Border(bottom: BorderSide(color: Colors.grey[500]),
                                                )
                                            ),
                                            child: DropdownButton<Cidade>(

                                              underline: SizedBox(),
                                              items: _fieldListCidade.map((Cidade cid) {
                                                return DropdownMenuItem<Cidade>(
                                                  value: cid,
                                                  child: Row(
                                                    //mainAxisAlignment: MainAxisAlignment.center,
                                                    children: <Widget>[
                                                      Padding(
                                                        padding: const EdgeInsets.only(left: 5.0),
                                                        child: Text(cid.nome, style: TextStyle(
                                                          fontSize: 18,
                                                          color: Colors.grey[700],
                                                        ),),
                                                      ),
                                                    ],
                                                  ),
                                                );
                                              }).toList(),
                                              value: citySel,
                                              onChanged: (value) {
                                                citySel = value;
                                                print(citySel.nome);
                                                _selectedFieldCidade = citySel.nome;
                                                idCity = citySel.id;

                                                setState(() {
                                                  //_selectedFieldCidade = value;
                                                  _cidadeSelecionada = false;
                                                });
                                              },
                                              isExpanded: true,
                                              hint: Padding(
                                                padding: const EdgeInsets.only(left: 5.0),
                                                child: new Text('Selecione uma cidade',
                                                    style: TextStyle(color: Colors.grey[500])),
                                              ),

                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                    visible: _cidadeSelecionada,
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                                          child: Container(
                                            child: Text('Escolha uma cidade', style: TextStyle(color: Colors.red),),
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, bottom: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.pin_drop,
                                            color: Colors.grey[400],
                                            size: 19.0,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'Estado',
                                            style:
                                            TextStyle(color: Colors.grey[500]),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 20.0),
                                        child: Container(
                                          decoration: new BoxDecoration(
                                              border: Border(bottom: BorderSide(color: Colors.grey[500]),
                                              )
                                          ),
                                          child: DropdownButton<Estado>(
                                            underline: SizedBox(),
                                            items: _fieldListEstado.map((Estado es) {
                                              return DropdownMenuItem<Estado>(
                                                value: es,
                                                child: Row(
                                                  //mainAxisAlignment: MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding: const EdgeInsets.only(left: 5.0),
                                                      child: Text(es.sigla, style: TextStyle(
                                                        fontSize: 18,
                                                        color: Colors.grey[700],
                                                      ),),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }).toList(),
                                            value: estadoSel,
                                            onChanged: (value) {
                                              estadoSel = value;
                                              print(estadoSel.sigla);
                                              _selectedFieldEstado = estadoSel.sigla;
                                              idState = estadoSel.id;

                                              setState(() {
                                                //_selectedFieldEstado = value;
                                                _estadoSelecionado = false;
                                              });
                                            },
                                            isExpanded: true,
                                            hint: Padding(
                                              padding: const EdgeInsets.only(left: 5.0),
                                              child: new Text('Selecione um Estado',
                                                style: TextStyle(color: Colors.grey[500]),),
                                            ),

                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Visibility(
                                    visible: _estadoSelecionado,
                                    child: Row(
                                      children: <Widget>[
                                        Padding(
                                          padding: const EdgeInsets.only(left: 20.0, bottom: 20.0),
                                          child: Container(
                                            child: Text('Escolha um Estado', style: TextStyle(color: Colors.red),),
                                          ),
                                        ),
                                      ],
                                    )),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, bottom: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.pin_drop,
                                            color: Colors.grey[400],
                                            size: 19.0,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'CEP',
                                            style:
                                            TextStyle(color: Colors.grey[500]),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        key: _cepKey,
                                        validator: composeValidators('cep', [
                                          requiredValidator,
                                          minLegthValidator,
                                          cepValidator
                                        ]),
                                        onSaved: (value) => _loginData.cep = value,
                                        decoration: InputDecoration(hintText: ' '),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, bottom: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.phone,
                                            color: Colors.grey[400],
                                            size: 19.0,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'Contato',
                                            style:
                                            TextStyle(color: Colors.grey[500]),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        key: _telefoneKey,
                                        validator: composeValidators('telefone', [
                                          requiredValidator,
                                          minLegthValidator,
                                          numberValidator
                                        ]),
                                        onSaved: (value) =>
                                        _loginData.telefone = value,
                                        decoration: InputDecoration(
                                          // border: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.circular(5.0)),
                                          //labelText: 'E-mail',
                                          //border: InputBorder.none,
                                            hintText: ' '),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20.0, right: 20.0, bottom: 10.0),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.mail_outline,
                                            color: Colors.grey[400],
                                            size: 19.0,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'E-mail',
                                            style:
                                            TextStyle(color: Colors.grey[500]),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        key: _emailKey,
                                        //style: Theme.of(context).textTheme.headline,
                                        controller: _emailController,
                                        validator: composeValidators('email', [
                                          requiredValidator,
                                          minLegthValidator,
                                          emailValidator
                                        ]),

                                        onSaved: (value) =>
                                        _loginData.email = value,
                                        decoration: InputDecoration(
                                          // border: OutlineInputBorder(
                                          //     borderRadius: BorderRadius.circular(5.0)),
                                          //labelText: 'E-mail',
                                          //border: InputBorder.none,
                                            hintText: 'nome@email.com.br'),
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.lock_open,
                                            color: Colors.grey[400],
                                            size: 19.0,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'Senha',
                                            style:
                                            TextStyle(color: Colors.grey[500]),
                                          ),
                                          Spacer(),
                                          new FlatButton(
                                              onPressed: _toggle,
                                              child: new Icon(
                                                  _obscureText
                                                      ? Icons.remove_red_eye
                                                      : Icons.lock,
                                                  color: Colors.grey))
                                        ],
                                      ),
                                      TextFormField(
                                        key: _passwordKey,
                                        controller: _passwordController,
                                        validator: composeValidators('a senha',
                                            [requiredValidator, minLegthValidator]),
                                        onSaved: (value) =>
                                        _loginData.password = value,
                                        decoration: InputDecoration(
                                          //border: OutlineInputBorder(
                                          // borderRadius: BorderRadius.circular(5.0)),
                                          //labelText: 'E-mail',
                                          //border: InputBorder.none,
                                            hintText: '******'),
                                        obscureText: _obscureText,
                                      ),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding:
                                  const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                  child: Column(
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(
                                            Icons.lock_open,
                                            color: Colors.grey[400],
                                            size: 19.0,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text(
                                            'Senha',
                                            style:
                                            TextStyle(color: Colors.grey[500]),
                                          ),
                                        ],
                                      ),
                                      TextFormField(
                                        key: _confirmPasswordKey,
                                        controller: _confirmPasswordController,
                                        validator: composeValidators('a senha',
                                            [requiredValidator, minLegthValidator]),
                                        onSaved: (value) =>
                                        _loginData.confirmPassword = value,
                                        decoration: InputDecoration(
                                          //border: OutlineInputBorder(
                                          // borderRadius: BorderRadius.circular(5.0)),
                                          //labelText: 'E-mail',
                                          //border: InputBorder.none,
                                            hintText: '******'),
                                        obscureText: _obscureText,
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 20.0),
                                Center(
                                  child: new Column(
                                    children: <Widget>[
                                      new CheckboxListTile(
                                          title: new Text(
                                            'Concordo com os termos de uso',
                                            style: TextStyle(
                                                color: Colors.grey[600],
                                                fontSize: 13.0,
                                                fontWeight: FontWeight.w600),
                                          ),
                                          value: _isChecked,
                                          activeColor: Colors.orange[600],
                                          onChanged: (bool value) {
                                            onChanged(value);
                                          }),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => TermosDeUso()),
                                        );
                                      });
                                    },
                                    child: Container(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Icon(
                                            Icons.folder,
                                            color: Colors.blue,
                                          ),
                                          SizedBox(
                                            width: 10.0,
                                          ),
                                          Text("Termos de uso",
                                              style: TextStyle(
                                                  color: Colors.blue,
                                                  fontFamily: "Poppins-Bold")),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 50.0),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: FlatButton(
                    onPressed: () {
                      if (citySel == null){
                        _cidadeSelecionada = true;
                      }
                      if (estadoSel == null){
                        _estadoSelecionado = true;
                      }

                      final form = _formKey.currentState;
                      if (form.validate()) {
                        form.save();
                        print(
                            'password is: ${_loginData
                                .password}, confirmPassword is: ${_loginData
                                .confirmPassword}, email is: ${_loginData
                                .email}, nome is: ${_loginData.nome}');


                        // If the form is valid, display a Snackbar.
                        if (_isChecked == false) {
                          final snackBar = new SnackBar(
                              content:
                              new Text('Favor concordar com os Termos de Uso'));
                          _scaffoldKey.currentState.showSnackBar(snackBar);
                        } else if (_passwordController.text !=
                            _confirmPasswordController.text) {
                          final senhasDif =
                          new SnackBar(content: new Text('Senhas Diferentes!'));
                          _scaffoldKey.currentState.showSnackBar(senhasDif);
                        }
                        else {
                          Usuario user = new Usuario.vazio();
                          Perfil perfil = new Perfil.vazio();
                          Cidade cidade = new Cidade.vazio();
                          Estado estado = new Estado.vazio();
                          perfil.id = 2;
                          print(idCity);
                          print(idState);
                          cidade.id = idCity;
                          estado.id = idState;
                          user.nome = _loginData.nome;
                          user.cpf = _loginData.cpf;
                          user.endereco = _loginData.endereco;
                          user.complemento = _loginData.complemento; //_loginData.complemento;
                          user.bairro = _loginData.bairro; //_loginData.bairro;
                          cidade.nome = _loginData.cidade;
                          user.cidade = cidade;
                          estado.nome = _loginData.estado; //_loginData.estado
                          user.estado = estado;
                          user.cep = _loginData.cep;
                          user.contato = _loginData.telefone;
                          user.email = _loginData.email;
                          user.observacao = "";
                          user.perfil = perfil;
                          user.status = 'ATIVO';
                          user.senha = _loginData.password;
                          user.resetSenha = 'N';

                          String url = 'https://www.accio.com.br:447/api/cadastros';
                          Map<String, dynamic> map = user.toJson();
                          String body = jsonEncode(map);
                          print(body);


                          http
                              .post(url,
                              headers: {
                                'Content-Type':
                                'application/json'
                              },
                              body: body)
                              .then((http.Response response) {
                            print("Response status: ${response.statusCode}");
                            //print("Response body: ${response.contentLength}");
                            //print(response.headers);
                            print(response.body);
                            if (response.statusCode == 200) {
                              print("PASSOUYALL");
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => TelaLogin()),
                          );
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => TelaLogin()),
                                  (Route<dynamic> route) => false);
                            }
                          });
                        }
                      }
                      else {
                        setState(() => _autovalidate = true);
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
                          child: const Text('CADASTRAR',
                              style: TextStyle(fontSize: 20))),
                    ),
                  ),
                ),
              ],
            ),
          )),
    );
  }
}
