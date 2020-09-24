import 'package:ett_app/screens/conclusoesRelOcorrencia.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/services/token.dart';
import 'package:ett_app/domains/usuario.dart';
import '../style/lightColors.dart';
import "package:flutter/painting.dart";
import "package:flutter/foundation.dart";

class Testemunhas extends StatefulWidget {
  Solicitacao sol;
  Usuario user;
  Token token;

  Testemunhas({Key key, this.sol, this.user, this.token})
      : super(key: key);

  @override
  TestemunhasState createState() {
    return TestemunhasState(sol: sol, user: user, token: token);
  }
}

class TestemunhasState
    extends State<Testemunhas> {
  Solicitacao sol;
  Usuario user;
  Token token;

  TestemunhasState({this.sol, this.user, this.token});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //Mask
  var teltest1Controller = new MaskedTextController(mask: '(00)00000-0000');
  var teltest2Controller = new MaskedTextController(mask: '(00)00000-0000');
  var rgTest1Controller = new MaskedTextController(mask: '00.000.000-0');
  var rgTest2Controller = new MaskedTextController(mask: '00.000.000-0');


  //testemunhas stepper
  int currentStep = 0;
  bool complete = false;
  bool incomplete = false;
  final _formStepperKey = new GlobalKey<FormState>();

  testemunha1() {
    if (incomplete == true) {
      Text(
        'Preencher os dados da Testemunha 1:',
        style: TextStyle(color: Colors.red),
      );
    }
  }

  goTo(int step) {
    setState(() {
      currentStep = currentStep + step;
    });
  }



  @override
  Widget build(BuildContext context) {




    @override
    void initState() {
      super.initState();
    }


    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: LightColors.neonYellowLight,
        elevation: 0.0,
        title: Padding(
          padding: const EdgeInsets.only(
              top: 100, left: 80, right: 120, bottom: 100),
          child: Image.asset('images/logo-slim.png'),
        ),
        iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                LightColors.neonYellowLight,
                LightColors.neonETT,
              ],
            ),
          ),
          child: ListView(
            children: <Widget>[
              Padding(
                padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Testemunhas (passageiros ou transeuntes):',
                        style: GoogleFonts.raleway(
                            color: Colors.black87,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.7),
                      ),
                    ),
                  ],
                ),
              ),

              //testemunhas stepper

              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Container(
                  child: complete
                      ? Center(
                    child: AlertDialog(
                      title: Center(child: new Text("Atenção", style: GoogleFonts.raleway(
                          color: Colors.black87,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.7),)),
                      content: new Text(
                        "Testemunhas registradas com sucesso!", style: GoogleFonts.raleway(fontSize: 16),
                        textAlign: TextAlign.center,
                      ),
                      actions: <Widget>[
                        new FlatButton(
                          child: new Text("PROSSEGUIR", style: GoogleFonts.raleway(fontSize: 16, color: Colors.blue),),
                          onPressed: () {
                            setState(()
                                {
                                  Navigator.push(context,
                                    MaterialPageRoute(builder: (context) => ConclusoesRelOcorrencia(user: user, token: token, sol: sol,)),);
                                }
                            //=> complete = false
                            );
                          },
                        ),
                      ],
                    ),
                  )
                      : Form(
                    key: _formStepperKey,
                    child: Stepper(
                      steps: [
                        Step(
                          isActive: true,
                          state: StepState.indexed,
                          title: const Text('Testemunha 1:', ),
                          //subtitle: testemunha1(),
                          content: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration:
                                InputDecoration(labelText: 'Nome', labelStyle: GoogleFonts.raleway(fontSize: 16)),
                                keyboardType: TextInputType.text,
                                autocorrect: false,
//                                validator: composeValidators('nome',
//                                  [requiredValidator, stringValidator]),
//                                        onSaved: (String value) {
//                                          user.nome = value;
//                                        },
                                maxLines: 1,
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value.length < 1) {
                                    return 'Digite o nome da testemunha 1!';
                                  }
                                  return null;
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Endereço residencial', labelStyle: GoogleFonts.raleway(fontSize: 16)),
                                keyboardType: TextInputType.text,
                                autocorrect: false,
//                                validator: composeValidators('endereço',
//                                    [requiredValidator, stringValidator]),
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value.length < 5) {
                                    return 'Digite o endereço da testemunha 1!';
                                  }
                                },
//            onSaved: (String value) {
//              data.phone = value;
//            },
                                maxLines: 1,
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Telefone', labelStyle: GoogleFonts.raleway(fontSize: 16)),
                                keyboardType: TextInputType.phone,
                                maxLength: 14,
                                controller: teltest1Controller,
                                autocorrect: false,
//                                validator: composeValidators('telefone',
//                                    [requiredValidator, numberValidator]),
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value.length < 10) {
                                    return 'Digite o telefone da testemunha 1!';
                                  }
                                },
