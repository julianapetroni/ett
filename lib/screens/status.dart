import 'package:ett_app/screens/topContainerStatus.dart';
import 'package:ett_app/screens/metas.dart';
import 'package:ett_app/screens/tabelaStatus.dart';
import 'package:ett_app/style/topContainer.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:ett_app/domains/solicitacao.dart';
import 'appBar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';
import 'package:ett_app/screens/tabelaStatus.dart';
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
    //_makeGetRequest();
//    _makeHoraDataRequest();
  }



//  void printWrapped(String text) {
//    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
//    pattern.allMatches(text).forEach((match) => print(match.group(0)));
//  }

//  Future _makeGetRequest() async{
//
//    String url = //'https://www.accio.com.br:447/api/v1/solicitacoes/cliente/' + user.id.toString() + '/status/ATIVO';
//
//    'https://www.accio.com.br:447/api/v1/solicitacoes/cliente/' + user.id.toString() + '/solicitacao/andamento';
//    await http
//        .get(url,
//        headers: {
//          'Authorization':
//          'bearer d16e3966-eb87-4337-bfee-bee54b5a4052'
//        })
//        .then((http.Response res) {
//      print("Response statuss: ${res.statusCode}");
//      //print(res.headers);
//      print(user.email);
//      print(user.id);
//
//    });
//  }

  @override
  Widget build(BuildContext context) {

//    Future<Null> _refresh() {
//      return _makeGetRequest().
//      then((Solicitacao) {
//        setState(() =>  sol = sol);
//      });
//    }

    final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =
    new GlobalKey<RefreshIndicatorState>();

    return Scaffold(
        appBar: AppBarComLogoSlim(
        ),
        drawer: MyDrawer(user: user),
        backgroundColor: Colors.white,
        body:  SafeArea(
          child: Padding(
                padding: const EdgeInsets.only(left: 0),
                child: ListView(children: <Widget>[
                  TopContainerStatus(),
                  SizedBox(height: 10.0,),
                  TableStatus(),
                  SizedBox(height: 10.0,),
                  MetasStatus(),
                  Container(height: 30.0,),
              ]),
        ),
    ));
  }
}