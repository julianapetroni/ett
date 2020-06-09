import 'package:ett_app/screens/appBar.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter/services.dart';
import 'package:json_table/json_table.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';


class ComunicadoInternoGrupo extends StatefulWidget {

  Usuario user;

  ComunicadoInternoGrupo(
      {Key key,
        // this.value,
        this.user})
      : super(key: key);

  @override
  ComunicadoInternoGrupoState createState() {
    return ComunicadoInternoGrupoState(user: user);
  }
}

class ComunicadoInternoGrupoState extends State<ComunicadoInternoGrupo> {
  Usuario user;

  ComunicadoInternoGrupoState({this.user});



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
    String title = 'Comunicado Interno Enviados para o Grupo TI';

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBarETT(),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 30.0, top: 30.0),
                  child: Container(
                    child: Text(title,
                        style: TextStyle(
                            fontSize: 19.0,
                            color: Colors.grey[700],
                            fontFamily: "Poppins-Bold",
                            letterSpacing: .6)),
                  ),
                ),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Center(
                    child: toggle
                    ? Column(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: _data != null
                              ? JsonTable(
                            _data,
                            showColumnToggle: true,
                            paginationRowCount: 10,
                            allowRowHighlight: true,
                            rowHighlightColor: Colors.yellow[700].withOpacity(0.3),
                            tableHeaderBuilder: (_data){
                              return Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                    border: Border.all(width: 0.5),
                                    color: Colors.yellow[700]),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    _data,
                                    textAlign: TextAlign.center,
                                    style: Theme.of(context).textTheme.display1.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 14.0,
                                        color: Colors.black87),
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
                                        fontSize: 14.0, color: Colors.grey[900]),
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
                ],
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
