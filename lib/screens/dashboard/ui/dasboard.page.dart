import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:ett_app/screens/comunicado_interno/ui/comunicado_interno.page.dart';
import 'package:ett_app/screens/todos_relatorios/ui/comunicado_interno_grupo.dart';
import 'package:ett_app/screens/alterar_escala/ui/consultar/consultar_alteracao_escala.page.dart';
import 'package:ett_app/screens/frequencia_linha/ui/controle_frequencia_linha.page.dart';
import 'package:ett_app/screens/analise_monitoramento/ui/relatorio_ocorrencia_transito.dart';
import 'package:ett_app/style/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ett_app/services/token.dart';
import '../../alterar_escala/ui/enviar/enviar_alteracao_escala.page.dart';
import '../../../widgets/app_bar/appBar.dart';

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
        appBar: _buildAppBar(context),
        drawer: _buildDrawer(context),
        body: _buildBody(context));
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBarETT(
      context: context,
    );
  }

  Widget _buildDrawer(BuildContext context) {
    return MyDrawer(
      user: user,
      sol: sol,
      token: token,
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Stack(
          children: [
            Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("images/YellowBus.png"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child: Container(),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 20.0, horizontal: 2.0),
                      child: GridView.count(
                        crossAxisCount: 2,
                        padding: EdgeInsets.all(3.0),
                        children: <Widget>[
                          makeDashboardItem(
                              "Enviar Comunicado Interno",
                              Icons.record_voice_over,
                              ComunicadoInterno(
                                  user: user, sol: sol, token: token)),
                          makeDashboardItem(
                              "Todos Relatórios\n",
                              Icons.assessment,
                              ComunicadoInternoGrupo(
                                  user: user, token: token, sol: sol)),
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
                          makeDashboardItem(
                              "Enviar Alteração de Escala",
                              Icons.reorder,
                              EnviarAlteracaoEscala(
                                  user: user, sol: sol, token: token)),
                          makeDashboardItem(
                              "Consultar Alteração de Escala",
                              Icons.search,
                              ConsultarAlteracaoEscala(
                                user: user,
                                token: token,
                                sol: sol,
                              ))
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ],
    );
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
                      style: GoogleFonts.poppins(fontSize: 16),
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
