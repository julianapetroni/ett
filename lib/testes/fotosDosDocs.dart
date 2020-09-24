//import 'dart:async';
//import 'dart:io';
//import 'dart:convert';
//import 'package:http/http.dart' as http;
//import 'package:flutter/material.dart';
//import 'package:image_picker/image_picker.dart';
//import 'package:flutter/cupertino.dart';
//import 'dart:typed_data';
//import 'dart:ui' as ui;
//import 'package:flutter/rendering.dart';
//import 'package:ett_app/domains/usuario.dart';
//import 'package:ett_app/domains/solicitacao.dart';
//import 'package:ett_app/screens/status.dart';
//import 'appBar.dart';
//import 'login.dart';
//
//class TirarFotosDocs extends StatefulWidget {
//  //final String value; // Instituição de ensino
//  Solicitacao sol;
//  Usuario user;
//  Token token;
//
//  TirarFotosDocs({
//    Key key,
//    //this.value,
//    this.sol,
//    this.user,
//    this.token
//  }) : super(key: key);
//
//  @override
//  TirarFotosDocsState createState() => new TirarFotosDocsState(sol: sol, user: user, token: token);
//}
//
//class TirarFotosDocsState extends State<TirarFotosDocs> {
//  final _scaffoldKey = GlobalKey<ScaffoldState>();
//
//  String textSucesso = 'Documentos enviados com sucesso!';
//  bool  alertSucessoVisible;
//
//  Solicitacao sol;
//  Usuario user;
//  Token token;
//
//  TirarFotosDocsState({this.sol, this.user, this.token});
//
//  //API
//  List<dynamic> _docs = [];
//  List<File> image;
//
////  //Base64
//  GlobalKey _globalKey = new GlobalKey();
////  //Uint8List imageInMemory;
//
//  Future<String> _capturePng(base64) async {
//    try {
//      RenderRepaintBoundary boundary =
//          _globalKey.currentContext.findRenderObject();
//      ui.Image image = await boundary.toImage(pixelRatio: 3.0);
//      ByteData byteData =
//          await image.toByteData(format: ui.ImageByteFormat.png);
//      var pngBytes = byteData.buffer.asUint8List();
//      var bs64 = base64Encode(pngBytes);
//      //print(pngBytes);
//      //print(bs64);
//      //setState(() {});
//      return bs64;
//    } catch (e) {
//      //print(e);
//    }
//  }
//
//  void printWrapped(String text) {
//    final pattern = new RegExp('.{1,800}'); // 800 is the size of each chunk
//    pattern.allMatches(text).forEach((match) => print(match.group(0)));
//  }
//
//  _makePostRequest() async {
//    // set up POST request arguments
//    String url =
//        'http://app.cartaopec.com.br/api/v1/solicitacoes';
////    print(sol.cpf);
////    print(sol.rg);
////    print(sol.comprovanteEndereco);
//
//    sol.status = 'ATIVO';
//    sol.statusSolicitacao = 'INICIADA';
//    Map<String, dynamic> map = sol.toJson();
//    String body = jsonEncode(map);
//    print(body);
//    print(sol.cliente.toString());
//
//    http
//        .post(url,
//        headers: {
//          'Content-Type':
//          'application/json',
//          'Authorization':
//          'bearer ' + token.access_token.toString()
//        }, body: body).then((response) {
//      print("Response status: ${response.statusCode}");
//      //print("Response body: ${response.contentLength}");
//      // print(response.headers);
//
//      print(response.body);
//      if (response.statusCode == 200) {
//        print("PASSOU");
//        showDialog(
//          context: context,
//          builder: (BuildContext context) {
//            // return object of type Dialog
//            return AlertDialog(
//              title: Center(
//                  child: new Icon(Icons.check_circle, size: 50.0, color: Colors.green,)),
//              content: new Text('Documentos enviados com sucesso!', style: TextStyle(
//                  fontSize: 16.0,
//                  color: Colors.grey[600],
//                  fontFamily: "Poppins-Bold",
//                  letterSpacing: .6),
//              ),
//              actions: <Widget>[
//                // usually buttons at the bottom of the dialog
//                new FlatButton(
//                  child: new Text(
//                    "Ok",
//                    style: TextStyle(
//                      fontSize: 18,
//                    ),
//                  ),
//                  onPressed: () {
//                    Navigator.of(context).pop();
//
//
//                  },
//                ),
//              ],
//            );
//          },
//        );
//        Future.delayed(const Duration(milliseconds: 3000), () {
//          //setState(() {
//            Navigator.push(
//              context,
//              MaterialPageRoute(builder: (context) => Status(
//                sol: sol,
//                user: user,
//                token: token
//                //textSucesso: textSucesso,
//                //alertSucessoVisible: alertSucessoVisible,
//
//              ),
//              ),
//            );
//          //});
//        });
//
//        Navigator.of(context).pushAndRemoveUntil(
//            MaterialPageRoute(builder: (context) => Status(sol: sol,
//              user: user, token: token)),
//                (Route<dynamic> route) => false);
//
//      } else {
//        print(" NAO PASSOU");
//        showDialog(
//            context: context,
//            builder:
//                (BuildContext context) {
//                  return AlertDialog(
//                    title: Center(
//                        child: new Icon(Icons.error, size: 50.0, color: Colors.red,)),
//                    content: new Text('Erro no envio! Tente novamente em alguns minutos!', style: TextStyle(
//                        fontSize: 16.0,
//                        color: Colors.grey[600],
//                        fontFamily: "Poppins-Bold",
//                        letterSpacing: .6),
//                    ),
//                    actions: <Widget>[
//                      // usually buttons at the bottom of the dialog
//                      new FlatButton(
//                        child: new Text(
//                          "Ok",
//                          style: TextStyle(
//                            fontSize: 18,
//                          ),
//                        ),
//                        onPressed: () {
//                          Navigator.of(context).pop();
//
//
//                        },
//                      ),
//                    ],
//                  );
//          });
//      }
//    });
//  }
//
//  @override
//  void initState() {
//    super.initState();
//    this._fetchDocs();
//  }
//
//  void _fetchDocs() async {
//    print(sol.tipoSolicitacao.id.toString()+ "ftodosdocs");
//    var res = await http.get(
//        "http://app.cartaopec.com.br//api/v1/documentos/tiposolicitacao/" +
//            sol.tipoSolicitacao.id.toString() +
//            "/status/ATIVO/?access_token=" + token.access_token.toString());
//
//    this.setState(() {
//      _docs = json.decode(res.body);
//      image = new List(_docs.length);
//    });
//  }
//
//
//
////  Future<String> get _localPath async {
////    final directory = await getApplicationDocumentsDirectory();
////    return directory.path;
////  }
////
////  Future<File> get _localFile async {
////    final path = await _localPath;
////    return File('$path/counter.txt');
////  }
//
//  //End API
//
//  @override
//  Widget build(BuildContext context) {
//    print('user');
//    print(user.email);
//    print('id');
//    print(user.id);
//    //print(_docs[1]);
//    //double c_width = MediaQuery.of(context).size.width * 0.8;
////    print('not widget');
////    print(sol.tipoSolicitacaoID);
//    bool blocked = false;
//    var d64;
//
//    return RepaintBoundary(
//      //key: _globalKey,
//      child: Scaffold(
//          key: _scaffoldKey,
//          appBar: appBar(
//            title: Text(' '),
//          ),
//          endDrawer: MyDrawer(user: user),
//          backgroundColor: Colors.white,
//          body: SafeArea(
//            child: Stack(
//              children: <Widget>[
//
//                Row(
//                  children: <Widget>[
//                    Spacer(
//                      flex: 1,
//                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(top: 20.0),
//                      child: Container(
//                          child: Image(
//                        image: AssetImage('images/logo-slim.png'),
//                        height: 100.0,
//                      )),
//                    ),
//                    Spacer(
//                      flex: 1,
//                    ),
//                  ],
//                ),
//                Padding(
//                    padding: const EdgeInsets.fromLTRB(20.0, 160.0, 20.0, 30.0),
//                    child: Text(
//                        'Insira as fotos dos documentos no local indicado. Após, pressione o botão "enviar".',
//                        textAlign: TextAlign.justify,
//                        style: TextStyle(
//                          color: Colors.grey[500],
//                          fontSize: 18.0,
//                        ))),
//                Padding(
//                  padding: const EdgeInsets.only(top: 230.0),
//                  child: ListView.builder(
//                      itemCount: _docs.length,
//                      itemBuilder: (context, index) {
//                        Future _getImage(ImageSource src) async {
//                          File img = await ImagePicker.pickImage(
//                              source: src, maxHeight: 100.0, maxWidth: 100.0);
//
//                          if (img != null) {
//                            setState(() {
//                              image[index] = img;
//                              Future<String> aux = _capturePng(image[index]);
//                              List<int> doc64 = img.readAsBytesSync();
//                              //d64 = doc64;
//                              //base64
//                              //var doc64 ;
//                              // String credentials = aux.toString();
////                              Codec<String, String> stringToBase64 =
////                                  utf8.fuse(base64);
//                              String encoded = base64Encode(doc64);
//
//                              if(_docs[index]['codigo'] == 'CDCPF') {
//                                sol.cpf = 'data:image/jpeg;base64,' + encoded;
//                              }
//                              else if(_docs[index]['codigo'] == 'CDRG')
//                                sol.rg = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDEND')
//                                sol.comprovanteEndereco = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDDECESC')
//                                sol.declaracaoEscolar = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDDECRP1')
//                                sol.declaracaoRenda1 = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDDECRP2')
//                                sol.declaracaoRenda2 = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDDECRP3')
//                                sol.declaracaoRenda3 = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDDECRP4')
//                                sol.declaracaoRenda4 = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDCOMPBF1')
//                                sol.comprovanteBolsistaFiesPagina1 = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDCOMPBF2')
//                                sol.comprovanteBolsistaFiesPagina2 = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDCOMPBF3')
//                                sol.comprovanteBolsistaFiesPagina3 = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDCOMPBP1')
//                                sol.comprovanteBolsistaProuniPagina1 = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDCOMPBP2')
//                                sol.comprovanteBolsistaProuniPagina2 = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDCOMPBP3')
//                                sol.comprovanteBolsistaProuniPagina3 = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDREV')
//                                sol.comprovanteRevalidacao = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDFREQ')
//                                sol.fichaFrequencia = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDNRCART')
//                                sol.numeroCartao = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDDECMED')
//                                sol.declaracaoMedica = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDDECMED1')
//                                sol.declaracaoMedica1 = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDDECMED2')
//                                sol.declaracaoMedica2 = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDDECMED3')
//                                sol.declaracaoMedica3 = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDLDMED')
//                                sol.laudoMedicoOrgaoPublico = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDSUSF')
//                                sol.cartaoSusFrente = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDSUSV')
//                                sol.cartaoSusVerso = 'data:image/jpeg;base64,' + encoded;
//                              else if(_docs[index]['codigo'] == 'CDRGAC')
//                                sol.rgAcompanhante = 'data:image/jpeg;base64,' + encoded;
//                              //print(img);
//                               //print(doc64);
////                              //(credentials);
////                              debugPrint(encoded,
//////                                  wrapWidth: 1024);
//                              //
//                              ////printWrapped(encoded);
//                             // printWrapped();
//                              // dXNlcm5hbWU6cGFzc3dvcmQ=
//                              //String decoded = stringToBase64.decode(encoded);
//                              //print(decoded);
//
////                              List<int> imageBytes = img.readAsBytesSync();
////                              //print(imageBytes);
////                              String base64Image = base64Encode(imageBytes);
////                              print('string is');
////                              printWrapped(base64Image);
////                              print("You selected gallery image : " + img.path);
//
//                            });
//                          }
////                          final file = await _localFile;
////
////                          // Write the file.
////                          file.writeAsString('$d64');
//                        }
//
//                        return Padding(
//                          padding:
//                              const EdgeInsets.only(left: 20.0, right: 20.0),
//                          child: Stack(
//                            children: <Widget>[
//                              Align(
//                                alignment: Alignment.topLeft,
//                                child: Container(
//                                    width: 30.0,
//                                    height: 30.0,
//                                    decoration: BoxDecoration(
//                                      borderRadius: BorderRadius.circular(50.0),
//                                      border: Border.all(
//                                          width: 10.0, color: Colors.grey),
//                                    )),
//                              ),
//                              Padding(
//                                padding: EdgeInsets.only(left: 50.0),
//                                child: Container(
//                                  child: Text(
//                                      _docs[index]['nome'].toUpperCase(),
//                                      style: TextStyle(
//                                          color: Colors.grey,
//                                          fontWeight: FontWeight.bold)),
//                                ),
//                              ),
//                              Padding(
//                                padding: EdgeInsets.only(left: 3.0, top: 30.0),
//                                child: Container(
//                                  height: 130.0,
//                                  width: 3.0,
//                                  color: Colors.grey,
//                                  margin:
//                                      EdgeInsets.only(left: 10.0, right: 10.0),
//                                ),
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.only(
//                                    left: 40.0, top: 30.0, bottom: 15.0),
//                                child: Container(
//                                  //color: Colors.grey[50],
//                                  child: ListTile(
//                                    title: Row(
//                                      children: <Widget>[
//                                        SizedBox(
//                                          width: 50.0,
//                                        ),
//                                        Center(
//                                          child: FlatButton(
//                                            onPressed: () {
//                                              //setState(() {});
//                                              showDialog(
//                                                  context: context,
//                                                  builder:
//                                                      (BuildContext context) {
//                                                    return AlertDialog(
//                                                        title: Text(
//                                                          "Selecionar imagem da galeria ou tirar foto?",
//                                                          style: TextStyle(
//                                                              color: Colors
//                                                                  .grey[600]),
//                                                        ),
//                                                        content: new Text(''),
//                                                        actions: <Widget>[
//                                                          new FlatButton(
//                                                            onPressed:
//                                                                () async {
//                                                              Navigator.pop(
//                                                                  context); //close the dialog box
//                                                              _getImage(
//                                                                  ImageSource
//                                                                      .gallery);
//                                                            },
//                                                            child: const Text(
//                                                              'Galeria',
//                                                              style: TextStyle(
//                                                                  fontSize:
//                                                                      20.0),
//                                                            ),
//                                                          ),
//                                                          new FlatButton(
//                                                            onPressed:
//                                                                () async {
//                                                              Navigator.pop(
//                                                                  context); //close the dialog box
//                                                              _getImage(
//                                                                ImageSource
//                                                                    .camera,
//                                                              );
//                                                            },
//                                                            child: const Text(
//                                                              'Câmera',
//                                                              style: TextStyle(
//                                                                  fontSize:
//                                                                      20.0),
//                                                            ),
//                                                          ),
//                                                        ]);
//                                                  });
//                                            },
//                                            child: Padding(
//                                              padding: const EdgeInsets.only(
//                                                  top: 30.0, bottom: 20.0),
//                                              child: Center(
//                                                child: IconButton(
//                                                    icon: Icon(
//                                                  Icons.add_a_photo,
//                                                  color: Colors.blue[600],
//                                                  size: 40.0,
//                                                )),
//                                              ),
//                                            ),
//                                          ),
//                                        ),
//                                        Spacer(),
//                                        if (image[index] != null)
//                                          Image.file(image[index])
//                                        else
//                                          Text(""),
//                                      ],
//                                    ),
//                                  ),
//                                ),
//                              ),
//                            ],
//                          ),
//                        );
//                      }),
//                )
//              ],
//            ),
//          ),
//          bottomNavigationBar: Padding(
//            padding: const EdgeInsets.fromLTRB(8.0, 8.0, 8.0, 35.0),
//            child: new InkWell(
//              onTap: () async {
//
//                for (var i = 0; i < _docs.length; i++) {
//                  if (_docs[i]['nome'].toString().contains('2') == false &&
//                      _docs[i]['nome'].toString().contains('3') == false &&
//                      _docs[i]['nome'].toString().contains('4') == false) {
//                    if (image[i] == null) {
//                      blocked = true; // sem imagem
//                      break;
//                    }
//                  }
//                }
//                if (blocked == false) {
//                  print(sol.tipoSolicitacao.id);
//
//
//                  //mudar a visibilidade do Container no Status para true
//                  alertSucessoVisible = true;
//
//
//
//                  _makePostRequest();
//
//                } else {
//                  showDialog(
//                    context: context,
//                    builder: (BuildContext context) {
//                      // return object of type Dialog
//                      return AlertDialog(
//                        title: Center(
//                            child: new Text(
//                          "Atenção!",
//                          textAlign: TextAlign.center,
//                        )),
//                        content: new Text(
//                          "Insira as imagens de todos os documentos para prosseguir!",
//                          textAlign: TextAlign.center,
//                        ),
//                        actions: <Widget>[
//                          // usually buttons at the bottom of the dialog
//                          new FlatButton(
//                            child: new Text(
//                              "Ok",
//                              style: TextStyle(
//                                fontSize: 18,
//                              ),
//                            ),
//                            onPressed: () {
//                              Navigator.of(context).pop();
//
//
//                            },
//                          ),
//                        ],
//                      );
//                    },
//                  );
//                }
//              },
//              child: new Container(
//                width: double.infinity,
//                height: 50.0,
//                decoration: new BoxDecoration(
//                  borderRadius: BorderRadius.circular(15.0),
//                  gradient: LinearGradient(
//                    colors: <Color>[
//                      Color(0xFF33691E),
//                      Color(0xFF689F38),
//                      Color(0xFF8BC34A),
//                    ],
//                  ),
//                ),
//                child: new Center(
//                  child: Row(
//                    children: <Widget>[
//                      Spacer(
//                        flex: 3,
//                      ),
//                      const Text('ENVIAR',
//                          style: TextStyle(fontSize: 20, color: Colors.white)),
//                      Spacer(
//                        flex: 3,
//                      ),
//                      Icon(Icons.chevron_right, color: Colors.white),
//                    ],
//                  ),
//                ),
//              ),
//            ),
//          )),
//    );
//  }
//}
