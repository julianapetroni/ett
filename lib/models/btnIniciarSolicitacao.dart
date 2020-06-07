import 'package:flutter/material.dart';

class btnIniciarSolicitacao extends StatefulWidget {
  @override
  btnIniciarSolicitacaoState createState() {
    return btnIniciarSolicitacaoState();
  }
}

class btnIniciarSolicitacaoState extends State<btnIniciarSolicitacao> {
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 20.0;
    var numBotoes = 6;

    void btnIniciarSol() {
      for (int i = 0; i < numBotoes; i++) {
        FlatButton(
          onPressed: () {
            //Navigator.pushNamed(context, '/listaDocs');
          },
          textColor: Colors.white,
          color: Colors.white,
          child: Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              gradient: LinearGradient(
                colors: <Color>[
                  Color(0xFF0D47A1),
                  Color(0xFF1976D2),
                  Color(0xFF42A5F5),
                ],
              ),
            ),
            //padding: const EdgeInsets.fromLTRB(90.0, 15.0, 90.0, 15.0),
            child:
                Center(child: const Text('', style: TextStyle(fontSize: 20))),
          ),
        );
      }
      return btnIniciarSol();
    }

    List<Text> textoBtn = [
      Text('ESCOLAR'),
      Text('GESTANTE'),
      Text('SÊNIOR'),
      Text('BILHETE ÚNICO'),
      Text('PREFEITURA'),
    ];

    List<FlatButton> btn = [
      FlatButton(
        onPressed: () {
          Navigator.pushNamed(context, '/listaDocs');
        },
        textColor: Colors.white,
        color: Colors.white,
        child: Container(
          width: double.infinity,
          height: height,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            gradient: LinearGradient(
              colors: <Color>[
                Color(0xFF0D47A1),
                Color(0xFF1976D2),
                Color(0xFF42A5F5),
              ],
            ),
          ),
          //padding: const EdgeInsets.fromLTRB(90.0, 15.0, 90.0, 15.0),
          child: Center(child: const Text('', style: TextStyle(fontSize: 20))),
        ),
      ),
    ];

    return btnIniciarSolicitacao();
  }
}
