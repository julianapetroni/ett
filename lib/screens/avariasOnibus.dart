import 'dart:async';
import 'dart:io';
import 'dart:convert';
import 'package:ett_app/screens/avariasVeiculoTerceiros.dart';
import 'package:ett_app/screens/relatorioOcorrenciaTransito.dart';
import 'package:ett_app/screens/testemunhas.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/screens/draw.dart';
import 'package:ett_app/screens/login.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../style/lightColors.dart';
import "package:flutter/painting.dart";
import "package:flutter/foundation.dart";
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:signature/signature.dart';

class AvariasOnibus extends StatefulWidget {
  Solicitacao sol;
  Usuario user;
  Token token;

  AvariasOnibus({Key key, this.sol, this.user, this.token}) : super(key: key);

  @override
  AvariasOnibusState createState() {
    return AvariasOnibusState(sol: sol, user: user, token: token);
  }
}

class AvariasOnibusState extends State<AvariasOnibus> {
  Solicitacao sol;
  Usuario user;
  Token token;

  AvariasOnibusState({this.sol, this.user, this.token});

  final GlobalKey<FormFieldState<String>> _nomeKey =
      GlobalKey<FormFieldState<String>>();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = true;

  //mensagem
  final _nomeController = TextEditingController();
  TextEditingController _textFieldController = TextEditingController();

  //Obs.
  final _obsController = TextEditingController();
  TextEditingController _obstextFieldController = TextEditingController();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //mensagem e obs.
  int _obscharCount = 700;

  _onChanged(String value) {
    setState(() {
      _obscharCount = 700 - value.length;
    });
  }

  //imagepicker
  File _image;
  final picker = ImagePicker();

  File _imageOnibusETTLateralEsquerda;
  final pickerOnibusETTLateralEsquerda = ImagePicker();

  File _imageOnibusETTLateralDireita;
  final pickerOnibusETTLateralDireita = ImagePicker();

  File _imageOnibusETTFrente;
  final pickerOnibusETTFrente = ImagePicker();

  File _imageOnibusETTTraseira;
  final pickerOnibusETTTraseira = ImagePicker();

