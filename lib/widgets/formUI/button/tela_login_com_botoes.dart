import 'package:ett_app/screens/cadastro_usuario/ui/cadastro/criar/dados_cadastro.dart';
import 'package:ett_app/style/light_colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TelaLoginComBotoes extends StatelessWidget {
  @override
  bool imagemComContainer;
  bool containerLogin;
  bool botaoLogin;
  MediaQueryData queryData;
  var loginWidth;
  var loginHeight;

  TelaLoginComBotoes(this.imagemComContainer, this.containerLogin,
      this.botaoLogin, this.queryData, this.loginWidth, this.loginHeight);

  Widget build(BuildContext context) {
    return _buildBody(context);
  }

  Widget _buildBody(BuildContext context) {
    queryData = MediaQuery.of(context);
    double imageHeight = queryData.size.height - 120;
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.only(top: 500),
          width: queryData.size.width - 10,
          height: 45.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            gradient: LinearGradient(
              colors: <Color>[
                Colors.grey[700],
                Colors.grey[500],
                Colors.grey[200],
              ],
            ),
          ),
          child: FlatButton(
            //color: Colors.grey[200],
            child: Text('LOGIN',
                style: GoogleFonts.poppins(
                    color: LightColors.neonETT,
                    letterSpacing: 4,
                    fontWeight: FontWeight.w800,
                    fontSize: 20)),
            onPressed: () {
              // setState(() {
              imagemComContainer = true;
              containerLogin = true;
              botaoLogin = false;
              // });
            },
          ),
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          width: queryData.size.width - 10,
          height: 45.0,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(25.0),
            gradient: LinearGradient(
              colors: <Color>[
                Colors.grey[700],
                Colors.grey[500],
                Colors.grey[200],
              ],
            ),
          ),
          child: FlatButton(
            onPressed: () {
              //setState(() {
              imageHeight = 600.0;
              loginWidth = 400.0;
              loginHeight = 300.0;
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => DadosCadastro()),
              );
              // });
            },
            child: Text(
              'CADASTRAR',
              style: GoogleFonts.poppins(
                  color: Colors.red[800],
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  letterSpacing: 4),
            ),
          ),
        ),
      ],
    );
  }
}
