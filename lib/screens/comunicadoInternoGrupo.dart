import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/screens/appBar.dart';
import 'package:ett_app/screens/login.dart';
import 'package:ett_app/style/lightColors.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:json_table/json_table.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';


class ComunicadoInternoGrupo extends StatefulWidget {
  Token token;
  Solicitacao sol;
  Usuario user;

  ComunicadoInternoGrupo(
      {Key key,
        // this.value,
        this.token,
        this.user,
        this.sol})
      : super(key: key);

  @override
  ComunicadoInternoGrupoState createState() {
    return ComunicadoInternoGrupoState(token: token, user: user, sol: sol);
  }
}

class ComunicadoInternoGrupoState extends State<ComunicadoInternoGrupo> {
  Token token;
  Usuario user;
  Solicitacao sol;

  ComunicadoInternoGrupoState({this.token ,this.user, this.sol});



  List _data;

  Future<void> fetchData() async {
    try {
      final response =
      await http.get("https://jsonplaceholder.typicode.com/todos");
      if (response.statusCode == 200) {
        print(response.body);
        setState(() {
          _data = jsonDecode(response.body) as List;
        });
      } else {
        print("Erro: ${response.statusCode}");
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  initState() {
    super.initState();
    fetchData();
  }

 bool toggle = true;

  @override
  Widget build(BuildContext context) {
    String title = 'Comunicado Interno Enviado para o Grupo TI';

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: LightColors.neonYellowLight,
        iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
        elevation: 0,
      ),
      body: Container(
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
        child: SafeArea(
          child: ListView(
                children: <Widget>[
                  Container(
                    height: 80.0,
                    width: double.infinity,
                    child: Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image(
                            image: AssetImage('images/logo-slim.png'),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Padding(
                    padding: const EdgeInsets.only(left: 30.0, top: 30.0, bottom: 20),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(title,
                          style: GoogleFonts.raleway (color: Colors.black87,
                              fontSize: 19.0, fontWeight: FontWeight.w700, letterSpacing: 0.7),),
                    ),
                  ),
                  SizedBox(
                    height: 10.0,
                  ),
                  Container(
                   // color: LightColors.neonETT,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Center(
                        child: toggle
                        ? Column(
                          children: <Widget>[
                            Container(
                              color: Colors.white,
                              alignment: Alignment.center,
                              child: _data != null
                                  ? JsonTable(
                                _data,
                                showColumnToggle: true,
                                paginationRowCount: 10,
                                allowRowHighlight: true,
                                rowHighlightColor: LightColors.neonETT.withOpacity(0.3),
                                tableHeaderBuilder: (_data){
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 8.0, vertical: 4.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(width: 0.5),
                                        color: LightColors.neonYellowLight),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _data,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.display1.copyWith(
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.0,
                                            color: Colors.black),
                                      ),
                                    ),);
                                },
                                tableCellBuilder: (_data) {
                                  return Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 4.0, vertical: 2.0),
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 0.5,
                                            color: Colors.grey.withOpacity(0.5))),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        _data,
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context).textTheme.display1.copyWith(
                                            fontSize: 14.0, color: Colors.black),
                                      ),
                                    ),
                                  );
                                },
                              )
                                  : _data,
                            ),
                          ],
                        ): _data,
                      ),
                    ),
                  ),
                  ],
              ),
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//          child: Icon(Icons.grid_on),
//          onPressed: () {
//            setState(
//                  () {
//                toggle = !toggle;
//              },
//            );
//          }),
    );
  }
}

String getPrettyJSONString(jsonObject) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String jsonString = encoder.convert(json.decode(jsonObject));
  return jsonString;
}