//            onSaved: (String value) {
//              data.phone = value;
//            },
                                maxLines: 1,
                              ),
                              TextFormField(
                                decoration:
                                InputDecoration(labelText: 'RG', labelStyle: GoogleFonts.raleway(fontSize: 16)),
                                keyboardType: TextInputType.number,
                                controller: rgTest1Controller,
                                maxLength: 12,
                                autocorrect: false,
//                                validator: composeValidators('RG',
//                                    [requiredValidator, rgValidator]),
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value.length < 8) {
                                    return 'Digite o RG da testemunha 1!';
                                  }
                                },
//            onSaved: (String value) {
//              data.phone = value;
//            },
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                        Step(
                          state: StepState.indexed,
                          isActive: true,
                          title: const Text('Testemunha 2:'),
                          //subtitle: const Text("Error!"),
                          content: Column(
                            children: <Widget>[
                              TextFormField(
                                decoration:
                                InputDecoration(labelText: 'Nome', labelStyle: GoogleFonts.raleway(fontSize: 16)),
                                keyboardType: TextInputType.text,
                                autocorrect: false,
//                                validator: composeValidators('nome',
//                                    [requiredValidator, stringValidator]),
//            onSaved: (String value) {
//              data.name = value;
//            },
                                maxLines: 1,
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value.length < 1) {
                                    return 'Digite o nome da testemunha 2!';
                                  }
                                },
                              ),
                              TextFormField(
                                decoration: InputDecoration(
                                    labelText: 'Endereço residencial', labelStyle: GoogleFonts.raleway(fontSize: 16)),
                                keyboardType: TextInputType.text,
                                autocorrect: false,
//                                validator: composeValidators('endereço',
//                                    [requiredValidator, stringValidator]),
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value.length < 5) {
                                    return 'Digite o endereço da testemunha 2!';
                                  } else {
                                    null;
                                  }
                                },
//            onSaved: (String value) {
//              data.phone = value;
//            },
                                maxLines: 1,
                              ),
                              TextFormField(
                                maxLength: 14,
                                decoration: InputDecoration(
                                    labelText: 'Telefone', labelStyle: GoogleFonts.raleway(fontSize: 16)),
                                keyboardType: TextInputType.phone,
                                autocorrect: false,
                                controller: teltest2Controller,
//                                validator: composeValidators('telefone',
//                                    [requiredValidator, numberValidator]),
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value.length < 10) {
                                    return 'Digite o telefone da testemunha 2!';
                                  }
                                },
