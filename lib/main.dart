import 'package:flutter/cupertino.dart';
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
import 'package:google_fonts/google_fonts.dart';

//“lock” the device orientation and not allow it to change as the user rotates their phone
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(localizationsDelegates: [
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      DefaultCupertinoLocalizations.delegate,
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
      theme: ThemeData(
        //brightness: Brightness.light,
        primarySwatch: Colors.grey,
        accentColor: Colors.amber,
        cursorColor: Colors.orange,
        // fontFamily: 'SourceSansPro',
        textTheme: TextTheme(
          display2:
          TextStyle(
            fontFamily: 'OpenSans',
            fontSize: 45.0,
            // fontWeight: FontWeight.w400,
            color: Colors.white,
          ),
          button: TextStyle(
            // OpenSans is similar to NotoSans but the uppercases look a bit better IMO
            fontFamily: 'OpenSans',
          ),
          caption: TextStyle(
            fontFamily: 'NotoSans',
            fontSize: 12.0,
            fontWeight: FontWeight.normal,
            color: Colors.black87,
          ),
          display4: GoogleFonts.raleway(fontSize: 14),
          display3: GoogleFonts.raleway(fontSize: 14),
          display1: GoogleFonts.raleway(fontSize: 14),
          headline: GoogleFonts.raleway(fontSize: 14),
          title: GoogleFonts.raleway(fontSize: 16),
          //multiselect
          subhead: GoogleFonts.raleway(fontSize: 14, color: Colors.black),
          // tags
          body2: GoogleFonts.raleway(fontSize: 13),
          body1: GoogleFonts.raleway(fontSize: 20),
          subtitle: GoogleFonts.raleway(fontSize: 16),
          overline: GoogleFonts.raleway(fontSize: 16),
        ),
      ),
    );
  }
}
