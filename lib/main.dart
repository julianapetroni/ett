import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
//import 'package:pec_login/screens/agendarData.dart';
//import 'package:pec_login/screens/fotosDosDocs.dart';
//import 'package:pec_login/screens/iniciarSolicitacao.dart';
import 'package:ett_app/screens/login.dart';
//import 'package:pec_login/screens/novaSenha.dart';
//import 'package:pec_login/screens/selecionarInstituicao.dart';
//import 'package:pec_login/screens/status.dart';
//import 'package:pec_login/screens/termosDeUso.dart';
//import 'package:pec_login/screens/dadosCadastro.dart';
//import 'package:pec_login/screens/docsNecessarios.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

//“lock” the device orientation and not allow it to change as the user rotates their phone
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate
    ], supportedLocales: [
      const Locale('pt', 'BR')
    ], home: MainApp()));
  });
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TelaLogin(),
    );
  }
}