//            onSaved: (String value) {
//              data.phone = value;
//            },
                                maxLines: 1,
                              ),
                              TextFormField(
                                decoration:
                                InputDecoration(labelText: 'RG', labelStyle: GoogleFonts.raleway(fontSize: 16)),
                                keyboardType: TextInputType.number,
                                controller: rgTest2Controller,
                                maxLength: 12,
                                autocorrect: false,
                                validator: (value) {
                                  if (value.isEmpty ||
                                      value.length < 8) {
                                    return 'Digite o telefone da testemunha 2!';
                                  }
                                },
//                                validator: composeValidators('RG',
//                                    [requiredValidator, rgValidator]),
//            onSaved: (String value) {
//              data.phone = value;
//            },
                                maxLines: 1,
                              ),
                            ],
                          ),
                        ),
                      ],
                      currentStep: this.currentStep,
                      onStepContinue: () {
                        if (currentStep + 1 != 2) {
                          goTo(currentStep + 1);
                        } else {
                          if (_formStepperKey.currentState.validate()) {
                            //setState(() => complete = true );
                            setState(() {
                              complete = true;
                            });
                          } else {
                            final semCadastro =
                            new SnackBar(content: new Text('Preencha todos os campos para prosseguir!'));
                            _scaffoldKey.currentState.showSnackBar(semCadastro);
                          }
                        }
                      },
                      onStepTapped: (_currentStep) {
                        setState(() {
                          currentStep = _currentStep;
                        });
                      },
                      //onStepTapped: (step) => goTo(step),
                      onStepCancel: () {
                        if (currentStep != 0) {
                          goTo(-1);
                        }
                      },
                      controlsBuilder: (BuildContext context,
                          {VoidCallback onStepContinue,
                            VoidCallback onStepCancel}) {
                        return Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: Container(
                                  color: Colors.black87,
                                  child: FlatButton(
                                      onPressed: onStepContinue,
                                      child: Text(
                                        'PROSSEGUIR',
                                        style: GoogleFonts.raleway(fontSize: 16, color: Colors.white),
                                      ))),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 20),
                              child: FlatButton(
                                  onPressed: onStepCancel,
                                  child: Text('RETORNAR',
                                      style: GoogleFonts.raleway(fontSize: 16))),
                            )
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
//            Padding(
//              padding: const EdgeInsets.only(left: 10, right: 10, top: 40, bottom: 40),
//              child: FlatButton(
//                onPressed: () {
////                      if (citySel == null){
////                        _cidadeSelecionada = true;
////                      }
////                      if (estadoSel == null){
////                        _estadoSelecionado = true;
////                      }
////
////                      final form = _formKey.currentState;
////                      if (form.validate()) {
////                        form.save();
////                        print(
////                            'password is: ${_loginData
////                                .password}, confirmPassword is: ${_loginData
////                                .confirmPassword}, email is: ${_loginData
////                                .email}, nome is: ${_loginData.nome}');
////
////
////                        // If the form is valid, display a Snackbar.
////                        if (_isChecked == false) {
////                          final snackBar = new SnackBar(
////                              content:
////                              new Text('Favor concordar com os Termos de Uso'));
////                          _scaffoldKey.currentState.showSnackBar(snackBar);
////                        } else if (_passwordController.text !=
////                            _confirmPasswordController.text) {
////                          final senhasDif =
////                          new SnackBar(content: new Text('Senhas Diferentes!'));
////                          _scaffoldKey.currentState.showSnackBar(senhasDif);
////                        }
////                        else {
////                          Usuario user = new Usuario.vazio();
////                          Perfil perfil = new Perfil.vazio();
////                          Cidade cidade = new Cidade.vazio();
////                          Estado estado = new Estado.vazio();
////                          perfil.id = 2;
////                          print(idCity);
////                          print(idState);
////                          cidade.id = idCity;
////                          estado.id = idState;
////                          user.nome = _loginData.nome;
////                          user.cpf = _loginData.cpf;
////                          user.endereco = _loginData.endereco;
////                          user.complemento = _loginData.complemento; //_loginData.complemento;
////                          user.bairro = _loginData.bairro; //_loginData.bairro;
////                          cidade.nome = _loginData.cidade;
////                          user.cidade = cidade;
////                          estado.nome = _loginData.estado; //_loginData.estado
////                          user.estado = estado;
////                          user.cep = _loginData.cep;
////                          user.contato = _loginData.telefone;
////                          user.email = _loginData.email;
////                          user.observacao = "";
////                          user.perfil = perfil;
////                          user.status = 'ATIVO';
////                          user.senha = _loginData.password;
////                          user.resetSenha = 'N';
////
////                          String url = 'https://www.accio.com.br:447/api/cadastros';
////                          Map<String, dynamic> map = user.toJson();
////                          String body = jsonEncode(map);
////                          print(body);
////
////
////                          http
////                              .post(url,
////                              headers: {
////                                'Content-Type':
////                                'application/json'
////                              },
////                              body: body)
////                              .then((http.Response response) {
////                            print("Response status: ${response.statusCode}");
////                            //print("Response body: ${response.contentLength}");
////                            //print(response.headers);
////                            print(response.body);
////                            if (response.statusCode == 200) {
////                              print("PASSOUYALL");
//                  Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => ConclusoesRelOcorrencia(user: user, token: token, sol: sol,)),
//                  );
//                },
//                textColor: Colors.white,
//                color: Colors.white,
//                child: Container(
//                  width: double.infinity,
//                  height: 45.0,
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(15.0),
//                    gradient: LinearGradient(
//                      colors: <Color>[
//                        Colors.yellow[800],
//                        Colors.yellow[700],
//                        Colors.yellow[600],
//                      ],
//                    ),
//                  ),
//                  //padding: const EdgeInsets.fromLTRB(90.0, 15.0, 90.0, 15.0),
//                  child: Center(
//                      child: const Text('PROSSEGUIR',
//                          style: TextStyle(fontSize: 20))),
//                ),
//              ),
//            ),
            ],
          ),
        ),
      ),
    );
  }
}




