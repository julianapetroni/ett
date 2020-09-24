
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:ett_app/services/token.dart';


makePostRequest (user, password, scaffoldKey, emailController, passwordController) async {
  // set up POST request arguments
  String url =
      'https://www.accio.com.br:447/api/uaa/oauth/token?username=$user&password=$password&grant_type=password';
  var body;
  http
      .post(url,
      headers: {
        'Content-Type':
        'application/x-www-form-urlencoded; charset=utf-8',
        'Authorization':
        'Basic YWV0dXItYXBwLWNsaWVudDphZXR1ci1hcHAtc2VjcmV0'
      },
      body: body)
      .then((http.Response response) {
//      print("Response status: ${response.statusCode}");
//      print(response.body);
    if (response.statusCode == 200) {
      Map<String, dynamic> map = jsonDecode(response.body);
      Token token = Token.fromJson(map);
//        print(token.access_token);
      String url2 = 'https://www.accio.com.br:447/api/v1/usuarios/userinfo';
      http.get(url2, headers: {
        'Authorization': 'bearer ' + token.access_token.toString()
      }).then((res) {
        Map<String, dynamic> map2 = jsonDecode(res.body);

        Usuario usuario = Usuario.fromJson(map2);

        print("ID: " + usuario.id.toString());



//        Navigator.push(
//          context,
//          MaterialPageRoute(
//              builder: (context) =>
//                  DashboardScreen(user: usuario, token: token)),
//        );
//        Navigator.of(context).pushAndRemoveUntil(
//            MaterialPageRoute(
//                builder: (context) =>
//                    DashboardScreen(user: usuario, token: token)),
//                (Route<dynamic> route) => false);
      });
    } else {
      final semCadastro =
      new SnackBar(content: new Text('Erro na autenticação!'));
      scaffoldKey.currentState.showSnackBar(semCadastro);
    }
  });
}