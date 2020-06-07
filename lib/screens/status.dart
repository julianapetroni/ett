import 'package:ett_app/style/topContainer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ett_app/domains/Usuario.dart';
import 'package:ett_app/domains/solicitacao.dart';
import 'appBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

import '../style/lightColors.dart';
import 'login.dart';

class Status extends StatefulWidget {

  Usuario user;
  Token token;
  //HoraAgendamento ha;
  final String text;
  final String cancelar; // cancelar agendamento
  //final String value; // instituição de ensino
  Solicitacao sol;

  Status({Key key, this.user, this.token, @required this.text, this.sol, this.cancelar})
      : assert(user.id != null),
        super(key: key);

  @override
  StatusState createState() {
    return StatusState(user: user, sol: sol, token: token);
  }
}

class StatusState extends State<Status> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();


  Token token;
  Usuario user;
  Solicitacao sol;
  StatusState({this.user, this.sol, this.token});


  @override
  void initState() {
    super.initState();
    _makeGetRequest();
//    _makeHoraDataRequest();
  }



  void printWrapped(String text) {
    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
    pattern.allMatches(text).forEach((match) => print(match.group(0)));
  }

  Future _makeGetRequest() async{

    String url = //'https://www.accio.com.br:447/api/v1/solicitacoes/cliente/' + user.id.toString() + '/status/ATIVO';

    'https://www.accio.com.br:447/api/v1/solicitacoes/cliente/' + user.id.toString() + '/solicitacao/andamento';
    await http
        .get(url,
        headers: {
          'Authorization':
          'bearer d16e3966-eb87-4337-bfee-bee54b5a4052'
        })
        .then((http.Response res) {
      print("Response statuss: ${res.statusCode}");
      //print(res.headers);
      print(user.email);
      print(user.id);

    });
  }


  @override
  Widget build(BuildContext context) {
    double a_width = MediaQuery.of(context).size.width*0.4;
    double b_width = MediaQuery.of(context).size.width*0.3;
    double title_width = MediaQuery.of(context).size.width*0.7;
    double title_height = MediaQuery.of(context).size.height*0.2;
    double width = MediaQuery.of(context).size.width;


    Future<Null> _refresh() {
      return _makeGetRequest().
      then((Solicitacao) {
        setState(() =>  sol = sol);
      });
    }

    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();


    return Scaffold(
        appBar: AppBar(
          backgroundColor: LightColors.kDarkYellow,
          elevation: 0.0,
          title: Row(
            children: <Widget>[
              Spacer(flex: 2),
              Container(
                  height: 45.0,
                  child: Image(image: AssetImage('images/logo-slim.png'))),
              Spacer(flex: 2),
              Container(child: Icon(Icons.person),),
              SizedBox(width: 5.0,),
            ],
          ),
        ),
        drawer: MyDrawer(user: user),
        backgroundColor: Colors.white,
        body:  SafeArea(
          child:

              Padding(
                padding: const EdgeInsets.only(left: 0),
                child: ListView(children: <Widget>[
                  TopContainer(
                    padding: EdgeInsets.only(left: 20, right: 20),
                    width: width,
                    child: Column(
                      children: <Widget>[
                        //MyBackButton(),
                        SizedBox(
                          height: 30,
                        ),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                              child: Text(
                                'Como estamos nas Metas?', textAlign: TextAlign.justify,
                                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                            //SizedBox(height: 10.0,),
                            Text(
                              '- Novembro/2019', textAlign: TextAlign.justify,
                              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                            SizedBox(height: 10.0,),
                          ],
                        ),
                        SizedBox(height: 20),
                        Container(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                //MyTextField(label: 'Title'),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: <Widget>[
//                                Expanded(
//                                  child: MyTextField(
//                                    label: 'Date',
//                                    icon: downwardIcon,
//                                  ),
//                                ),
//                                HomePage.calendarIcon(),
                                  ],
                                )
                              ],
                            ))
                      ],
                    ),
                  ),
                        SizedBox(height: 10.0,),
                        Container(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(8.0),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, 15.0),
                                    blurRadius: 15.0),
                                BoxShadow(
                                    color: Colors.black12,
                                    offset: Offset(0.0, -10.0),
                                    blurRadius: 10.0),
                              ]
                          ),
                          child: Column(
                            children: <Widget>[
//                          Container(
//                            width: double.infinity,
//                            //color: Colors.yellow[800],
//                            decoration: BoxDecoration(
//                              borderRadius: BorderRadius.circular(5.0),
//                              gradient: LinearGradient(
//                                colors: <Color>[
//                                  Colors.yellow[800],
//                                  Colors.yellow[700],
//                                  Colors.yellow[700],
//                                ],
//                              ),
//                            ),
//                            child: Column(
//                                  children: <Widget>[
//                                    Padding(
//                                      padding: const EdgeInsets.all(8.0),
//                                      child: Text(
//                                        'Como estamos nas Metas?', textAlign: TextAlign.justify,
//                                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
//                                      ),
//                                    ),
//                                    //SizedBox(height: 10.0,),
//                                    Text(
//                                      '- Novembro/2019', textAlign: TextAlign.justify,
//                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
//                                    ),
//                                    SizedBox(height: 10.0,),
//                                  ],
//                                ),
//                          ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: DataTable(
//                        sortColumnIndex: 0,
//                        sortAscending: true,
//                      columnSpacing: widget.columnSpacing,
//                      horizontalMargin: widget.horizontalMargin,
                                  dataRowHeight: 50.0,
                                  columns: [
                                    //DataColumn(label: Text(' '), numeric: true),
                                    DataColumn(label: Text('Meta', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[800]),)),
                                    DataColumn(label: Text('Realizado', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[800]),), numeric: true),
                                    DataColumn(label: Text('Status', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[800]),)),
                                  ],
                                  rows: [
                                    DataRow(
                                      //selected: true,
                                        cells: [
                                         // DataCell(Text('1')),
                                          DataCell(Text('Redução de Recolhe')),
                                          DataCell(Text('615')),
                                          DataCell(Icon(Icons.arrow_upward, color: Colors.greenAccent[400],)),
                                        ]),
                                    DataRow(cells: [
                                     // DataCell(Text('2')),
                                      DataCell(Text('Redução de Socorro')),
                                      DataCell(Text('255')),
                                      DataCell(Icon(Icons.arrow_upward, color: Colors.greenAccent[400],)),
                                    ]),
                                    DataRow(cells: [
                                      //DataCell(Text('3')),
                                      DataCell(Text('Almoxarifado')),
                                      DataCell(Text('99')),
                                      DataCell(Icon(Icons.arrow_upward, color: Colors.greenAccent[400],)),
                                    ]),
                                    DataRow(cells: [
                                      //DataCell(Text('4')),
                                      DataCell(Text('Acidentes')),
                                      DataCell(Text('488')),
                                      DataCell(Icon(Icons.arrow_downward, color: Colors.redAccent[400],)),
                                    ]),
                                    DataRow(cells: [
                                      //DataCell(Text('5')),
                                      DataCell(Text('Faltas')),
                                      DataCell(Text('318')),
                                      DataCell(Icon(Icons.arrow_downward, color: Colors.redAccent[400],)),
                                    ]),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 10.0,),
                        Container(
                          width: double.infinity,
                          height: 400,
                          decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0),
                          boxShadow: [
                            BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, 15.0),
                            blurRadius: 15.0),
                            BoxShadow(
                            color: Colors.black12,
                            offset: Offset(0.0, -10.0),
                            blurRadius: 10.0),
                            ]
                          ),
                          child: Column(
                            children: <Widget>[
                              Container(
                                color: LightColors.kPink,
                                width: double.infinity,
                                height: 40.0,
                                child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Icon(Icons.refresh, color: Colors.white,),
                              ), alignment: Alignment.topRight,),
                              SizedBox(height: 20.0,),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: Container(
                                  child: Text('Metas',
                                    style: TextStyle(color: Colors.grey[700], fontSize: 16.0, fontWeight: FontWeight.bold),),
                                    alignment: Alignment.topLeft,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                                child: Container(
                                  child: Text('Você sabe quais são as nossa metas? \nSegue abaixo para conhecimento', textAlign: TextAlign.justify,
                                    style: TextStyle(color: Colors.grey[700], fontSize: 14.0,),),
                                  alignment: Alignment.topLeft,
                                ),
                              ),

                              Padding(
                                padding: const EdgeInsets.only(left: 50.0, top: 15.0, bottom: 15.0),
                                child: Container(
                                  child: Column(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.done_outline, size: 15.0,),
                                            SizedBox(width: 10.0,),
                                            Text('Acidentes', textAlign: TextAlign.justify,
                                              style: TextStyle(color: Colors.grey[900], fontSize: 14.0,),),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.done_outline, size: 15.0,),
                                            SizedBox(width: 10.0,),
                                            Text('Recolhes', textAlign: TextAlign.justify,
                                              style: TextStyle(color: Colors.grey[900], fontSize: 14.0,),),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.done_outline, size: 15.0,),
                                            SizedBox(width: 10.0,),
                                            Text('SOS', textAlign: TextAlign.justify,
                                              style: TextStyle(color: Colors.grey[900], fontSize: 14.0,),),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.done_outline, size: 15.0,),
                                            SizedBox(width: 10.0,),
                                            Text('Absenteísmo', textAlign: TextAlign.justify,
                                              style: TextStyle(color: Colors.grey[900], fontSize: 14.0,),),
                                          ],
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Row(
                                          children: <Widget>[
                                            Icon(Icons.done_outline, size: 15.0,),
                                            SizedBox(width: 10.0,),
                                            Text('Atestados', textAlign: TextAlign.justify,
                                              style: TextStyle(color: Colors.grey[900], fontSize: 14.0,),),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  alignment: Alignment.topLeft,
                                ),
                              ),

                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                                  child: Container(
                                    child: Text('Mantenha seu cadastro na empresa sempre atualizado, isso nos ajuda a comunicar com você!',
                                      style: TextStyle(color: Colors.grey[700], fontSize: 14.0,),),
                                  ),
                                ),
                              ),

                              Flexible(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20.0, top: 10.0),
                                  child: Container(
                                    child: Text('Fique sempre atento ao seu WhatsApp. Caso troque de número, corra e comunique à empresa!',
                                      style: TextStyle(color: Colors.grey[700], fontSize: 14.0,),),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(height: 30.0,),
              ]),

//          Padding(
//            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
//            child: RefreshIndicator(
//              key: _refreshIndicatorKey,
//              onRefresh: _refresh,
//              child: Column(
//                children: <Widget>[
//
//                  Flexible(
//                      flex: 4,
//                      child: Container(
//                          alignment: Alignment.topCenter,
//                          child: ListView(
//                            padding: const EdgeInsets.only(top: 10.0, bottom: 20.0),
//                            children: <Widget>[
//
//
//
//                            ],
//                          ))),
//                  SizedBox(
//                    height: 20,
//                  ),
//                ],
//              ),
//            ),
//          ),
        ),



    ));
  }
}