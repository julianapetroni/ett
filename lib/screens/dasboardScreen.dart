import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:ett_app/screens/animation.dart';
import 'package:ett_app/screens/comunicadoInterno.dart';
import 'package:ett_app/screens/comunicadoInternoGrupo.dart';
import 'package:ett_app/screens/consultarAlteracaoEscala.dart';
import 'package:ett_app/screens/controleDeFreqDeLinha.dart';
import 'package:ett_app/screens/enviarAlteracaoEscala.dart';
import 'package:ett_app/screens/relatorioOcorrenciaTransito.dart';
import 'package:ett_app/style/lightColors.dart';
import 'package:ett_app/testes/cupertinoTime.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'login.dart';

class DashboardScreen extends StatefulWidget {
  static const routeName = '/dashboard';

  Usuario user;
  Token token;
  Solicitacao sol;

  DashboardScreen({Key key, this.user, this.token, this.sol})
      : assert(user.id != null),
        super(key: key);

  _DashboardScreenState createState() =>
      _DashboardScreenState(user: user, sol: sol, token: token);
}

class _DashboardScreenState extends State<DashboardScreen> {
  Usuario user;
  Token token;
  Solicitacao sol;

  _DashboardScreenState({this.user, this.sol, this.token});

  var rota;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
        title: Padding(
          padding: const EdgeInsets.only(
              top: 100, left: 120, right: 80, bottom: 100),
          child: Image.asset('images/logo-slim.png'),
        ),
    backgroundColor: Colors.grey[50],

    elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.exit_to_app,
              color: Colors.black87,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => TelaLogin()),
              );
            },
          )
        ],
    ),
    // backgroundColor: LightColors.neonYellowLight,
    body: Container(
    child: SafeArea(
    bottom: false,
    top: false,
    child: Padding(
    padding: const EdgeInsets.only(top: 0),
    child: Container(
    decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage("images/YellowBus.png"),
    fit: BoxFit.cover,
    ),
    ),
        //color: LightColors.neonETT.withOpacity(0.8),
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
        child: GridView.count(
          crossAxisCount: 2,
          padding: EdgeInsets.all(3.0),
          children: <Widget>[
            makeDashboardItem(
                "Enviar Comunicado Interno",
                Icons.record_voice_over,
                ComunicadoInterno(user: user, sol: sol, token: token)),
            makeDashboardItem("Todos Relatórios\n", Icons.assessment,
                ComunicadoInternoGrupo(user: user, token: token, sol: sol)),
            makeDashboardItem(
                "Frequência de Linha",
                Icons.directions_bus,
                //CupertinoExample()),

                ControleDeFrequenciaDeLinha(
                    user: user, sol: sol, token: token)),
            makeDashboardItem(
                "Análise de Monitoramento",
                Icons.assignment,
                RelatorioOcorrenciaTransito(
                    user: user, sol: sol, token: token)),
            makeDashboardItem("Enviar Alteração de Escala", Icons.reorder,
                EnviarAlteracaoEscala(user: user, sol: sol, token: token)),
            makeDashboardItem(
                "Consultar Alteração de Escala",
                Icons.search,
//                HomePage()
                ConsultarAlteracaoEscala(
                    user: user, token: token, sol: sol,
                ))
          ],
        ),
      ),
    ))));
  }

  Card makeDashboardItem(String title, IconData icon, var rota) {
    return Card(
        elevation: 1.0,
        margin: new EdgeInsets.all(8.0),
        shape: RoundedRectangleBorder(
          //side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
          decoration: new BoxDecoration(
            shape: BoxShape.rectangle,
            color: LightColors.neonETT.withOpacity(0.1),
            borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
          ),
          //BoxDecoration(color: LightColors.neonETT),
          child: new InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => rota),
              );
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              verticalDirection: VerticalDirection.down,
              children: <Widget>[
                SizedBox(height: 50.0),
                Center(
                    child: Icon(
                  icon,
                  size: 40.0,
                  color: Colors.black87,
                )),
                SizedBox(height: 20.0),
                new Flexible(
                  child: Center(
                    child: new Text(
                      title,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.raleway(fontSize: 16),
//                        style: new TextStyle(
////                            fontSize: 13.0,
////                            color: Colors.black87,
////                            letterSpacing: 1
//
//                        )
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
