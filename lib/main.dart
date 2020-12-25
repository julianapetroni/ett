import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ett_app/screens/login/ui/login.page.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';

//“lock” the device orientation and not allow it to change as the user rotates their phone
void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          //brightness: Brightness.light,
          primarySwatch: Colors.grey,
          accentColor: Colors.amber,
          cursorColor: Colors.orange,
          // fontFamily: 'SourceSansPro',
          textTheme: TextTheme(
            display2: TextStyle(
              fontFamily: 'OpenSans',
              //fontSize: 45.0,
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
            display4: GoogleFonts.poppins(fontSize: 13),
            display3: GoogleFonts.poppins(fontSize: 13),
            display1: GoogleFonts.poppins(fontSize: 13),
            headline: GoogleFonts.poppins(fontSize: 13),
            title: GoogleFonts.poppins(fontSize: 16),
            //multiselect
            subhead: GoogleFonts.poppins(fontSize: 13, color: Colors.black),
            // tags
            body2: GoogleFonts.poppins(fontSize: 13),
            body1: GoogleFonts.poppins(fontSize: 13),
            subtitle: GoogleFonts.poppins(fontSize: 13),
            overline: GoogleFonts.poppins(fontSize: 13),
          ),
        ),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          DefaultCupertinoLocalizations.delegate,
          GlobalCupertinoLocalizations
              .delegate, // Add global cupertino localiztions.
        ],
        locale: Locale('pt', 'BR'), // Current locale
        supportedLocales: [const Locale('pt', 'BR')],
        home: MainApp()));
  });
}

class MainApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return TelaLogin();
  }
}
