import 'dart:ui';
import 'package:ett_app/screens/cadastro_usuario/ui/cadastro/alterar/alterar_cadastro.page.dart';
import 'package:ett_app/screens/ponto/ui/ponto.page.dart';
import 'package:ett_app/services/token.dart';
import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/style/light_colors.dart';
import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/domains/usuario.dart';
import '../../screens/login/ui/login.page.dart';

class AppBarETT extends AppBar {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBarETT({Key key, context})
      : super(
          key: key,
          iconTheme: new IconThemeData(color: Colors.black87),
          title: Padding(
            padding: const EdgeInsets.only(
                top: 120, left: 80, right: 90, bottom: 120),
            child: Image.asset(
              GeneralConfig.logoImage,
              fit: BoxFit.scaleDown,
            ),
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
        );
}

class MyDrawer extends Drawer {
  var cancelar = 'CANCELADO';

  Usuario user;
  Token token;
  Solicitacao sol;

  MyDrawer({Key key, this.user, this.token, this.sol})
      : super(
          key: key,
        );

  @override
  Widget build(BuildContext context) {
    _color() {
      Colors.black87;
    }

    _colorChange() {
      setState() {
        Colors.yellow[800];
      }
    }

    return Drawer(
      child: Container(
        color: LightColors.neonYellowLight,
        child: ListView(
          children: <Widget>[
            Padding(
              padding:
                  const EdgeInsets.only(left: 30.0, top: 40.0, bottom: 30.0),
              child: Text("Menu",
                  style: TextStyle(
                      fontSize: 22.0,
                      color: Colors.black87,
                      fontFamily: "Poppins-Bold",
                      letterSpacing: .6)),
            ),
            ListTile(
              title: Text(
                'Cartão de Ponto',
                style: TextStyle(color: Colors.black87, fontSize: 16.0),
              ),
              leading: Icon(Icons.timer, color: Colors.grey[700]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CartaoDePonto(
                            user: user,
                            token: token,
                            sol: sol,
                          )),
                );
              },
            ),
            ListTile(
              title: Text(
                'Dados Cadastrais',
                style: TextStyle(color: Colors.black87, fontSize: 16.0),
              ),
              leading: Icon(Icons.person, color: Colors.grey[700]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => AlterarCadastro(
                            user: user,
                            token: token,
                            sol: sol,
                          )),
                );
              },
            ),
            ListTile(
              title: new Text(
                'Sair',
                style: TextStyle(color: Colors.red[700], fontSize: 17.0),
              ),
              leading: Icon(
                Icons.exit_to_app,
                color: Colors.red[700],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TelaLogin()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class AppBarComLogoSlim extends AppBar {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  AppBarComLogoSlim({Key key, Widget title})
      : super(
          key: key,
          backgroundColor: LightColors.neonYellowLight,
          elevation: 0.0,
          title: Row(
            children: <Widget>[
              Spacer(flex: 2),
              Container(
                  height: 45.0,
                  child: Image(image: AssetImage(GeneralConfig.logoImage))),
              Spacer(flex: 2),
              Container(
                child: Icon(Icons.person),
              ),
              SizedBox(
                width: 5.0,
              ),
            ],
          ),
        );
}
