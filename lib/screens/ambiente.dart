import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/style/lightColors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'avariasOnibus.dart';
import 'package:ett_app/services/token.dart';


class Ambiente extends StatefulWidget {
  Solicitacao sol;
  Usuario user;
  Token token;

  Ambiente({Key key, this.sol, this.user, this.token}) : super(key: key);

  @override
  AmbienteState createState() {
    return AmbienteState(sol: sol, user: user, token: token);
  }
}

class AmbienteState extends State<Ambiente> {
  Solicitacao sol;
  Usuario user;
  Token token;

  AmbienteState({this.sol, this.user, this.token});

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  dispose() {
    //Form
    _obsController.dispose();
    super.dispose();
  }

  //radio button
  String radioButtonItemAmbiente;
  // Group Value for Radio Button.
  int idAmbiente;
  bool rbAmbiente = false;


  //Obs.
  final _obsController = TextEditingController();
  TextEditingController _obstextFieldController = TextEditingController();

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
                padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 20, bottom: 20),
                      child: Row(
                        children: <Widget>[
                          Text("Ambiente:",
                              style: GoogleFonts.raleway(
                                  color: Colors.black87,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.w500,
                                  letterSpacing: 0.7)),
                        ],
                      ),
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          activeColor: Colors.black87,
                          value: 1,
                          groupValue: idAmbiente,
                          onChanged: (val) {
                            setState(() {
                              rbAmbiente = true;
                              radioButtonItemAmbiente = 'ONE';
                              idAmbiente = 1;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rbAmbiente = true;
                              radioButtonItemAmbiente = 'ONE';
                              idAmbiente = 1;
                            });
                          },
                          child: Text('Amanhecer',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14.0)),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          activeColor: Colors.black87,
                          value: 2,
                          groupValue: idAmbiente,
                          onChanged: (val) {
                            setState(() {
                              rbAmbiente = true;
                              radioButtonItemAmbiente = 'TWO';
                              idAmbiente = 2;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rbAmbiente = true;
                              radioButtonItemAmbiente = 'TWO';
                              idAmbiente = 2;
                            });
                          },
                          child: Text('Dia com luz natural',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14.0)),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          activeColor: Colors.black87,
                          value: 3,
                          groupValue: idAmbiente,
                          onChanged: (val) {
                            setState(() {
                              rbAmbiente = true;
                              radioButtonItemAmbiente = 'THREE';
                              idAmbiente = 3;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rbAmbiente = true;
                              radioButtonItemAmbiente = 'THREE';
                              idAmbiente = 3;
                            });
                          },
                          child: Text('Entardecer',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14.0)),
                        ),
                      ],
                    ),
                    Row(
                      children: <Widget>[
                        Radio(
                          activeColor: Colors.black87,
                          value: 4,
                          groupValue: idAmbiente,
                          onChanged: (val) {
                            setState(() {
                              rbAmbiente = true;
                              radioButtonItemAmbiente = 'FOUR';
                              idAmbiente = 4;
                            });
                          },
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              rbAmbiente = true;
                              radioButtonItemAmbiente = 'FOUR';
                              idAmbiente = 4;
                            });
                          },
                          child: Text('Noite com iluminação',
                              style: TextStyle(
                                  color: Colors.black87, fontSize: 14.0)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              //Mensagem
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    Text('Mensagem:',
                        style: GoogleFonts.raleway(
                            color: Colors.black87,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.7)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      maxLines: 5,
                      controller: _obstextFieldController,
                     maxLengthEnforced: true,
                      maxLength: 700,
                    ),
                  ),
                  SizedBox(height: 20.0),
//                  Padding(
//                    padding: const EdgeInsets.only(left: 20.0),
//                    child: Text(
//                        _obscharCount.toString() + " caracteres restantes",
//                        style:
//                            TextStyle(color: Colors.grey[600], fontSize: 12.0)),
//                  ),
                ],
              ),

              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 40, bottom: 40),
                child: FlatButton(
                  onPressed: () {
                    if (rbAmbiente == true) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AvariasOnibus(
                                  user: user,
                                  token: token,
                                  sol: sol,
                                )),
                      );
                    } else {
                      final semCadastro = new SnackBar(
                          content:
                              new Text('Escolha uma opção para prosseguir!'));
                      _scaffoldKey.currentState.showSnackBar(semCadastro);
                    }
                  },
                  textColor: Colors.white,
                  child: Container(
                    width: double.infinity,
                    height: 45.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.grey[600],
                          Colors.grey[500],
                          Colors.grey[300],
                        ],
                      ),
                    ),
                    //padding: const EdgeInsets.fromLTRB(90.0, 15.0, 90.0, 15.0),
                    child: Center(
                        child: const Text('PROSSEGUIR',
                            style: TextStyle(fontSize: 20))),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