  Future getImage(ImageSource src) async {
    File img = await ImagePicker.pickImage(
        source: src, maxHeight: 70.0, maxWidth: 70.0);
    //final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(img.path);
    });
  }

  Future getImageFrente(ImageSource src) async {
    File img = await ImagePicker.pickImage(
        source: src, maxHeight: 50.0, maxWidth: 50.0);
    //final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _imageOnibusETTFrente = File(img.path);
    });
  }

  Future getImageTraseira(ImageSource src) async {
    File img = await ImagePicker.pickImage(
        source: src, maxHeight: 50.0, maxWidth: 50.0);
    //final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _imageOnibusETTTraseira = File(img.path);
    });
  }

  Future getImageLatEsquerda(ImageSource src) async {
    File img = await ImagePicker.pickImage(
        source: src, maxHeight: 50.0, maxWidth: 50.0);
    //final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _imageOnibusETTLateralEsquerda = File(img.path);
    });
  }

  Future getImageLatDireita(ImageSource src) async {
    File img = await ImagePicker.pickImage(
        source: src, maxHeight: 50.0, maxWidth: 50.0);
    //final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _imageOnibusETTLateralDireita = File(img.path);
    });
  }

  //Mask
  var telController = new MaskedTextController(mask: '(00)00000-0000');
  var teltest1Controller = new MaskedTextController(mask: '(00)00000-0000');
  var teltest2Controller = new MaskedTextController(mask: '(00)00000-0000');
  var telac1Controller = new MaskedTextController(mask: '(00)00000-0000');
  var telac2Controller = new MaskedTextController(mask: '(00)00000-0000');
  var dataController = new MaskedTextController(mask: '00/00/0000');
  var data1Controller = new MaskedTextController(mask: '00/00/0000');
  var data2Controller = new MaskedTextController(mask: '00/00/0000');
  var dataVencimentoController = new MaskedTextController(mask: '00/00/0000');
  var rgTest1Controller = new MaskedTextController(mask: '00.000.000-0');
  var rgTest2Controller = new MaskedTextController(mask: '00.000.000-0');

  //assinatura
  final SignatureController _controller = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black87,
    exportBackgroundColor: Colors.blue,
  );

  final SignatureController _controllerTetst2 = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black87,
    exportBackgroundColor: Colors.blue,
  );

  final SignatureController _controllerTest1Conclusao = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black87,
    exportBackgroundColor: Colors.blue,
  );

  final SignatureController _controllerTest2Conclusao = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black87,
    exportBackgroundColor: Colors.blue,
  );

  @override
  dispose() {
    _nomeController.dispose();
    _obsController.dispose();

    super.dispose();
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

  bool toggle = true;

//tabela
  List<DataRow> _rowList = [
    DataRow(cells: <DataCell>[
      DataCell(
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
      DataCell(
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
      DataCell(
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
      DataCell(
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
      DataCell(
        TextFormField(
          decoration: InputDecoration(
            border: InputBorder.none,
          ),
        ),
      ),
    ]),
  ];

  void _addRow() {
    // Built in Flutter Method.
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below.
      _rowList.add(DataRow(cells: <DataCell>[
        DataCell(
          TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
//            focusedBorder: OutlineInputBorder(
//            borderSide: BorderSide(color: Colors.blue, width: 2.0),
//            borderRadius: BorderRadius.circular(25.7),
//          ),
//            enabledBorder: OutlineInputBorder(
//              borderSide: BorderSide(color: Colors.transparent, width: 2.0),
//              borderRadius: BorderRadius.circular(25.7),
//            ),
            ),
          ),
        ),
        DataCell(
          TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        DataCell(
          TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        DataCell(
          TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
        DataCell(
          TextFormField(
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ),
      ]));
    });
  }

  //testemunhas stepper
  int currentStep = 0;
  bool complete = false;
  bool incomplete = false;
  final _formStepperKey = new GlobalKey<FormState>();

  testemunha1() {
    if (incomplete == true) {
      Text(
        'Preencher os dados da Testemunha 1:',
        style: TextStyle(color: Colors.red),
      );
    }
  }

  goTo(int step) {
    setState(() {
      currentStep = currentStep + step;
    });
  }

  //botao de avaria do carro - mudança de cor
  bool segundoCarro = false;
  bool haAvariaNoCarro = false;

  //radio button para avaria no carro
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItem;
  // Group Value for Radio Button.
  int id;

  //CARRO 2
  String radioButton2Item = 'ONE';
  // Group Value for Radio Button.
  int id2 = 1;

  var botoes = new List<bool>.filled(26, false);

  //tabela conclusao

  //radio button para tabela conclusoes
  // Default Radio Button Selected Item When App Starts.
  String radioButtonItemBafometro = 'ONE';
  // Group Value for Radio Button.
  int idBafometro = 1;

  String radioButtonItemEstadoCivil = 'ONE';
  // Group Value for Radio Button.
  int idEstadoCivil = 1;

  var _isChecked = new List<bool>.filled(10, false);

  void onChanged(bool value) {
    setState(() {
      _isChecked[0] = value;
    });
  }

  void onChanged2(bool value) {
    setState(() {
      _isChecked[1] = value;
    });
  }

  void onChanged3(bool value) {
    setState(() {
      _isChecked[2] = value;
    });
  }

  void onChanged4(bool value) {
    setState(() {
      _isChecked[3] = value;
    });
  }

  void onChanged5(bool value) {
    setState(() {
      _isChecked[4] = value;
    });
  }

  void onChanged6(bool value) {
    setState(() {
      _isChecked[5] = value;
    });
  }

  void onChanged7(bool value) {
    setState(() {
      _isChecked[6] = value;
    });
  }

  void onChanged8(bool value) {
    setState(() {
      _isChecked[7] = value;
    });
  }

  void onChanged9(bool value) {
    setState(() {
      _isChecked[8] = value;
    });
  }

  void onChanged10(bool value) {
    setState(() {
      _isChecked[9] = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.7;
    bool textoVisivel = true;

    @override
    void initState() {
      super.initState();
      fetchData();
      _controller.addListener(() => print("Value changed"));
      _controllerTetst2.addListener(() => print("Value changed"));
      _controllerTest1Conclusao.addListener(() => print("Value changed"));
      _controllerTest2Conclusao.addListener(() => print("Value changed"));
    }

    SizeConfig().init(context);
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: LightColors.neonYellowLight,
          elevation: 0.0,
          title: Padding(
            padding: const EdgeInsets.only(
                top: 100, left: 80, right: 120, bottom: 100),
            child: Image.asset('images/logo-slim.png'),
          ),
          iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Container(
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
            child: ListView(children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 30.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Imagem ou Croqui do acidente:',
                      style: GoogleFonts.raleway(
                          color: Colors.black87,
                          fontSize: 17.0,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.7),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: halfMediaWidth,
                      decoration: new BoxDecoration(
                        shape: BoxShape.rectangle,
                        color: Colors.white.withOpacity(0.9),
                        borderRadius:
                            new BorderRadius.all(new Radius.circular(15.0)),
                      ),
                      //BoxDecoration(color: LightColors.neonETT),
                      child: new InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    Draw(user: user, token: token, sol: sol)),
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisSize: MainAxisSize.min,
                            verticalDirection: VerticalDirection.down,
                            children: <Widget>[
                              SizedBox(height: 50.0),
                              Center(
                                  child: Icon(
                                Icons.color_lens,
                                size: 40.0,
                                color: Colors.black87,
                              )),
                              SizedBox(height: 20.0),
                              new Flexible(
                                child: Center(
                                  child: new Text(
                                    'Croqui',
                                    textAlign: TextAlign.center,
                                    style: GoogleFonts.raleway(
                                        fontSize: 17),
//                        style: new TextStyle(
////                            fontSize: 13.0,
////                            color: Colors.black87,
////                            letterSpacing: 1
//
//                        )
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: halfMediaWidth,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white.withOpacity(0.9),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(15.0)),
                        ),
                        //BoxDecoration(color: LightColors.neonETT),
                        child: new InkWell(
                          onTap: () {
                            setState(() {
                              textoVisivel = false;
                            });
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text(
                                        "Selecionar imagem da galeria ou tirar foto?",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                      content: new Text(''),
                                      actions: <Widget>[
                                        new FlatButton(
                                          onPressed: () async {
                                            Navigator.pop(
                                                context); //close the dialog box
                                            getImage(ImageSource.gallery);
                                          },
                                          child: const Text(
                                            'Galeria',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ),
                                        new FlatButton(
                                          onPressed: () async {
                                            Navigator.pop(
                                                context); //close the dialog box
                                            getImage(
                                              ImageSource.camera,
                                            );
                                          },
                                          child: const Text(
                                            'Câmera',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ),
                                      ]);
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              verticalDirection: VerticalDirection.down,
                              children: <Widget>[
                                SizedBox(height: 50.0),
                                Center(
                                    child: Icon(
                                  Icons.add_a_photo,
                                  size: 40.0,
                                  color: Colors.black87,
                                )),
                                SizedBox(height: 20.0),
//                                    Visibility(
//                                      visible: textoVisivel,
//                                      child: new Flexible(
//                                        child: Center(
//                                          child: new Text('Foto do acidente',
//                                            textAlign: TextAlign.center,
//                                            style: GoogleFonts.raleway(fontSize: 17),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
                                Center(
                                  child: _image == null
                                      ? Flexible(
                                          child: Center(
                                            child: new Text(
                                              'Foto do acidente',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts
                                                  .raleway(
                                                      fontSize: 17),
                                            ),
                                          ),
                                        )
                                      : Image.file(_image),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 30.0, bottom: 10.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Avarias no ônibus da ETT:',
                    style: GoogleFonts.raleway(
                        color: Colors.black87,
                        fontSize: 17.0,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.7),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: halfMediaWidth,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white.withOpacity(0.9),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(15.0)),
                        ),
                        //BoxDecoration(color: LightColors.neonETT),
                        child: new InkWell(
                          onTap: () {
                            setState(() {
                              textoVisivel = false;
                            });
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text(
                                        "Selecionar imagem da galeria ou tirar foto?",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                      content: new Text(''),
                                      actions: <Widget>[
                                        new FlatButton(
                                          onPressed: () async {
                                            Navigator.pop(
                                                context); //close the dialog box
                                            getImageLatDireita(
                                                ImageSource.gallery);
                                          },
                                          child: const Text(
                                            'Galeria',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ),
                                        new FlatButton(
                                          onPressed: () async {
                                            Navigator.pop(
                                                context); //close the dialog box
                                            getImageLatDireita(
                                              ImageSource.camera,
                                            );
                                          },
                                          child: const Text(
                                            'Câmera',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ),
                                      ]);
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              verticalDirection: VerticalDirection.down,
                              children: <Widget>[
                                SizedBox(height: 50.0),
                                Center(
                                    child: Icon(
                                  Icons.add_a_photo,
                                  size: 40.0,
                                  color: Colors.black87,
                                )),
                                SizedBox(height: 20.0),
                                Center(
                                  child: _imageOnibusETTLateralDireita == null
                                      ? Flexible(
                                          child: Center(
                                            child: new Text(
                                              'Lateral Direita',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts
                                                  .raleway(
                                                      fontSize: 17),
                                            ),
                                          ),
                                        )
                                      : Image.file(
                                          _imageOnibusETTLateralDireita),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: halfMediaWidth,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white.withOpacity(0.9),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(15.0)),
                        ),
                        //BoxDecoration(color: LightColors.neonETT),
                        child: new InkWell(
                          onTap: () {
                            setState(() {
                              textoVisivel = false;
                            });
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text(
                                        "Selecionar imagem da galeria ou tirar foto?",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                      content: new Text(''),
                                      actions: <Widget>[
                                        new FlatButton(
                                          onPressed: () async {
                                            Navigator.pop(
                                                context); //close the dialog box
                                            getImageFrente(ImageSource.gallery);
                                          },
                                          child: const Text(
                                            'Galeria',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ),
                                        new FlatButton(
                                          onPressed: () async {
                                            Navigator.pop(
                                                context); //close the dialog box
                                            getImageFrente(
                                              ImageSource.camera,
                                            );
                                          },
                                          child: const Text(
                                            'Câmera',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ),
                                      ]);
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              verticalDirection: VerticalDirection.down,
                              children: <Widget>[
                                SizedBox(height: 50.0),
                                Center(
                                    child: Icon(
                                  Icons.add_a_photo,
                                  size: 40.0,
                                  color: Colors.black87,
                                )),
                                SizedBox(height: 20.0),
//                                    Visibility(
//                                      visible: textoVisivel,
//                                      child: new Flexible(
//                                        child: Center(
//                                          child: new Text('Foto do acidente',
//                                            textAlign: TextAlign.center,
//                                            style: GoogleFonts.raleway(fontSize: 17),
//                                          ),
//                                        ),
//                                      ),
//                                    ),
                                Center(
                                  child: _imageOnibusETTFrente == null
                                      ? Flexible(
                                          child: Center(
                                            child: new Text(
                                              'Frente',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts
                                                  .raleway(
                                                      fontSize: 17),
                                            ),
                                          ),
                                        )
                                      : Image.file(_imageOnibusETTFrente),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30, top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: halfMediaWidth,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white.withOpacity(0.9),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(15.0)),
                        ),
                        //BoxDecoration(color: LightColors.neonETT),
                        child: new InkWell(
                          onTap: () {
                            setState(() {
                              textoVisivel = false;
                            });
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text(
                                        "Selecionar imagem da galeria ou tirar foto?",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                      content: new Text(''),
                                      actions: <Widget>[
                                        new FlatButton(
                                          onPressed: () async {
                                            Navigator.pop(
                                                context); //close the dialog box
                                            getImageLatEsquerda(
                                                ImageSource.gallery);
                                          },
                                          child: const Text(
                                            'Galeria',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ),
                                        new FlatButton(
                                          onPressed: () async {
                                            Navigator.pop(
                                                context); //close the dialog box
                                            getImageLatEsquerda(
                                              ImageSource.camera,
                                            );
                                          },
                                          child: const Text(
                                            'Câmera',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ),
                                      ]);
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              verticalDirection: VerticalDirection.down,
                              children: <Widget>[
                                SizedBox(height: 50.0),
                                Center(
                                    child: Icon(
                                  Icons.add_a_photo,
                                  size: 40.0,
                                  color: Colors.black87,
                                )),
                                SizedBox(height: 20.0),
                                Center(
                                  child: _imageOnibusETTLateralEsquerda == null
                                      ? Flexible(
                                          child: Center(
                                            child: new Text(
                                              'Lateral Esquerda',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts
                                                  .raleway(
                                                      fontSize: 17),
                                            ),
                                          ),
                                        )
                                      : Image.file(
                                          _imageOnibusETTLateralEsquerda),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Container(
                        width: halfMediaWidth,
                        decoration: new BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white.withOpacity(0.9),
                          borderRadius:
                              new BorderRadius.all(new Radius.circular(15.0)),
                        ),
                        //BoxDecoration(color: LightColors.neonETT),
                        child: new InkWell(
                          onTap: () {
                            setState(() {
                              textoVisivel = false;
                            });
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                      title: Text(
                                        "Selecionar imagem da galeria ou tirar foto?",
                                        style:
                                            TextStyle(color: Colors.grey[600]),
                                      ),
                                      content: new Text(''),
                                      actions: <Widget>[
                                        new FlatButton(
                                          onPressed: () async {
                                            Navigator.pop(
                                                context); //close the dialog box
                                            getImageTraseira(
                                                ImageSource.gallery);
                                          },
                                          child: const Text(
                                            'Galeria',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ),
                                        new FlatButton(
                                          onPressed: () async {
                                            Navigator.pop(
                                                context); //close the dialog box
                                            getImageTraseira(
                                              ImageSource.camera,
                                            );
                                          },
                                          child: const Text(
                                            'Câmera',
                                            style: TextStyle(fontSize: 20.0),
                                          ),
                                        ),
                                      ]);
                                });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              mainAxisSize: MainAxisSize.min,
                              verticalDirection: VerticalDirection.down,
                              children: <Widget>[
                                SizedBox(height: 50.0),
                                Center(
                                    child: Icon(
                                  Icons.add_a_photo,
                                  size: 40.0,
                                  color: Colors.black87,
                                )),
                                SizedBox(height: 20.0),
                                Center(
                                  child: _imageOnibusETTTraseira == null
                                      ? Flexible(
                                          child: Center(
                                            child: new Text(
                                              'Lateral Esquerda',
                                              textAlign: TextAlign.center,
                                              style: GoogleFonts
                                                  .raleway(
                                                      fontSize: 17),
                                            ),
                                          ),
                                        )
                                      : Image.file(_imageOnibusETTTraseira),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Obs.:',
                        style: GoogleFonts.raleway(
                            color: Colors.black87,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.7)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 25.0),
                    child: TextField(
                      maxLines: 3,
                      controller: _textFieldController,
                      onChanged: _onChanged,
//                      inputFormatters: [
//                        LengthLimitingTextInputFormatter(700),
//                      ],
                    ),
                  ),
                  SizedBox(height: 20.0),
//                  Padding(
//                    padding: const EdgeInsets.only(left: 20.0),
//                    child: Text(
//                        _obscharCount.toString() + " caracteres restantes",
//                        style:
//                            TextStyle(color: Colors.grey[600], fontSize: 12.0)),
//                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 10, right: 10, top: 40, bottom: 40),
                child: FlatButton(
                  onPressed: () {
                    if (_imageOnibusETTLateralEsquerda != null &&
                        _imageOnibusETTTraseira != null &&
                        _imageOnibusETTLateralDireita != null &&
                        _imageOnibusETTFrente != null &&
                        _image != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AvariasVeiculoTerceiro(
                                  user: user,
                                  token: token,
                                  sol: sol,
                                )),
                      );
                    } else {
                      final semCadastro = new SnackBar(
                          content:
                              new Text('Insira as fotos para prosseguir!'));
                      _scaffoldKey.currentState.showSnackBar(semCadastro);
                    }
                  },
                  textColor: Colors.white,
                  child: Container(
                    width: double.infinity,
                    height: 45.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25.0),
                      gradient: LinearGradient(
                        colors: <Color>[
                          Colors.grey[600],
                          Colors.grey[500],
                          Colors.grey[300],
                        ],
                      ),
                    ),
                    //padding: const EdgeInsets.fromLTRB(90.0, 15.0, 90.0, 15.0),
                    child: Center(
                        child: const Text('PROSSEGUIR',
                            style: TextStyle(fontSize: 20))),
                  ),
                ),
              ),
            ]),
          ),
        ));
  }
}

String getPrettyJSONString(jsonObject) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String jsonString = encoder.convert(json.decode(jsonObject));
  return jsonString;
}
