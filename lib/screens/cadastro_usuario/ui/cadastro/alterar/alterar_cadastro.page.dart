import 'dart:convert';
import 'package:ett_app/domains/cidade.dart';
import 'package:ett_app/domains/estado.dart';
import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/services/token.dart';
import 'package:ett_app/style/light_colors.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/widgets/formUI/white_form/white_form_decoration.dart';
import 'package:ett_app/widgets/logo_config/logo_ett_form.dart';
import 'package:ett_app/widgets/neon_gradient_decoration/background_decoration.dart';
import 'package:ett_app/widgets/formUI/button/button_decoration.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import '../../../../login/ui/login.page.dart';

class AlterarCadastro extends StatefulWidget {
  Usuario user;
  Token token;
  Solicitacao sol;

  AlterarCadastro(
      {Key key,
      // this.value,
      this.user,
      this.token,
      this.sol})
      : super(key: key);

  @override
  AlterarCadastroState createState() =>
      new AlterarCadastroState(user: user, token: token, sol: sol);
}

class AlterarCadastroState extends State<AlterarCadastro> {
  Usuario user;
  Token token;
  Solicitacao sol;

  AlterarCadastroState({this.user, this.token, this.sol});

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

  //Mask
  var cepController = new MaskedTextController(mask: '00000-000');

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
    var res = await http.get(
        'https://app.cartaopec.com.br/api/cadastros/cidades/status/ATIVO/?access_token=' +
            token.access_token.toString());
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
      if (mounted) {
        setState(() {
          _fieldListCidade = fieldListCidade;
        });
      }
    });
  }

  Future<String> _getDropDownEstado() async {
    var res = await http.get(
        'https://app.cartaopec.com.br/api/cadastros/estados/status/ATIVO/?access_token=' +
            token.access_token.toString());
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
      if (mounted) {
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
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
      backgroundColor: LightColors.neonYellowLight,
      elevation: 0,
    );
  }

  Widget _buildBody(BuildContext context) {
    var heightLogoETT = 80.0;
    var _cpfController = TextEditingController(text: "${user.cpf}");
    var cpfMaskFormatter = new MaskTextInputFormatter(
        mask: '###.###.###-##', filter: {"#": RegExp(r'[0-9]')});

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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 20.0, top: 10.0),
                            child: Row(
                              children: <Widget>[
                                Text("Alterar Cadastro",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        fontSize: 22.0,
                                        color: Colors.black87,
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
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  key: _nomeKey,
                                  controller: TextEditingController(
                                      text: '${user.nome}'),
                                  validator: composeValidators('nome',
                                      [requiredValidator, stringValidator]),
                                  onChanged: (value) => user.nome = value,
                                  onSaved: (value) => user.nome = value,

//                                        decoration: InputDecoration(hintText: '${user.nome}'),
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
                                      Icons.assignment_ind,
                                      color: Colors.grey[400],
                                      size: 19.0,
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Text(
                                      'CPF',
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  key: _cpfKey,
                                  validator: composeValidators('cpf', [
                                    requiredValidator,
                                    cpfValidator,
                                    maxLengthCPFValidator
                                  ]),
                                  onChanged: (value) => user.cpf = value,
                                  onSaved: (value) => user.cpf = value,
                                  controller: TextEditingController(
                                      text: '${user.cpf}'),
                                  // _cpfController, inputFormatters: [cpfMaskFormatter],  // -> "xxx.xxx.xxx-xx"
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
                                      'Endereço',
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  key: _enderecoKey,
                                  validator: composeValidators('endereço', [
                                    requiredValidator,
                                  ]),
                                  onSaved: (value) => user.endereco = value,
                                  onChanged: (value) => user.endereco = value,
                                  controller: TextEditingController(
                                      text: '${user.endereco}'),
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
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  key: _complementoKey,
//                                        validator: composeValidators('complemento', [
//                                          requiredValidator,
//                                        ]),
                                  onChanged: (value) =>
                                      user.complemento = value,
                                  onSaved: (value) => user.complemento = value,
                                  controller: TextEditingController(
                                      text: '${user.complemento}'),
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
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  key: _bairroKey,
                                  validator: composeValidators('bairro', [
                                    requiredValidator,
                                    stringValidator,
                                  ]),
                                  onChanged: (value) => user.bairro = value,
                                  onSaved: (value) => user.bairro = value,
                                  controller: TextEditingController(
                                      text: '${user.bairro}'),
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
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Form(
                                    //key: _cidadeKey,
                                    child: Container(
                                      decoration: new BoxDecoration(
                                          border: Border(
                                        bottom:
                                            BorderSide(color: Colors.grey[500]),
                                      )),
                                      child: DropdownButton<Cidade>(
                                        underline: SizedBox(),
                                        items:
                                            _fieldListCidade.map((Cidade cid) {
                                          return DropdownMenuItem<Cidade>(
                                            value: cid,
                                            child: Row(
                                              //mainAxisAlignment: MainAxisAlignment.center,
                                              children: <Widget>[
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5.0),
                                                  child: Text(
                                                    cid.nome,
                                                    style: TextStyle(
                                                      fontSize: 18,
                                                      color: Colors.grey[900],
                                                    ),
                                                  ),
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
                                          padding:
                                              const EdgeInsets.only(left: 5.0),
                                          child: new Text('${user.cidade.nome}',
                                              style: TextStyle(
                                                  color: Colors.grey[900])),
                                        ),
                                      ),
                                    ),
                                  ),
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
                                      'Estado',
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 20.0),
                                  child: Container(
                                    decoration: new BoxDecoration(
                                        border: Border(
                                      bottom:
                                          BorderSide(color: Colors.grey[500]),
                                    )),
                                    child: DropdownButton<Estado>(
                                      underline: SizedBox(),
                                      items: _fieldListEstado.map((Estado es) {
                                        return DropdownMenuItem<Estado>(
                                          value: es,
                                          child: Row(
                                            //mainAxisAlignment: MainAxisAlignment.center,
                                            children: <Widget>[
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5.0),
                                                child: Text(
                                                  es.sigla,
                                                  style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.grey[900],
                                                  ),
                                                ),
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
                                        padding:
                                            const EdgeInsets.only(left: 5.0),
                                        child: new Text(
                                          '${user.estado.sigla}',
                                          style: TextStyle(
                                              color: Colors.grey[900]),
                                        ),
                                      ),
                                    ),
                                  ),
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
                                      'CEP',
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  key: _cepKey,
                                  validator: composeValidators('cep', [
                                    requiredValidator,
                                    cepValidator,
                                    maxLengthCEPValidator
                                  ]),
                                  onChanged: (value) => user.cep = value,
                                  onSaved: (value) => user.cep = value,
                                  controller: TextEditingController(
                                      text: '${user.cep}'),
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
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  key: _telefoneKey,
                                  validator: composeValidators('telefone', [
                                    requiredValidator,
                                    minLengthValidator,
                                    numberValidator,
                                    maxLengthTelefoneValidator
                                  ]),
                                  onChanged: (value) => user.contato = value,
                                  onSaved: (value) => user.contato = value,
                                  controller: TextEditingController(
                                      text: '${user.contato}'),
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
                                      style: TextStyle(color: Colors.grey[500]),
                                    ),
                                  ],
                                ),
                                TextFormField(
                                  key: _emailKey,
                                  //style: Theme.of(context).textTheme.headline,
                                  controller: TextEditingController(
                                      text: '${user.email}'),
                                  validator: composeValidators('email', [
                                    requiredValidator,
                                    minLengthValidator,
                                    emailValidator
                                  ]),
                                  onChanged: (value) => user.email = value,
                                  onSaved: (value) => user.email = value,

//                                        decoration: InputDecoration(
//                                          // border: OutlineInputBorder(
//                                          //     borderRadius: BorderRadius.circular(5.0)),
//                                          //labelText: 'E-mail',
//                                          //border: InputBorder.none,
//                                            /*labelText: '${user.email}'*/),
                                ),
                              ],
                            ),
                          ),
                          ButtonDecoration(
                            buttonTitle: 'ALTERAR CADASTRO',
                            shouldHaveIcon: false,
                            onPressed: () {
                              if (citySel == null) {
                                _cidadeSelecionada = true;
                              }
                              if (estadoSel == null) {
                                _estadoSelecionado = true;
                              }

                              final form = _formKey.currentState;
                              if (form.validate()) {
                                form.save();
                                print(
                                    'password is: ${_loginData.password}, confirmPassword is: ${_loginData.confirmPassword}, email is: ${_loginData.email}, nome is: ${_loginData.nome}');

//                          Usuario user = new Usuario.vazio();
//                          Perfil perfil = new Perfil.vazio();
                                Cidade cidade = new Cidade.vazio();
                                Estado estado = new Estado.vazio();
//                          perfil.id = 2;
                                print(idCity);
                                print(idState);
                                if (idCity != null) {
                                  cidade.id = idCity;
                                  cidade.nome = _selectedFieldCidade;
                                  user.cidade = cidade;
                                }

                                if (idState != null) {
                                  estado.id = idState;
                                  estado.nome = _selectedFieldEstado;
                                  user.estado = estado;
                                }
//                          user.nome = _loginData.nome;
//                          user.cpf = _loginData.cpf;
//                          user.endereco = _loginData.endereco;
//                          user.complemento = _loginData.complemento; //_loginData.complemento;
//                          user.bairro = _loginData.bairro; //_loginData.bairro;
//
//
//
//                          user.cep = _loginData.cep;
//                          user.contato = _loginData.telefone;
//                          user.email = _loginData.email;

//                          user.observacao = "";
//                          user.perfil = perfil;
//                          user.status = 'ATIVO';
//                          user.senha = _loginData.password;
//                          user.resetSenha = 'N';

                                String url =
                                    'https://app.cartaopec.com.br/api/cadastros';
                                Map<String, dynamic> map = user.toJson();
                                String body = jsonEncode(map);
                                print(body);

                                http
                                    .put(url,
                                        headers: {
                                          'Content-Type': 'application/json'
                                        },
                                        body: body)
                                    .then((http.Response response) {
                                  print(
                                      "Response status: ${response.statusCode}");
                                  //print("Response body: ${response.contentLength}");
                                  //print(response.headers);
                                  print(response.body);
                                  if (response.statusCode == 200) {
                                    print("PASSOUYALL");
                                    final sucessoCadastro = new SnackBar(
                                        content: new Text(
                                            'Dados cadastrados com sucesso!'));
                                    _scaffoldKey.currentState
                                        .showSnackBar(sucessoCadastro);
                                    Future.delayed(const Duration(seconds: 3),
                                        () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => TelaLogin()),
                                      );
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  TelaLogin()),
                                          (Route<dynamic> route) => false);
                                    });
                                  } else {
                                    final erroCadastro = new SnackBar(
                                        content: new Text(
                                            'Verifique os seus dados!'));
                                    _scaffoldKey.currentState
                                        .showSnackBar(erroCadastro);
                                  }
                                });
                              } else {
                                setState(() => _autovalidate = true);
                              }
                            },
                          ),
                          SizedBox(height: 50.0),
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
