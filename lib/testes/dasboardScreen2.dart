//import 'package:ett_app/domains/solicitacao.dart';
//import 'package:ett_app/domains/usuario.dart';
//import 'package:ett_app/screens/animation.dart';
//import 'package:ett_app/screens/comunicadoInterno.dart';
//import 'package:ett_app/screens/comunicadoInternoGrupo.dart';
//import 'package:ett_app/screens/consultarAlteracaoEscala.dart';
//import 'package:ett_app/screens/controleDeFreqDeLinha.dart';
//import 'package:ett_app/screens/enviarAlteracaoEscala.dart';
//import 'package:ett_app/screens/relatorioOcorrenciaTransito.dart';
//import 'package:ett_app/style/lightColors.dart';
//import 'package:flutter/material.dart';
//import 'package:google_fonts/google_fonts.dart';
//
//import 'login.dart';
//
//class DashboardScreen extends StatefulWidget {
//  static const routeName = '/dashboard';
//
//  Usuario user;
//  Token token;
//  Solicitacao sol;
//
//  DashboardScreen({Key key, this.user, this.token, this.sol})
//      : assert(user.id != null),
//        super(key: key);
//
//  _DashboardScreenState createState() =>
//      _DashboardScreenState(user: user, sol: sol, token: token);
//}
//
//class _DashboardScreenState extends State<DashboardScreen> {
//  Usuario user;
//  Token token;
//  Solicitacao sol;
//
//  _DashboardScreenState({this.user, this.sol, this.token});
//
//  var rota;
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        title: Padding(
//          padding: const EdgeInsets.all(70.0),
//          child: Image.asset('images/logo-slim.png', ),
//        ),
//        elevation: 0,
//        iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
//        backgroundColor: LightColors.neonETT.withOpacity(0.8),
//        actions: <Widget>[
//          IconButton(
//            icon: Icon(
//              Icons.exit_to_app,
//              color: Colors.black87,
//            ),
//            onPressed: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => TelaLogin()),
//              );
//            },
//          )
//        ],
//      ),
//      body: Container(
//        color: LightColors.neonETT.withOpacity(0.8),
//        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
//        child: GridView.count(
//          crossAxisCount: 2,
//          padding: EdgeInsets.all(3.0),
//          children: <Widget>[
//            makeDashboardItem(
//                "Enviar Comunicado Interno",
//                Icons.record_voice_over,
//                ComunicadoInterno(user: user, sol: sol, token: token)),
//            makeDashboardItem("Todos Relatórios\n", Icons.assessment,
//                ComunicadoInternoGrupo(user: user)),
//            makeDashboardItem(
//                "Frequência de Linha",
//                Icons.directions_bus,
//                ControleDeFrequenciaDeLinha(
//                    user: user, sol: sol, token: token)),
//            makeDashboardItem(
//                "Ocorrência de Trânsito",
//                Icons.error,
//                RelatorioOcorrenciaTransito(
//                    user: user, sol: sol, token: token)),
//            makeDashboardItem("Enviar Alteração de Escala", Icons.reorder,
//                EnviarAlteracaoEscala(user: user, sol: sol, token: token)),
//            makeDashboardItem(
//                "Consultar Alteração de Escala",
//                Icons.search,
////                HomePage()
//                ConsultarAlteracaoEscala(
//                  user: user,
//                ))
//          ],
//        ),
//      ),
//    );
//  }
//
//  Card makeDashboardItem(String title, IconData icon, var rota) {
//    return Card(
//        elevation: 1.0,
//        margin: new EdgeInsets.all(8.0),
//        shape: RoundedRectangleBorder(
//          //side: BorderSide(color: Colors.white70, width: 1),
//          borderRadius: BorderRadius.circular(15),
//        ),
//        child: Container(
//          decoration: new BoxDecoration(
//            shape: BoxShape.rectangle,
//            color: LightColors.neonETT.withOpacity(0.1),
//            borderRadius: new BorderRadius.all(new Radius.circular(15.0)),
//          ),
//          //BoxDecoration(color: LightColors.neonETT),
//          child: new InkWell(
//            onTap: () {
//              Navigator.push(
//                context,
//                MaterialPageRoute(builder: (context) => rota),
//              );
//            },
//            child: Column(
//              crossAxisAlignment: CrossAxisAlignment.stretch,
//              mainAxisSize: MainAxisSize.min,
//              verticalDirection: VerticalDirection.down,
//              children: <Widget>[
//                SizedBox(height: 50.0),
//                Center(
//                    child: Icon(
//                  icon,
//                  size: 40.0,
//                  color: Colors.black87,
//                )),
//                SizedBox(height: 20.0),
//                new Flexible(
//                  child: Center(
//                    child: new Text(
//                      title,
//                      textAlign: TextAlign.center,
//                      style: GoogleFonts.architectsDaughter(fontSize: 17),
////                        style: new TextStyle(
//////                            fontSize: 13.0,
//////                            color: Colors.black87,
//////                            letterSpacing: 1
////
////                        )
//                    ),
//                  ),
//                )
//              ],
//            ),
//          ),
//        ));
//  }
//}
