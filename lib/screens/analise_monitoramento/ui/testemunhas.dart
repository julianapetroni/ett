import 'package:ett_app/screens/analise_monitoramento/ui/conclusoes_rel_ocorrencia.page.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/services/token.dart';
import 'package:ett_app/domains/usuario.dart';
import '../../../style/light_colors.dart';
import "package:flutter/painting.dart";
import "package:flutter/foundation.dart";

class Testemunhas extends StatefulWidget {
  Solicitacao sol;
  Usuario user;
  Token token;

  Testemunhas({Key key, this.sol, this.user, this.token}) : super(key: key);

  @override
  TestemunhasState createState() {
    return TestemunhasState(sol: sol, user: user, token: token);
  }
}

class TestemunhasState extends State<Testemunhas> {
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
  bool _nomeTest1Field = false;
  bool _nomeTest2Field = false;
  bool _endTest1Field = false;
  bool _endTest2Field = false;
  bool _telTest1Field = false;
  bool _telTest2Field = false;
  bool _rgTest1Field = false;
  bool _rgTest2Field = false;
  final _formStepperKey = new GlobalKey<FormState>();

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
      appBar: _buildAppBar(context),
      body: _buildBody(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Container(
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
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Text(
                    'Testemunhas (passageiros ou transeuntes):',
                    style: GoogleFonts.poppins(
                        color: Colors.black87,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.7),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
              child:
                  // complete
                  //     ? Center(
                  //         child: AlertDialog(
                  //           title: Center(
                  //               child: new Text(
                  //             "Atenção",
                  //             style: GoogleFonts.poppins(
                  //                 color: Colors.black87,
                  //                 fontSize: 17.0,
                  //                 fontWeight: FontWeight.w500,
                  //                 letterSpacing: 0.7),
                  //           )),
                  //           content: new Text(
                  //             "Preencha as conclusões para finalizar!",
                  //             style: GoogleFonts.poppins(fontSize: 16),
                  //             textAlign: TextAlign.center,
                  //           ),
                  //           actions: <Widget>[
                  //             new FlatButton(
                  //               child: new Text(
                  //                 "PROSSEGUIR",
                  //                 style: GoogleFonts.poppins(
                  //                     fontSize: 16, color: Colors.blue),
                  //               ),
                  //               onPressed: () {
                  //                 setState(() {
                  //                   Navigator.push(
                  //                     context,
                  //                     MaterialPageRoute(
                  //                         builder: (context) =>
                  //                             ConclusoesRelOcorrencia(
                  //                               user: user,
                  //                               token: token,
                  //                               sol: sol,
                  //                             )),
                  //                   );
                  //                 });
                  //               },
                  //             ),
                  //           ],
                  //         ),
                  //       )
                  //     :
                  Form(
                key: _formStepperKey,
                child: Stepper(
                  steps: [
                    Step(
                      isActive: true,
                      state: StepState.indexed,
                      title: const Text(
                        'Testemunha 1:',
                      ),
                      //subtitle: testemunha1(),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Nome',
                                labelStyle: GoogleFonts.poppins(fontSize: 16)),
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            onSaved: (value) {
                              setState(() {
                                _nomeTest1Field = true;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _nomeTest1Field = true;
                              });
                            },
//                                validator: composeValidators('nome',
//                                  [requiredValidator, stringValidator]),
//                                        onSaved: (String value) {
//                                          user.nome = value;
//                                        },
                            maxLines: 1,
                            validator: (value) {
                              if (value.isEmpty || value.length < 1) {
                                return 'Digite o nome da testemunha 1!';
                              }
                              return null;
                            },
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Endereço residencial',
                                labelStyle: GoogleFonts.poppins(fontSize: 16)),
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            onSaved: (value) {
                              setState(() {
                                _endTest1Field = true;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _endTest1Field = true;
                              });
                            },
                            validator: (value) {
                              if (value.isEmpty || value.length < 1) {
                                return 'Digite o endereço da testemunha 1!';
                              }
                              return null;
                            },
                            maxLines: 1,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Telefone',
                                labelStyle: GoogleFonts.poppins(fontSize: 16)),
                            keyboardType: TextInputType.phone,
                            maxLength: 14,
                            controller: teltest1Controller,
                            autocorrect: false,
                            validator: (value) {
                              if (value.isEmpty || value.length < 1) {
                                return 'Digite o telefone da testemunha 1!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _telTest1Field = true;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _telTest1Field = true;
                              });
                            },
                            maxLines: 1,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'RG',
                                labelStyle: GoogleFonts.poppins(fontSize: 16)),
                            keyboardType: TextInputType.number,
                            controller: rgTest1Controller,
                            maxLength: 12,
                            autocorrect: false,
                            validator: (value) {
                              if (value.isEmpty || value.length < 1) {
                                return 'Digite o RG da testemunha 1!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _rgTest1Field = true;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _rgTest1Field = true;
                              });
                            },
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    Step(
                      state: StepState.indexed,
                      isActive: true,
                      title: const Text('Testemunha 2:'),
                      content: Column(
                        children: <Widget>[
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Nome',
                                labelStyle: GoogleFonts.poppins(fontSize: 16)),
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            validator: (value) {
                              if (value.isEmpty || value.length < 1) {
                                return 'Digite o nome da testemunha 2!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _nomeTest2Field = true;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _nomeTest2Field = true;
                              });
                            },
                            maxLines: 1,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'Endereço residencial',
                                labelStyle: GoogleFonts.poppins(fontSize: 16)),
                            keyboardType: TextInputType.text,
                            autocorrect: false,
                            validator: (value) {
                              if (value.isEmpty || value.length < 1) {
                                return 'Digite o endereço da testemunha 2!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _endTest2Field = true;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _endTest2Field = true;
                              });
                            },
                            maxLines: 1,
                          ),
                          TextFormField(
                            maxLength: 14,
                            decoration: InputDecoration(
                                labelText: 'Telefone',
                                labelStyle: GoogleFonts.poppins(fontSize: 16)),
                            keyboardType: TextInputType.phone,
                            autocorrect: false,
                            controller: teltest2Controller,
                            validator: (value) {
                              if (value.isEmpty || value.length < 1) {
                                return 'Digite o telefone da testemunha 2!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _telTest2Field = true;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _telTest2Field = true;
                              });
                            },
                            maxLines: 1,
                          ),
                          TextFormField(
                            decoration: InputDecoration(
                                labelText: 'RG',
                                labelStyle: GoogleFonts.poppins(fontSize: 16)),
                            keyboardType: TextInputType.number,
                            controller: rgTest2Controller,
                            maxLength: 12,
                            autocorrect: false,
                            validator: (value) {
                              if (value.isEmpty || value.length < 1) {
                                return 'Digite o RG da testemunha 2!';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              setState(() {
                                _rgTest2Field = true;
                              });
                            },
                            onChanged: (value) {
                              setState(() {
                                _rgTest2Field = true;
                              });
                            },
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
                        setState(() {
                          complete = true;

                          if (_nomeTest1Field == true &&
                              _nomeTest2Field == true &&
                              _endTest1Field == true &&
                              _endTest2Field == true &&
                              _telTest1Field == true &&
                              _telTest2Field == true &&
                              _rgTest1Field == true &&
                              _rgTest2Field == true) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (context) => //ResumoRelatorioOcorrenciaTransito
                                        ConclusoesRelOcorrencia(
                                  user: user,
                                  token: token,
                                  sol: sol,
                                ),
                              ),
                            );
                          }
                        });
                      } else {
                        final semCadastro = new SnackBar(
                            content: new Text(
                                'Preencha todos os campos para prosseguir!'));
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
                                    style: GoogleFonts.poppins(
                                        fontSize: 16, color: Colors.white),
                                  ))),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: FlatButton(
                              onPressed: onStepCancel,
                              child: Text('RETORNAR',
                                  style: GoogleFonts.poppins(fontSize: 16))),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: LightColors.neonYellowLight,
      elevation: 0.0,
      title: Padding(
        padding:
            const EdgeInsets.only(top: 100, left: 80, right: 120, bottom: 100),
        child: Image.asset(GeneralConfig.logoImage),
      ),
      iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
    );
  }
}
