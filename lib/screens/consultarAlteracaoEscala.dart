import 'package:ett_app/screens/appBar.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/screens/status.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter/services.dart';
import 'package:json_table/json_table.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';


class ConsultarAlteracaoEscala extends StatefulWidget {

  Usuario user;

  ConsultarAlteracaoEscala(
      {Key key,
        // this.value,
        this.user})
      : super(key: key);

  @override
  ConsultarAlteracaoEscalaState createState() {
    return ConsultarAlteracaoEscalaState(user: user);
  }
}

class ConsultarAlteracaoEscalaState extends State<ConsultarAlteracaoEscala> {
  Usuario user;
  

  ConsultarAlteracaoEscalaState({this.user})
//  {_searchView.addListener((){
//      if(_searchView.text.isEmpty){
//          setState(() {
//            _firstSearch = true;
//            _query = "";
//          });
//      } else{
//          setState(() {
//            _firstSearch = false;
//            _query = _searchView.text;
//          });
//      }
//    });
//  }
  ;
  bool visibilityTableRow = true;

  void _changed() {
    setState(() {
      if(visibilityTableRow){
        visibilityTableRow = false;
      }else{
        visibilityTableRow = true;
      }
    });
  }

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

  var _searchView = new TextEditingController();
  bool _firstSearch = true;
  String _query = "";

  List<String> _filterList;

  @override
  initState() {
    super.initState();
    fetchData();
    controller.addListener(() {
      setState(() {
        filter = controller.text;
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  TextEditingController controller = new TextEditingController();
  String filter;

  List<String> _newData = [];

  _onChanged(String value) {
    setState(() {
      _newData = _data
          .where((string) => string.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }


  bool toggle = true;

  @override
  Widget build(BuildContext context) {

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBarETT(

      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 30.0, top: 30.0),
              child: Container(
                child: Text("Alteração de Escala - Consultar",
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
              padding: const EdgeInsets.only(left: 30.0, right: 30.0),
              child: TextFormField(
                decoration: InputDecoration(
                    labelText: 'Pesquisar'
                ),
                controller: controller,
                onChanged: _onChanged,
                onTap: _changed,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(left: 15.0, top: 10.0),
              child: //filter == null || filter == "" ?
              Center(
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
                          return
                            new Container(

                            padding: EdgeInsets.symmetric(
                                horizontal: 4.0, vertical: 2.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    width: 0.5,
                                    color: Colors.grey.withOpacity(0.5))),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: filter == null || filter == "" ?
                              new Text(
                                _data,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.display1.copyWith(
                                    fontSize: 14.0, color: Colors.grey[900]),
                              ): _data.contains(filter)?
                              new Text(
                                _data,
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.display1.copyWith(
                                    fontSize: 14.0, color: Colors.grey[900]),
                              ):  Visibility(visible: false, child: Container()),
                          ))
                          ;}
                      )
                          : _filterList,
                    )
                  ],
                ): _filterList,
              )
//              : _data.contains(filter)?
//              Center(
//                child: toggle
//                    ? Column(
//                  children: <Widget>[
//                    Container(
//                      alignment: Alignment.center,
//                      child: _data != null
//                          ? JsonTable(
//                          _data,
//                          showColumnToggle: true,
//                          paginationRowCount: 10,
//                          allowRowHighlight: true,
//                          rowHighlightColor: Colors.yellow[700].withOpacity(0.3),
//
//                          tableHeaderBuilder: (_data){
//                            return Container(
//                              padding: EdgeInsets.symmetric(
//                                  horizontal: 8.0, vertical: 4.0),
//                              decoration: BoxDecoration(
//                                  border: Border.all(width: 0.5),
//                                  color: Colors.yellow[700]),
//                              child: Padding(
//                                padding: const EdgeInsets.all(8.0),
//                                child: Text(
//                                  _data,
//                                  textAlign: TextAlign.center,
//                                  style: Theme.of(context).textTheme.display1.copyWith(
//                                      fontWeight: FontWeight.w700,
//                                      fontSize: 14.0,
//                                      color: Colors.black87),
//                                ),
//                              ),);
//                          },
//                          tableCellBuilder: (_data) {
//                            return
//                              new Container(
//                                  padding: EdgeInsets.symmetric(
//                                      horizontal: 4.0, vertical: 2.0),
//                                  decoration: BoxDecoration(
//                                      border: Border.all(
//                                          width: 0.5,
//                                          color: Colors.grey.withOpacity(0.5))),
//                                  child: Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: new Text(
//                                        _data,
//                                        textAlign: TextAlign.center,
//                                        style: Theme.of(context).textTheme.display1.copyWith(
//                                            fontSize: 14.0, color: Colors.grey[900]),
//                                      )
//                                  ))
//                            ;}
//                      )
//                          : _data,
//                    )
//                  ],
//                ): _data,
//              )
//                  :
//              Container(),
                //(child: Text(controller.text),),

            ),
          ],
        ),
      ),
    );
  }
}

String getPrettyJSONString(jsonObject) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String jsonString = encoder.convert(json.decode(jsonObject));
  return jsonString;
}