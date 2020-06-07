import 'dart:async';
import 'dart:io';
import 'dart:convert';
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
import 'package:ett_app/screens/status.dart';
import 'package:ett_app/domains/Usuario.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../style/lightColors.dart';
import '../style/topContainer.dart';
import 'package:multiselect_formfield/multiselect_formfield.dart';
import "package:flutter/painting.dart";
import "package:flutter/foundation.dart";
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:signature/signature.dart';

class RelatorioOcorrenciaTransito extends StatefulWidget {
  Solicitacao sol;
  Usuario user;
  Token token;

  RelatorioOcorrenciaTransito({Key key, this.sol, this.user, this.token})
      : super(key: key);

  @override
  RelatorioOcorrenciaTransitoState createState() {
    return RelatorioOcorrenciaTransitoState(sol: sol, user: user, token: token);
  }
}

class RelatorioOcorrenciaTransitoState
    extends State<RelatorioOcorrenciaTransito> {
  Solicitacao sol;
  Usuario user;
  Token token;

  RelatorioOcorrenciaTransitoState({this.sol, this.user, this.token});

  final GlobalKey<FormFieldState<String>> _nomeKey =
      GlobalKey<FormFieldState<String>>();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = false;

  //mensagem
  final _nomeController = TextEditingController();
  TextEditingController _textFieldController = TextEditingController();

  //Obs.
  final _obsController = TextEditingController();
  TextEditingController _obstextFieldController = TextEditingController();


  //dropDownButton carro com avaria
  String _dropDownCarroAvaria;
  String _dropDownCarroAvariaResult;
  final formdropDownCarroAvariaKey = new GlobalKey<FormState>();

  //dropDownButton carro com avaria
  String _dropDownCarro2Avaria;
  String _dropDownCarro2AvariaResult;
  final formdropDownCarro2AvariaKey = new GlobalKey<FormState>();

  String _dropDownMarcaCarroAvaria;
  String _dropDownMarcaCarroAvariaResult;
  final formdropDownMarcaCarroAvariaKey = new GlobalKey<FormState>();

  String _dropDownMarcaCarro2Avaria;
  String _dropDownMarcaCarro2AvariaResult;
  final formdropDownMarcaCarro2AvariaKey = new GlobalKey<FormState>();

//  _saveForm() {
//    var form = formdropDownCarroAvariaKey.currentState;
//    if (form.validate()) {
//      form.save();
//      setState(() {
//        _dropDownCarroAvariaResult = _dropDownCarroAvaria;
//      });
//    }
//  }

  //mensagem e obs.
  int _charCount = 700;
  int _obscharCount = 700;

  _onChanged(String value) {
    setState(() {
      _charCount = 700 - value.length;
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
    penColor: Colors.black,
    exportBackgroundColor: Colors.blue,
  );

  final SignatureController _controllerTetst2 = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.blue,
  );

  final SignatureController _controllerTest1Conclusao = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
    exportBackgroundColor: Colors.blue,
  );

  final SignatureController _controllerTest2Conclusao = SignatureController(
    penStrokeWidth: 5,
    penColor: Colors.black,
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
    });}
  void onChanged2(bool value) {
    setState(() {
      _isChecked[1] = value;
    });}
  void onChanged3(bool value) {
    setState(() {
      _isChecked[2] = value;
    });}
  void onChanged4(bool value) {
    setState(() {
      _isChecked[3] = value;
    });}
  void onChanged5(bool value) {
    setState(() {
      _isChecked[4] = value;
    });}
  void onChanged6(bool value) {
    setState(() {
      _isChecked[5] = value;
    });}
  void onChanged7(bool value) {
    setState(() {
      _isChecked[6] = value;
    });}
  void onChanged8(bool value) {
    setState(() {
      _isChecked[7] = value;
    });}
  void onChanged9(bool value) {
    setState(() {
      _isChecked[8] = value;
    });}
  void onChanged10(bool value) {
    setState(() {
      _isChecked[9] = value;
    });}

  @override
  Widget build(BuildContext context) {

    double width = MediaQuery.of(context).size.width;
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.5;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM').format(now);
    String formattedTime = DateFormat('kk:mm:ss').format(now);

    //selecaomultipla com tag
    List _myActivities;
    String _myActivitiesResult;
    final formKey = new GlobalKey<FormState>();

    _saveForm() {
      var form = formKey.currentState;
      if (form.validate()) {
        form.save();
        setState(() {
          _myActivitiesResult = _myActivities.toString();
        });
      }
    }

    @override
    void initState() {
      super.initState();
      fetchData();
      _myActivities = [];
      _myActivitiesResult = '';
      _dropDownCarroAvaria = ' ';
      _dropDownCarroAvariaResult = ' ';
      _dropDownCarro2Avaria = ' ';
      _dropDownCarro2AvariaResult = ' ';
      _dropDownMarcaCarroAvaria = ' ';
      _dropDownMarcaCarroAvariaResult = ' ';
      _dropDownMarcaCarro2Avaria = ' ';
      _dropDownMarcaCarro2AvariaResult = ' ';
      _controller.addListener(() => print("Value changed"));
      _controllerTetst2.addListener(() => print("Value changed"));
      _controllerTest1Conclusao.addListener(() => print("Value changed"));
      _controllerTest2Conclusao.addListener(() => print("Value changed"));
    }

    SizeConfig().init(context);
    return MaterialApp(
        theme: ThemeData(
          // primaryTextTheme: Typography(platform: TargetPlatform.iOS).white,
          textTheme: TextTheme(
            title: TextStyle(
              fontFamily: "stonehenge",
              fontWeight: FontWeight.bold,
              fontSize: 16.0,
            ),
            //título
            body1: Theme.of(context).textTheme.body1.merge(
                  const TextStyle(
                    color: Colors.black,
                  ),
                ),
            //Letra dentro das tags
            body2: const TextStyle(
              fontSize: 14,
            ),
          ),
          primaryColor: LightColors.kDarkYellow,
          primarySwatch: Colors.orange,
          accentColor: Colors.amber,
          accentColorBrightness: Brightness.dark,
          fontFamily: 'Roboto',
          canvasColor: LightColors.kLightYellow,
          scaffoldBackgroundColor: LightColors.kLightYellow2,
          hintColor: Colors.grey[600],
          hoverColor: Colors.amber,
          splashColor: LightColors.kDarkYellow,
          dividerColor: LightColors.kLightYellow2,
        ),
        home: Scaffold(
            appBar: AppBar(
              backgroundColor: LightColors.kDarkYellow,
              elevation: 0.0,
              leading: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Status(
                              user: user,
                              token: token,
                              sol: sol,
                            )),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Icon(
                      Icons.arrow_back_ios,
                      size: 25,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: SafeArea(
              child: ListView(children: <Widget>[
                TopContainer(
                  padding:
                      EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0),
                  width: width,
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 30,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Flexible(
                            child: Text(
                              'Relatório de Ocorrência de Trânsito',
                              style: TextStyle(
                                  fontSize: 19.0, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
                      Container(
                        child: Container(
                          child: Padding(
                            padding:
                                const EdgeInsets.only(bottom: 10.0, top: 10.0),
                            child: Column(
                              children: <Widget>[
                                //Data e Hora
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Container(
                                          //alignment: Alignment.topCenter,
                                          width: halfMediaWidth,
                                          child: TextFormField(
                                            controller: TextEditingController(
                                                text: formattedDate),
                                            decoration: InputDecoration(
                                              labelText: 'Data',
                                              labelStyle: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.grey[600]),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[600],
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[300],
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                            ),
//                    key: _nomeKey,
//                    controller: TextEditingController(text: '${user.nome}'),
//                    validator: composeValidators('nome',
//                        [requiredValidator, stringValidator]),
                                            //                   onSaved: (value) => _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                          ),
                                        ),
                                      ),
                                      //SizedBox(width: 5.0,),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Container(
                                            alignment: Alignment.topCenter,
                                            width: halfMediaWidth,
                                            child: TextFormField(
                                              controller: TextEditingController(
                                                  text: formattedTime),
                                              decoration: InputDecoration(
                                                labelText: 'Hora',
                                                labelStyle: TextStyle(
                                                    fontSize: 13.0,
                                                    color: Colors.grey[600]),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey[600],
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey[300],
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
//                    key: _nomeKey,
//                    controller: TextEditingController(text: '${user.nome}'),
//                    validator: composeValidators('nome',
//                        [requiredValidator, stringValidator]),
                                              //                   onSaved: (value) => _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Prefixo e Placa
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Container(
                                          //alignment: Alignment.topCenter,
                                          width: halfMediaWidth,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Prefixo',
                                              labelStyle: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.grey[600]),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[600],
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[300],
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                            ),
//                    key: _nomeKey,
//                    controller: TextEditingController(text: '${user.nome}'),
//                    validator: composeValidators('nome',
//                        [requiredValidator, stringValidator]),
                                            //                   onSaved: (value) => _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                          ),
                                        ),
                                      ),
                                      //SizedBox(width: 5.0,),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Container(
                                            alignment: Alignment.topCenter,
                                            width: halfMediaWidth,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: 'Placa',
                                                labelStyle: TextStyle(
                                                    fontSize: 13.0,
                                                    color: Colors.grey[600]),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey[600],
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey[300],
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
//                    key: _nomeKey,
//                    controller: TextEditingController(text: '${user.nome}'),
//                    validator: composeValidators('nome',
//                        [requiredValidator, stringValidator]),
                                              //                   onSaved: (value) => _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Linha e Sentido
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 8.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: Container(
                                          //alignment: Alignment.topCenter,
                                          width: halfMediaWidth,
                                          child: TextFormField(
                                            decoration: InputDecoration(
                                              labelText: 'Linha',
                                              labelStyle: TextStyle(
                                                  fontSize: 13.0,
                                                  color: Colors.grey[600]),
                                              focusedBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[600],
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                              enabledBorder: OutlineInputBorder(
                                                borderSide: BorderSide(
                                                    color: Colors.grey[300],
                                                    width: 2.0),
                                                borderRadius:
                                                    BorderRadius.circular(5.0),
                                              ),
                                            ),
//                    key: _nomeKey,
//                    controller: TextEditingController(text: '${user.nome}'),
//                    validator: composeValidators('nome',
//                        [requiredValidator, stringValidator]),
                                            //                   onSaved: (value) => _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                          ),
                                        ),
                                      ),
                                      //SizedBox(width: 5.0,),
                                      Flexible(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 8.0, right: 8.0),
                                          child: Container(
                                            alignment: Alignment.topCenter,
                                            width: halfMediaWidth,
                                            child: TextFormField(
                                              decoration: InputDecoration(
                                                labelText: 'Sentido',
                                                labelStyle: TextStyle(
                                                    fontSize: 13.0,
                                                    color: Colors.grey[600]),
                                                focusedBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey[600],
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                                enabledBorder:
                                                    OutlineInputBorder(
                                                  borderSide: BorderSide(
                                                      color: Colors.grey[300],
                                                      width: 2.0),
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          5.0),
                                                ),
                                              ),
//                    key: _nomeKey,
//                    controller: TextEditingController(text: '${user.nome}'),
//                    validator: composeValidators('nome',
//                        [requiredValidator, stringValidator]),
                                              //                   onSaved: (value) => _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Local do acidente
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 20.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: TextFormField(
                                          //controller: TextEditingController(text: ''),
                                          decoration: InputDecoration(
                                            labelText: 'Local do acidente',
                                            labelStyle: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey[600]),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[600],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          // key: _motoristaKey,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                          validator: composeValidators(
                                              'endereço', [
                                            requiredValidator,
                                            stringValidator
                                          ]),
                                          //onSaved: (value) => _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Altura/Próximo a
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 20.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: TextFormField(
                                          //controller: TextEditingController(text: '${user.nome}'),
                                          decoration: InputDecoration(
                                            labelText: 'Altura \/ Próximo a ',
                                            labelStyle: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey[600]),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[600],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          // key: _motoristaKey,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                          validator: composeValidators('nome', [
                                            requiredValidator,
                                            stringValidator
                                          ]),
                                          //onSaved: (value) => _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Motorista
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 20.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: TextFormField(
                                          //controller: TextEditingController(text: '${user.nome}'),
                                          decoration: InputDecoration(
                                            labelText: 'Motorista',
                                            labelStyle: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey[600]),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[600],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          //key: _motoristaKey,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                          validator: composeValidators('nome', [
                                            requiredValidator,
                                            stringValidator
                                          ]),
                                          onSaved: (value) =>
                                              _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Matricula
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 20.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        // alignment: Alignment.topCenter,
                                        //width: width,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Matrícula',
                                            labelStyle: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey[600]),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[600],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
//                    key: _nomeKey,
//                    controller: TextEditingController(text: '${user.nome}'),
//                    validator: composeValidators('nome',
//                        [requiredValidator, stringValidator]),
                                          //                   onSaved: (value) => _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                      //SizedBox(width: 3.0,),
                                    ],
                                  ),
                                ),
                                //Cobrador
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 20.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        child: TextFormField(
                                          //controller: TextEditingController(text: '${user.nome}'),
                                          decoration: InputDecoration(
                                            labelText: 'Cobrador',
                                            labelStyle: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey[600]),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[600],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
                                          //key: _cobradorKey,
//                                  controller: TextEditingController(
//                                      text: '${user.nome}'),
                                          validator: composeValidators('nome', [
                                            requiredValidator,
                                            stringValidator
                                          ]),
                                          onSaved: (value) =>
                                              _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                //Matricula
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 8.0, right: 20.0, top: 8.0),
                                  child: Row(
                                    children: <Widget>[
                                      Flexible(
                                        // alignment: Alignment.topCenter,
                                        //width: width,
                                        child: TextFormField(
                                          decoration: InputDecoration(
                                            labelText: 'Matrícula',
                                            labelStyle: TextStyle(
                                                fontSize: 13.0,
                                                color: Colors.grey[600]),
                                            focusedBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[600],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                            enabledBorder: OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: Colors.grey[300],
                                                  width: 2.0),
                                              borderRadius:
                                                  BorderRadius.circular(5.0),
                                            ),
                                          ),
//                    key: _nomeKey,
//                    controller: TextEditingController(text: '${user.nome}'),
//                    validator: composeValidators('nome',
//                        [requiredValidator, stringValidator]),
                                          //                   onSaved: (value) => _loginData.nome = value,
//                                        decoration: InputDecoration(hintText: '${user.nome}'),
                                        ),
                                      ),
                                      //SizedBox(width: 3.0,),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),

                SizedBox(
                  height: 20.0,
                ),

//selecaomultipla com tag

                Form(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16),
                        child: MultiSelectFormField(
                          fillColor: LightColors.kLightYellow,
                          autovalidate: false,

                          titleText: 'Tipo de Ocorrência',
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return 'Escolha uma ou mais opções';
                            }
                          },
                          dataSource: [
                            {
                              "display": "Albarroamento",
                              "value": "Albarroamento",
                            },
                            {
                              "display": "Atropelamento",
                              "value": "Atropelamento",
                            },
                            {
                              "display": "Choque",
                              "value": "Choque",
                            },
                            {
                              "display": "Colisão Frontal",
                              "value": "Colisão Frontal",
                            },
                            {
                              "display": "Colisão Lateral",
                              "value": "Colisão Lateral",
                            },
                            {
                              "display": "Colisão Traseira",
                              "value": "Colisão Traseira",
                            },
                            {
                              "display": "Engavetamento",
                              "value": "Engavetamento",
                            },
                            {
                              "display": "Roubo ou Assalto",
                              "value": "Roubo ou Assalto",
                            },
                            {
                              "display": "Tombamento",
                              "value": "Tombamento",
                            },
                            {
                              "display": "Vandalismo",
                              "value": "Vandalismo",
                            },
                          ],

                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCELAR',
                          required: true,
                          hintText: 'Escolha uma ou mais opções',
                          border: InputBorder.none,
                          //value: _myActivities,

                          onSaved: (value) {
                            if (value == null) return;
                            setState(() {
                              _myActivities = value;
                            });
                          },
                        ),
                      ),
//                    Container(
//                      padding: EdgeInsets.all(8),
//                      child: RaisedButton(
//                        child: Text('Save'),
//                        onPressed: _saveForm,
//                      ),
//                    ),
//                    Container(
//                      padding: EdgeInsets.all(16),
//                      child: Text(_myActivitiesResult),
//                    )
                    ],
                  ),
                ),

                Form(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16),
                        child: MultiSelectFormField(
                          fillColor: LightColors.kLightYellow,
                          autovalidate: false,
                          titleText: 'Condições da via',
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return 'Escolha uma ou mais opções';
                            }
                          },
                          dataSource: [
                            {
                              "display": "Asfalto",
                              "value": "Asfalto",
                            },
                            {
                              "display": "Cascalho",
                              "value": "Cascalho",
                            },
                            {
                              "display": "Paralelepípedo",
                              "value": "Paralelepípedo",
                            },
                            {
                              "display": "Terra",
                              "value": "Terra",
                            },
                            {
                              "display": "Em obras",
                              "value": "Em obras",
                            },
                            {
                              "display": "Boa",
                              "value": "Boa",
                            },
                            {
                              "display": "Seca",
                              "value": "Seca",
                            },
                            {
                              "display": "Molhada",
                              "value": "Molhada",
                            },
                            {
                              "display": "Oleosa",
                              "value": "Oleosa",
                            },
                            {
                              "display": "Lombada",
                              "value": "Lombada",
                            },
                          ],

                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCELAR',

                          required: true,
                          hintText: 'Escolha uma ou mais opções',
                          border: InputBorder.none,

                          //value: _myActivities,
                          onSaved: (value) {
                            if (value == null) return;
                            setState(() {
                              _myActivities = value;
                            });
                          },
                        ),
                      ),
//                    Container(
//                      padding: EdgeInsets.all(8),
//                      child: RaisedButton(
//                        child: Text('Save'),
//                        onPressed: _saveForm,
//                      ),
//                    ),
//                    Container(
//                      padding: EdgeInsets.all(16),
//                      child: Text(_myActivitiesResult),
//                    )
                    ],
                  ),
                ),

                Form(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16),
                        child: MultiSelectFormField(
                          fillColor: LightColors.kLightYellow,
                          autovalidate: false,
                          titleText: 'Semáforo',
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return 'Escolha uma ou mais opções';
                            }
                          },
                          dataSource: [
                            {
                              "display": "Existente",
                              "value": "Existente",
                            },
                            {
                              "display": "Inexistente",
                              "value": "Inexistente",
                            },
                            {
                              "display": "Funcionando",
                              "value": "Funcionando",
                            },
                            {
                              "display": "Intermitente",
                              "value": "Intermitente",
                            },
                          ],

                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCELAR',

                          required: true,
                          hintText: 'Escolha uma ou mais opções',
                          border: InputBorder.none,

                          //value: _myActivities,
                          onSaved: (value) {
                            if (value == null) return;
                            setState(() {
                              _myActivities = value;
                            });
                          },
                        ),
                      ),
//                    Container(
//                      padding: EdgeInsets.all(8),
//                      child: RaisedButton(
//                        child: Text('Save'),
//                        onPressed: _saveForm,
//                      ),
//                    ),
//                    Container(
//                      padding: EdgeInsets.all(16),
//                      child: Text(_myActivitiesResult),
//                    )
                    ],
                  ),
                ),

                Form(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16),
                        child: MultiSelectFormField(
                          fillColor: LightColors.kLightYellow,
                          autovalidate: false,
                          titleText: 'Placas',
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return 'Escolha uma ou mais opções';
                            }
                          },
                          dataSource: [
                            {
                              "display": "Regulamentação",
                              "value": "Regulamentação",
                            },
                            {
                              "display": "Advertência",
                              "value": "Advertência",
                            },
                            {
                              "display": "Sinalização",
                              "value": "Sinalização",
                            },
                            {
                              "display": "Nenhuma",
                              "value": "Nenhuma",
                            },
                          ],

                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCELAR',

                          required: true,
                          hintText: 'Escolha uma ou mais opções',
                          border: InputBorder.none,

                          //value: _myActivities,
                          onSaved: (value) {
                            if (value == null) return;
                            setState(() {
                              _myActivities = value;
                            });
                          },
                        ),
                      ),
//                    Container(
//                      padding: EdgeInsets.all(8),
//                      child: RaisedButton(
//                        child: Text('Save'),
//                        onPressed: _saveForm,
//                      ),
//                    ),
//                    Container(
//                      padding: EdgeInsets.all(16),
//                      child: Text(_myActivitiesResult),
//                    )
                    ],
                  ),
                ),

                Form(
                  child: Column(
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(16),
                        child: MultiSelectFormField(
                          fillColor: LightColors.kLightYellow,
                          autovalidate: false,
                          titleText: 'Ambiente',
                          validator: (value) {
                            if (value == null || value.length == 0) {
                              return 'Escolha uma ou mais opções';
                            }
                          },
                          dataSource: [
                            {
                              "display": "Amanhecer",
                              "value": "Amanhecer",
                            },
                            {
                              "display": "Dia com luz natural",
                              "value": "Dia com luz natural",
                            },
                            {
                              "display": "Entardecer",
                              "value": "Entardecer",
                            },
                            {
                              "display": "Noite com iluminação",
                              "value": "Noite com iluminação",
                            },
                          ],

                          textField: 'display',
                          valueField: 'value',
                          okButtonLabel: 'OK',
                          cancelButtonLabel: 'CANCELAR',

                          required: true,
                          hintText: 'Escolha uma ou mais opções',
                          border: InputBorder.none,

                          //value: _myActivities,
                          onSaved: (value) {
                            if (value == null) return;
                            setState(() {
                              _myActivities = value;
                            });
                          },
                        ),
                      ),
//                    Container(
//                      padding: EdgeInsets.all(8),
//                      child: RaisedButton(
//                        child: Text('Save'),
//                        onPressed: _saveForm,
//                      ),
//                    ),
//                    Container(
//                      padding: EdgeInsets.all(16),
//                      child: Text(_myActivitiesResult),
//                    )
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Mensagem:',
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 17.0),
                      ),
                    ],
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 25.0),
                      child: TextField(
                        maxLines: 5,
                        controller: _obstextFieldController,
                        onChanged: _onChanged,
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(700),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                          _obscharCount.toString() + " caracteres restantes",
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 12.0)),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 30.0, bottom: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Imagem ou Croqui do acidente:',
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 17.0),
                      ),
                    ],
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Container(
                    color: LightColors.kLightYellow,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: IconButton(
                            icon: Icon(
                              Icons.color_lens,
                            ),
                            iconSize: 60,
                            color: LightColors.kDarkYellow,
                            //splashColor: LightColors.kLightYellow2,
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Draw(
                                        user: user, token: token, sol: sol)),
                              );
                            },
                          ),
                        ),
//                  Center(
//                    child: _image == null
//                        ? Text(' ')
//                        : Image.file(_image),
//                  ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 40),
                          child: Stack(
                            children: <Widget>[
                              Center(
                                child: FlatButton(
                                  onPressed: () {
                                    //setState(() {});
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                              title: Text(
                                                "Selecionar imagem da galeria ou tirar foto?",
                                                style: TextStyle(
                                                    color: Colors.grey[600]),
                                              ),
                                              content: new Text(''),
                                              actions: <Widget>[
                                                new FlatButton(
                                                  onPressed: () async {
                                                    Navigator.pop(
                                                        context); //close the dialog box
                                                    getImage(
                                                        ImageSource.gallery);
                                                  },
                                                  child: const Text(
                                                    'Galeria',
                                                    style: TextStyle(
                                                        fontSize: 20.0),
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
                                                    style: TextStyle(
                                                        fontSize: 20.0),
                                                  ),
                                                ),
                                              ]);
                                        });
                                  },
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.only(bottom: 20.0),
                                    child: Center(
                                      child: IconButton(
                                          icon: Icon(
                                        Icons.add_a_photo,
                                        color: LightColors.kDarkYellow,
                                        size: 60.0,
                                      )),
                                    ),
                                  ),
                                ),
                              ),
                              //Spacer(),
                            ],
                          ),
                        ),
                        Center(
                          child:
                              _image == null ? Text(' ') : Image.file(_image),
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 30.0, bottom: 10.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Avarias no ônibus da ETT:',
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 17.0),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Container(
                    color: LightColors.kLightYellow,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(bottom: 20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[
                                Text(
                                  'LATERAL ESQUERDA:',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'FRENTE:',
                                  style: TextStyle(
                                      color: Colors.grey[600],
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0, right: 0),
                            child: Container(
                              color: LightColors.kLightYellow,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 40),
                                    child: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: FlatButton(
                                            onPressed: () {
                                              //setState(() {});
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                        title: Text(
                                                          "Selecionar imagem da galeria ou tirar foto?",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[600]),
                                                        ),
                                                        content: new Text(''),
                                                        actions: <Widget>[
                                                          new FlatButton(
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context); //close the dialog box
                                                              getImageLatEsquerda(
                                                                  ImageSource
                                                                      .gallery);
                                                            },
                                                            child: const Text(
                                                              'Galeria',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      20.0),
                                                            ),
                                                          ),
                                                          new FlatButton(
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context); //close the dialog box
                                                              getImageLatEsquerda(
                                                                ImageSource
                                                                    .camera,
                                                              );
                                                            },
                                                            child: const Text(
                                                              'Câmera',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      20.0),
                                                            ),
                                                          ),
                                                        ]);
                                                  });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20.0),
                                              child: Center(
                                                child: IconButton(
                                                    icon: Icon(
                                                  Icons.add_a_photo,
                                                  color:
                                                      LightColors.kDarkYellow,
                                                  size: 60.0,
                                                )),
                                              ),
                                            ),
                                          ),
                                        ),
                                        //Spacer(),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: _imageOnibusETTLateralEsquerda == null
                                        ? Text(' ')
                                        : Image.file(_imageOnibusETTLateralEsquerda),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 40),
                                    child: Stack(
                                      children: <Widget>[
                                        Center(
                                          child: FlatButton(
                                            onPressed: () {
                                              //setState(() {});
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                        title: Text(
                                                          "Selecionar imagem da galeria ou tirar foto?",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .grey[600]),
                                                        ),
                                                        content: new Text(''),
                                                        actions: <Widget>[
                                                          new FlatButton(
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context); //close the dialog box
                                                              getImageFrente(
                                                                  ImageSource
                                                                      .gallery);
                                                            },
                                                            child: const Text(
                                                              'Galeria',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      20.0),
                                                            ),
                                                          ),
                                                          new FlatButton(
                                                            onPressed:
                                                                () async {
                                                              Navigator.pop(
                                                                  context); //close the dialog box
                                                              getImageFrente(
                                                                ImageSource
                                                                    .camera,
                                                              );
                                                            },
                                                            child: const Text(
                                                              'Câmera',
                                                              style: TextStyle(
                                                                  fontSize:
                                                                      20.0),
                                                            ),
                                                          ),
                                                        ]);
                                                  });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  bottom: 20.0),
                                              child: Center(
                                                child: IconButton(
                                                    icon: Icon(
                                                  Icons.add_a_photo,
                                                  color:
                                                      LightColors.kDarkYellow,
                                                  size: 60.0,
                                                )),
                                              ),
                                            ),
                                          ),
                                        ),
                                        //Spacer(),
                                      ],
                                    ),
                                  ),
                                  Center(
                                    child: _imageOnibusETTFrente == null
                                        ? Text(' ')
                                        : Image.file(_imageOnibusETTFrente),
                                  ),
                                ],
                              ),
                            ),
                          ),
//                          Padding(
//                            padding:
//                                const EdgeInsets.only(right: 20, bottom: 50),
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              children: <Widget>[
//                                _editImage == null
//                                    ? Center(
//                                        child: FlatButton(
//                                          onPressed: () {
//                                            getimageditor();
//                                          },
//                                          child: new Icon(
//                                            Icons.add_a_photo,
//                                            color: LightColors.kDarkYellow,
//                                            size: 70.0,
//                                          ),
//                                        ),
//                                      )
//                                    : Center(
//                                        child: Image.file(_editImage),
//                                      ),
//                                _editImage == null
//                                    ? Center(
//                                        child: FlatButton(
//                                          onPressed: () {
//                                            getimageditor();
//                                          },
//                                          child: new Icon(
//                                            Icons.add_a_photo,
//                                            color: LightColors.kDarkYellow,
//                                            size: 70.0,
//                                          ),
//                                        ),
//                                      )
//                                    : Center(
//                                        child: Image.file(_editImage),
//                                      )
//                              ],
//                            ),
//                          ),
                        Row(
                          children: <Widget>[
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(bottom: 20.0),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceEvenly,
                                  children: <Widget>[
                                    Text(
                                      'LATERAL DIREITA:',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      'TRASEIRA:',
                                      style: TextStyle(
                                          color: Colors.grey[600],
                                          fontSize: 14.0,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: <Widget>[

                                Padding(
                                  padding: const EdgeInsets.only(bottom: 40),
                                  child: Stack(
                                    children: <Widget>[
                                      Center(
                                        child: FlatButton(
                                          onPressed: () {
                                            //setState(() {});
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      title: Text(
                                                        "Selecionar imagem da galeria ou tirar foto?",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[600]),
                                                      ),
                                                      content: new Text(''),
                                                      actions: <Widget>[
                                                        new FlatButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context); //close the dialog box
                                                            getImageLatDireita(
                                                                ImageSource
                                                                    .gallery);
                                                          },
                                                          child: const Text(
                                                            'Galeria',
                                                            style: TextStyle(
                                                                fontSize: 20.0),
                                                          ),
                                                        ),
                                                        new FlatButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context); //close the dialog box
                                                            getImageLatDireita(
                                                              ImageSource
                                                                  .camera,
                                                            );
                                                          },
                                                          child: const Text(
                                                            'Câmera',
                                                            style: TextStyle(
                                                                fontSize: 20.0),
                                                          ),
                                                        ),
                                                      ]);
                                                });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20.0),
                                            child: Center(
                                              child: IconButton(
                                                  icon: Icon(
                                                Icons.add_a_photo,
                                                color: LightColors.kDarkYellow,
                                                size: 60.0,
                                              )),
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Spacer(),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: _imageOnibusETTLateralDireita == null
                                      ? Text(' ')
                                      : Image.file(
                                          _imageOnibusETTLateralDireita),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 40),
                                  child: Stack(
                                    children: <Widget>[
                                      Center(
                                        child: FlatButton(
                                          onPressed: () {
                                            //setState(() {});
                                            showDialog(
                                                context: context,
                                                builder:
                                                    (BuildContext context) {
                                                  return AlertDialog(
                                                      title: Text(
                                                        "Selecionar imagem da galeria ou tirar foto?",
                                                        style: TextStyle(
                                                            color: Colors
                                                                .grey[600]),
                                                      ),
                                                      content: new Text(''),
                                                      actions: <Widget>[
                                                        new FlatButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context); //close the dialog box
                                                            getImageTraseira(
                                                                ImageSource
                                                                    .gallery);
                                                          },
                                                          child: const Text(
                                                            'Galeria',
                                                            style: TextStyle(
                                                                fontSize: 20.0),
                                                          ),
                                                        ),
                                                        new FlatButton(
                                                          onPressed: () async {
                                                            Navigator.pop(
                                                                context); //close the dialog box
                                                            getImageTraseira(
                                                              ImageSource
                                                                  .camera,
                                                            );
                                                          },
                                                          child: const Text(
                                                            'Câmera',
                                                            style: TextStyle(
                                                                fontSize: 20.0),
                                                          ),
                                                        ),
                                                      ]);
                                                });
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 20.0),
                                            child: Center(
                                              child: IconButton(
                                                  icon: Icon(
                                                Icons.add_a_photo,
                                                color: LightColors.kDarkYellow,
                                                size: 60.0,
                                              )),
                                            ),
                                          ),
                                        ),
                                      ),
                                      //Spacer(),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: _imageOnibusETTTraseira == null
                                      ? Text(' ')
                                      : Image.file(_imageOnibusETTTraseira),
                                ),
                              ]),
//                          Padding(
//                            padding:
//                                const EdgeInsets.only(right: 20, bottom: 30),
//                            child: Row(
//                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                              children: <Widget>[
//                                _editImage == null
//                                    ? Center(
//                                        child: FlatButton(
//                                          onPressed: () {
//                                            getimageditor();
//                                          },
//                                          child: new Icon(
//                                            Icons.add_a_photo,
//                                            color: LightColors.kDarkYellow,
//                                            size: 70.0,
//                                          ),
//                                        ),
//                                      )
//                                    : Center(
//                                        child: Image.file(_editImage),
//                                      ),
//                                _editImage == null
//                                    ? Center(
//                                        child: FlatButton(
//                                          onPressed: () {
//                                            getimageditor();
//                                          },
//                                          child: new Icon(
//                                            Icons.add_a_photo,
//                                            color: LightColors.kDarkYellow,
//                                            size: 70.0,
//                                          ),
//                                        ),
//                                      )
//                                    : Center(
//                                        child: Image.file(_editImage),
//                                      )
//                              ],
//                            ),
//                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Obs.:',
                        style:
                            TextStyle(color: Colors.grey[600], fontSize: 17.0),
                      ),
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
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(700),
                        ],
                      ),
                    ),
                    SizedBox(height: 20.0),
                    Padding(
                      padding: const EdgeInsets.only(left: 20.0),
                      child: Text(
                          _charCount.toString() + " caracteres restantes",
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 12.0)),
                    ),
                  ],
                ),

                Padding(
                  padding:
                      const EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Testemunhas (passageiros ou transeuntes):',
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                ),

                //testemunhas stepper

                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Container(
                    //color: LightColors.kLightYellow,
                    child: complete
                        ? Center(
                            child: AlertDialog(
                              title: new Text("Atenção"),
                              content: new Text(
                                "Testemunhas registradas com sucesso!",
                              ),
                              actions: <Widget>[
                                new FlatButton(
                                  child: new Text("Fechar"),
                                  onPressed: () {
                                    setState(() => complete = false);
                                  },
                                ),
                              ],
                            ),
                          )
                        : Form(
                            key: _formStepperKey,
                            child: Stepper(
                              steps: [
                                Step(
                                  isActive: true,
                                  state: StepState.indexed,
                                  title: const Text('Testemunha 1:'),
                                  //subtitle: testemunha1(),
                                  content: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        decoration:
                                            InputDecoration(labelText: 'Nome'),
                                        keyboardType: TextInputType.text,
                                        autocorrect: false,
//                                validator: composeValidators('nome',
//                                  [requiredValidator, stringValidator]),
//                                        onSaved: (String value) {
//                                          user.nome = value;
//                                        },
                                        maxLines: 1,
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length < 1) {
                                            return 'Digite o nome da testemunha 1!';
                                          }
                                          return null;
                                        },
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Endereço residencial'),
                                        keyboardType: TextInputType.text,
                                        autocorrect: false,
//                                validator: composeValidators('endereço',
//                                    [requiredValidator, stringValidator]),
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length < 5) {
                                            return 'Digite o endereço da testemunha 1!';
                                          }
                                        },
//            onSaved: (String value) {
//              data.phone = value;
//            },
                                        maxLines: 1,
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Telefone'),
                                        keyboardType: TextInputType.phone,
                                        maxLength: 14,
                                        controller: teltest1Controller,
                                        autocorrect: false,
//                                validator: composeValidators('telefone',
//                                    [requiredValidator, numberValidator]),
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length < 10) {
                                            return 'Digite o telefone da testemunha 1!';
                                          }
                                        },
//            onSaved: (String value) {
//              data.phone = value;
//            },
                                        maxLines: 1,
                                      ),
                                      TextFormField(
                                        decoration:
                                            InputDecoration(labelText: 'RG'),
                                        keyboardType: TextInputType.number,
                                        controller: rgTest1Controller,
                                        maxLength: 12,
                                        autocorrect: false,
//                                validator: composeValidators('RG',
//                                    [requiredValidator, rgValidator]),
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length < 8) {
                                            return 'Digite o RG da testemunha 1!';
                                          }
                                        },
//            onSaved: (String value) {
//              data.phone = value;
//            },
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                                Step(
                                  state: StepState.indexed,
                                  isActive: true,
                                  title: const Text('Testemunha 2:'),
                                  //subtitle: const Text("Error!"),
                                  content: Column(
                                    children: <Widget>[
                                      TextFormField(
                                        decoration:
                                            InputDecoration(labelText: 'Nome'),
                                        keyboardType: TextInputType.text,
                                        autocorrect: false,
//                                validator: composeValidators('nome',
//                                    [requiredValidator, stringValidator]),
//            onSaved: (String value) {
//              data.name = value;
//            },
                                        maxLines: 1,
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length < 1) {
                                            return 'Digite o nome da testemunha 2!';
                                          }
                                        },
                                      ),
                                      TextFormField(
                                        decoration: InputDecoration(
                                            labelText: 'Endereço residencial'),
                                        keyboardType: TextInputType.text,
                                        autocorrect: false,
//                                validator: composeValidators('endereço',
//                                    [requiredValidator, stringValidator]),
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length < 5) {
                                            return 'Digite o endereço da testemunha 2!';
                                          } else {
                                            null;
                                          }
                                        },
//            onSaved: (String value) {
//              data.phone = value;
//            },
                                        maxLines: 1,
                                      ),
                                      TextFormField(
                                        maxLength: 14,
                                        decoration: InputDecoration(
                                            labelText: 'Telefone'),
                                        keyboardType: TextInputType.phone,
                                        autocorrect: false,
                                        controller: teltest2Controller,
//                                validator: composeValidators('telefone',
//                                    [requiredValidator, numberValidator]),
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length < 10) {
                                            return 'Digite o telefone da testemunha 2!';
                                          }
                                        },
//            onSaved: (String value) {
//              data.phone = value;
//            },
                                        maxLines: 1,
                                      ),
                                      TextFormField(
                                        decoration:
                                            InputDecoration(labelText: 'RG'),
                                        keyboardType: TextInputType.number,
                                        controller: rgTest2Controller,
                                        maxLength: 12,
                                        autocorrect: false,
                                        validator: (value) {
                                          if (value.isEmpty ||
                                              value.length < 8) {
                                            return 'Digite o telefone da testemunha 2!';
                                          }
                                        },
//                                validator: composeValidators('RG',
//                                    [requiredValidator, rgValidator]),
//            onSaved: (String value) {
//              data.phone = value;
//            },
                                        maxLines: 1,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                              currentStep: this.currentStep,
                              onStepContinue: () {
                                if (currentStep + 1 != 2) {
                                  goTo(currentStep + 1);
                                } else {
                                  if (_formStepperKey.currentState.validate()) {
                                    //setState(() => complete = true );
                                    setState(() {
                                      complete = true;
                                    });
                                  } else {
                                    incomplete = true;
                                  }
                                }
                              },
                              onStepTapped: (_currentStep) {
                                setState(() {
                                  currentStep = _currentStep;
                                });
                              },
                              //onStepTapped: (step) => goTo(step),
                              onStepCancel: () {
                                if (currentStep != 0) {
                                  goTo(-1);
                                }
                              },
                              controlsBuilder: (BuildContext context,
                                  {VoidCallback onStepContinue,
                                  VoidCallback onStepCancel}) {
                                return Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: Container(
                                          color: LightColors.kDarkYellow,
                                          child: FlatButton(
                                              onPressed: onStepContinue,
                                              child: Text(
                                                'PROSSEGUIR',
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 13),
                                              ))),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 20),
                                      child: FlatButton(
                                          onPressed: onStepCancel,
                                          child: Text('RETORNAR',
                                              style: TextStyle(
                                                  color: Colors.grey[800],
                                                  fontSize: 13))),
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                  ),
                ),
//                Container(
//                  child: incomplete
//                      ? Center(
//                    child:
////                    AlertDialog(
////                      title: new Text("Atenção"),
////                      content:
//                      new Text(
//                        "Formulário incompleto!",
//                        style: TextStyle(color: Colors.red, fontSize: 17),
//                      ),
////                      actions: <Widget>[
////                        new FlatButton(
////                          child: new Text("Fechar"),
////                          onPressed: () {
////                            setState(() => complete = false);
////                          },
////                        ),
////                      ],
////                    ),
//                  )
//                      : Form(),
//                ),

                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Avarias no veículo de terceiro:',
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                ),

                //radio button grau da avaria
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Radio(
                      value: 1,
                      groupValue: id,
                      onChanged: (val) {
                        setState(() {
                          haAvariaNoCarro = true;
                          radioButtonItem = 'ONE';
                          id = 1;
                        });
                      },
                    ),
                    Flexible(
                      child: Text('PEQUENA',
                          style: TextStyle(
                              color: Colors.grey[800], fontSize: 14.0)),
                    ),
                    Radio(
                      value: 2,
                      groupValue: id,
                      onChanged: (val) {
                        setState(() {
                          haAvariaNoCarro = true;
                          radioButtonItem = 'TWO';
                          id = 2;
                        });
                      },
                    ),
                    Flexible(
                      child: Text('MÉDIA',
                          style: TextStyle(
                              color: Colors.grey[800], fontSize: 14.0)),
                    ),
                    Radio(
                      value: 3,
                      groupValue: id,
                      onChanged: (val) {
                        setState(() {
                          haAvariaNoCarro = true;
                          radioButtonItem = 'THREE';
                          id = 3;
                        });
                      },
                    ),
                    Flexible(
                      child: Text('GRANDE',
                          style: TextStyle(
                              color: Colors.grey[800], fontSize: 14.0)),
                    ),
                  ],
                ),

// Informações do veículo 1 com avaria
                Visibility(
                  visible: haAvariaNoCarro,
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.only(top: 10.0, bottom: 20.0),
                            child: Center(
                              child: Image(
                                image: AssetImage(
                                    'images/carroAvariaComLinhas.jpg'),
                                //height: 100.0,
                              ),
                            ),
                          ),
                          //botao 1
                          Padding(
                            padding: const EdgeInsets.only(left: 26, top: 3),
                            child: ListTile(
                              leading: InkWell(
                                  onTap: () {
                                    setState(() {
                                      botoes[0] = !botoes[0];
                                    });

                                    print('botao 1 deveria ser true: '+botoes[0].toString());

                                  },
                                  child: botoes[0]
                                      ? Icon(
                                          Icons.cancel,
                                          color: LightColors.kDarkYellow,
                                          size: 50,
                                        )
                                      : Icon(
                                          Icons.add_circle,
                                          color: Colors.grey[400],
                                          size: 50,
                                        )),
                              title: new Text(' ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0)),
                            ),
                          ),
                          //botao 2
                          Padding(
                            padding: const EdgeInsets.only(top: 63),
                            child: ListTile(
                              leading: InkWell(
                                  onTap: () {
                                    setState(() {

                                      botoes[1] = !botoes[1];
                                    });
                                  },
                                  child: botoes[1]
                                      ? Icon(
                                          Icons.cancel,
                                          color: LightColors.kDarkYellow,
                                          size: 50,
                                        )
                                      : Icon(
                                          Icons.add_circle,
                                          color: Colors.grey[400],
                                          size: 50,
                                        )),
                              title: new Text(' ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0)),
                            ),
                          ),
                          //botao 3
                          Padding(
                            padding: const EdgeInsets.only(top: 142),
                            child: ListTile(
                              leading: InkWell(
                                  onTap: () {

                                    setState(() {
                                      botoes[2] = !botoes[2];
                                    });
                                  },
                                  child: botoes[2]
                                      ? Icon(
                                          Icons.cancel,
                                          color: LightColors.kDarkYellow,
                                          size: 50,
                                        )
                                      : Icon(
                                          Icons.add_circle,
                                          color: Colors.grey[400],
                                          size: 50,
                                        )),
                              title: new Text(' ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0)),
                            ),
                          ),
                          //botao 4
                          Padding(
                            padding: const EdgeInsets.only(top: 248),
                            child: ListTile(
                              leading: InkWell(
                                  onTap: () {
                                    setState(() {

                                      botoes[3] = !botoes[3];
                                    });
                                  },
                                  child: botoes[3]
                                      ? Icon(
                                          Icons.cancel,
                                          color: LightColors.kDarkYellow,
                                          size: 50,
                                        )
                                      : Icon(
                                          Icons.add_circle,
                                          color: Colors.grey[400],
                                          size: 50,
                                        )),
                              title: new Text(' ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0)),
                            ),
                          ),

//botao 5
                          Padding(
                            padding: const EdgeInsets.only(top: 365),
                            child: ListTile(
                              leading: InkWell(
                                  onTap: () {
                                    setState(() {
                                      botoes[4] = !botoes[4];
                                    });
                                  },
                                  child: botoes[4]
                                      ? Icon(
                                          Icons.cancel,
                                          color: LightColors.kDarkYellow,
                                          size: 50,
                                        )
                                      : Icon(
                                          Icons.add_circle,
                                          color: Colors.grey[400],
                                          size: 50,
                                        )),
                              title: new Text(' ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0)),
                            ),
                          ),
                          //botao 6
                          Padding(
                            padding: const EdgeInsets.only(top: 413),
                            child: ListTile(
                              leading: InkWell(
                                  onTap: () {
                                    setState(() {
                                      botoes[5] = !botoes[5];
                                    });
                                  },
                                  child: botoes[5]
                                      ? Icon(
                                          Icons.cancel,
                                          color: LightColors.kDarkYellow,
                                          size: 50,
                                        )
                                      : Icon(
                                          Icons.add_circle,
                                          color: Colors.grey[400],
                                          size: 50,
                                        )),
                              title: new Text(' ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0)),
                            ),
                          ),
                          //botao 7
                          Padding(
                            padding: const EdgeInsets.only(left: 290, top: 8),
                            child: ListTile(
                              leading: InkWell(
                                  onTap: () {
                                    setState(() {
                                      botoes[6] = !botoes[6];
                                    });
                                  },
                                  child: botoes[6]
                                      ? Icon(
                                          Icons.cancel,
                                          color: LightColors.kDarkYellow,
                                          size: 50,
                                        )
                                      : Icon(
                                          Icons.add_circle,
                                          color: Colors.grey[400],
                                          size: 50,
                                        )),
                              title: new Text(' ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0)),
                            ),
                          ),
                          //botao 8
                          Padding(
                            padding: const EdgeInsets.only(left: 290, top: 60),
                            child: ListTile(
                              leading: InkWell(
                                  onTap: () {
                                    setState(() {
                                      botoes[7] = !botoes[7];
                                    });
                                  },
                                  child: botoes[7]
                                      ? Icon(
                                          Icons.cancel,
                                          color: LightColors.kDarkYellow,
                                          size: 50,
                                        )
                                      : Icon(
                                          Icons.add_circle,
                                          color: Colors.grey[400],
                                          size: 50,
                                        )),
                              title: new Text(' ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0)),
                            ),
                          ),
                          //botao 9
                          Padding(
                            padding: const EdgeInsets.only(left: 290, top: 177),
                            child: ListTile(
                              leading: InkWell(
                                  onTap: () {
                                    setState(() {
                                      botoes[8] = !botoes[8];
                                    });
                                  },
                                  child: botoes[8]
                                      ? Icon(
                                          Icons.cancel,
                                          color: LightColors.kDarkYellow,
                                          size: 50,
                                        )
                                      : Icon(
                                          Icons.add_circle,
                                          color: Colors.grey[400],
                                          size: 50,
                                        )),
                              title: new Text(' ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0)),
                            ),
                          ),
                          //botao 10
                          Padding(
                            padding: const EdgeInsets.only(left: 290, top: 289),
                            child: ListTile(
                              leading: InkWell(
                                  onTap: () {
                                    setState(() {
                                      botoes[9] = !botoes[9];
                                    });
                                  },
                                  child: botoes[9]
                                      ? Icon(
                                          Icons.cancel,
                                          color: LightColors.kDarkYellow,
                                          size: 50,
                                        )
                                      : Icon(
                                          Icons.add_circle,
                                          color: Colors.grey[400],
                                          size: 50,
                                        )),
                              title: new Text(' ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0)),
                            ),
                          ),
                          //botao 11
                          Padding(
                            padding: const EdgeInsets.only(left: 290, top: 349),
                            child: ListTile(
                              leading: InkWell(
                                  onTap: () {
                                    setState(() {
                                      botoes[10] = !botoes[10];
                                    });
                                  },
                                  child: botoes[10]
                                      ? Icon(
                                          Icons.cancel,
                                          color: LightColors.kDarkYellow,
                                          size: 50,
                                        )
                                      : Icon(
                                          Icons.add_circle,
                                          color: Colors.grey[400],
                                          size: 50,
                                        )),
                              title: new Text(' ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0)),
                            ),
                          ),
                          //botao 12
                          Padding(
                            padding: const EdgeInsets.only(left: 290, top: 399),
                            child: ListTile(
                              leading: InkWell(
                                  onTap: () {
                                    setState(() {
                                      botoes[11] = !botoes[11];
                                    });
                                  },
                                  child: botoes[11]
                                      ? Icon(
                                          Icons.cancel,
                                          color: LightColors.kDarkYellow,
                                          size: 50,
                                        )
                                      : Icon(
                                          Icons.add_circle,
                                          color: Colors.grey[400],
                                          size: 50,
                                        )),
                              title: new Text(' ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0)),
                            ),
                          ),
                          //botao 13
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 158.0, top: 240),
                            child: ListTile(
                              leading: InkWell(
                                  onTap: () {
                                    setState(() {
                                      botoes[12] = !botoes[12];
                                    });
                                  },
                                  child: botoes[12]
                                      ? Icon(
                                          Icons.cancel,
                                          color: LightColors.kDarkYellow,
                                          size: 50,
                                        )
                                      : Icon(
                                          Icons.add_circle,
                                          color: Colors.grey[400],
                                          size: 50,
                                        )),
                              title: new Text(' ',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0)),
                            ),
                          ),
                        ],
                      ),
                      //Dados do carro 1 com avaria
                      Container(
                        margin: EdgeInsets.only(top: 0),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Dados do veículo com avarias:",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: Form(
                                    key: formdropDownMarcaCarroAvariaKey,
                                    child: Container(
                                      child: DropDownFormField(
                                        titleText: 'Marca',
                                        hintText: 'Escolha uma marca',
                                        value: _dropDownMarcaCarroAvaria,
                                        onSaved: (value) {
                                          setState(() {
                                            _dropDownMarcaCarroAvaria = value;
                                          });
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _dropDownMarcaCarroAvaria = value;
                                          });
                                        },
                                        dataSource: [
                                          {
                                            "display": "Agrale",
                                            "value": "Agrale",
                                          },
                                          {
                                            "display": "Aston Martin",
                                            "value": "Aston Martin",
                                          },
                                          {
                                            "display": "Audi",
                                            "value": "Audi",
                                          },
                                          {
                                            "display": "Bentley",
                                            "value": "Bentley",
                                          },
                                          {
                                            "display": "BMW",
                                            "value": "BMW",
                                          },
                                          {
                                            "display": "BYD",
                                            "value": "BYD",
                                          },
                                          {
                                            "display": "Caoa Chery",
                                            "value": "Caoa Chery",
                                          },
                                          {
                                            "display": "Changan",
                                            "value": "Changan",
                                          },
                                          {
                                            "display": "Chevrolet",
                                            "value": "Chevrolet",
                                          },
                                          {
                                            "display": "Chrysler",
                                            "value": "Chrysler",
                                          },
                                          {
                                            "display": "Citroen",
                                            "value": "Citroen",
                                          },
                                          {
                                            "display": "Dodge",
                                            "value": "Dodge",
                                          },
                                          {
                                            "display": "Dongfeng",
                                            "value": "Dongfeng",
                                          },
                                          {
                                            "display": "Effa",
                                            "value": "Effa",
                                          },
                                          {
                                            "display": "Ferrari",
                                            "value": "Ferrari",
                                          },
                                          {
                                            "display": "Fiat",
                                            "value": "Fiat",
                                          },
                                          {
                                            "display": "Ford",
                                            "value": "Ford",
                                          },
                                          {
                                            "display": "Foton",
                                            "value": "Foton",
                                          },
                                          {
                                            "display": "Geely",
                                            "value": "Geely",
                                          },
                                          {
                                            "display": "Hafei",
                                            "value": "Hafei",
                                          },
                                          {
                                            "display": "Honda",
                                            "value": "Honda",
                                          },
                                          {
                                            "display": "Hyundai",
                                            "value": "Hyundai",
                                          },
                                          {
                                            "display": "Iveco",
                                            "value": "Iveco",
                                          },
                                          {
                                            "display": "JAC",
                                            "value": "JAC",
                                          },
                                          {
                                            "display": "Jaguar",
                                            "value": "Jaguar",
                                          },
                                          {
                                            "display": "Jeep",
                                            "value": "Jeep",
                                          },
                                          {
                                            "display": "Jinbei",
                                            "value": "Jinbei",
                                          },
                                          {
                                            "display": "KIA",
                                            "value": "KIA",
                                          },
                                          {
                                            "display": "Lamborghini",
                                            "value": "Lamborghini",
                                          },
                                          {
                                            "display": "Land Rover",
                                            "value": "Land Rover",
                                          },
                                          {
                                            "display": "Lexus",
                                            "value": "Lexus",
                                          },
                                          {
                                            "display": "Lifan",
                                            "value": "Lifan",
                                          },
                                          {
                                            "display": "Maserati",
                                            "value": "Maserati",
                                          },
                                          {
                                            "display": "McLaren",
                                            "value": "McLaren",
                                          },
                                          {
                                            "display": "Mercedes",
                                            "value": "Mercedes",
                                          },
                                          {
                                            "display": "Mini",
                                            "value": "Mini",
                                          },
                                          {
                                            "display": "Mitsubishi",
                                            "value": "Mitsubishi",
                                          },
                                          {
                                            "display": "Nissan",
                                            "value": "Nissan",
                                          },
                                          {
                                            "display": "Peugeot",
                                            "value": "Peugeot",
                                          },
                                          {
                                            "display": "Porsche",
                                            "value": "Porsche",
                                          },
                                          {
                                            "display": "RAM",
                                            "value": "RAM",
                                          },
                                          {
                                            "display": "Rely",
                                            "value": "Rely",
                                          },
                                          {
                                            "display": "Renault",
                                            "value": "Renault",
                                          },
                                          {
                                            "display": "Rolls-Royce",
                                            "value": "Rolls-Royce",
                                          },
                                          {
                                            "display": "Shineray",
                                            "value": "Shineray",
                                          },
                                          {
                                            "display": "Smart",
                                            "value": "Smart",
                                          },
                                          {
                                            "display": "Subaru",
                                            "value": "Subaru",
                                          },
                                          {
                                            "display": "Suzuki",
                                            "value": "Suzuki",
                                          },
                                          {
                                            "display": "TAC",
                                            "value": "TAC",
                                          },
                                          {
                                            "display": "Tesla",
                                            "value": "Tesla",
                                          },
                                          {
                                            "display": "Toyota",
                                            "value": "Toyota",
                                          },
                                          {
                                            "display": "Troller",
                                            "value": "Troller",
                                          },
                                          {
                                            "display": "Volkswagen",
                                            "value": "Volkswagen",
                                          },
                                          {
                                            "display": "Volvo",
                                            "value": "Volvo",
                                          },
                                        ],
                                        textField: 'display',
                                        valueField: 'value',
                                      ),
                                    ),
//
                                  ),
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Modelo",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      maxLength: 8,
                                      decoration: InputDecoration(
                                          labelText: "Placa",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Form(
                                    key: formdropDownCarroAvariaKey,
                                    child:
//                              Stack(
//                                //mainAxisAlignment: MainAxisAlignment.start,
//                                children: <Widget>[
                                        Container(
                                      child: DropDownFormField(
                                        titleText: 'Cor',
                                        hintText: 'Escolha uma cor',
                                        value: _dropDownCarroAvaria,
                                        onSaved: (value) {
                                          setState(() {
                                            _dropDownCarroAvaria = value;
                                          });
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _dropDownCarroAvaria = value;
                                          });
                                        },
                                        dataSource: [
                                          {
                                            "display": "Amarela",
                                            "value": "Amarela",
                                          },
                                          {
                                            "display": "Azul",
                                            "value": "Azul",
                                          },
                                          {
                                            "display": "Bege",
                                            "value": "Bege",
                                          },
                                          {
                                            "display": "Branca",
                                            "value": "Branca",
                                          },
                                          {
                                            "display": "Castanha",
                                            "value": "Castanha",
                                          },
                                          {
                                            "display": "Cinza",
                                            "value": "Cinza",
                                          },
                                          {
                                            "display": "Laranja",
                                            "value": "Laranja",
                                          },
                                          {
                                            "display": "Marrom",
                                            "value": "Marrom",
                                          },
                                          {
                                            "display": "Vermelha",
                                            "value": "Vermelha",
                                          },
                                          {
                                            "display": "Prata",
                                            "value": "Prata",
                                          },
                                          {
                                            "display": "Preta",
                                            "value": "Preta",
                                          },
                                          {
                                            "display": "Rosa",
                                            "value": "Rosa",
                                          },
                                          {
                                            "display": "Roxa",
                                            "value": "Roxa",
                                          },
                                          {
                                            "display": "Verde",
                                            "value": "Verde",
                                          },
                                          {
                                            "display": "Vermelha",
                                            "value": "Vermelha",
                                          },
                                          {
                                            "display": "Vinho",
                                            "value": "Vinho",
                                          },
                                        ],
                                        textField: 'display',
                                        valueField: 'value',
                                      ),
                                    ),
//                                  Container(
//                                    padding: EdgeInsets.all(8),
//                                    child: RaisedButton(
//                                      child: Text('Save'),
//                                      onPressed: _saveForm,
//                                    ),
//                                  ),
//                                  Container(
//                                    padding: EdgeInsets.all(16),
//                                    child: Text(_dropDownCarroAvariaResult),
//                                  )
//                                ],
//                              ),
                                  ),
                                ),
//                          TextFormField(
//                            decoration: InputDecoration(
//                                labelText: "Cor", hasFloatingPlaceholder: true),
//                          ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Nome",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Endereço",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      controller: telac1Controller,
                                      maxLength: 14,
                                      decoration: InputDecoration(
                                          labelText: "Telefone",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Seguro - Qual?",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "CNH",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      controller: data1Controller,
                                      maxLength: 10,
                                      decoration: InputDecoration(
                                          labelText: "Vencimento",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Assinatura",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),
                                //SIGNATURE CANVAS
                                Signature(
                                  controller: _controller,
                                  height: 300,
                                  backgroundColor: Colors.grey[100],
                                ),
                                //OK AND CLEAR BUTTONS
                                Container(
                                  decoration: const BoxDecoration(
                                      color: LightColors.kLightYellow2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      //SHOW EXPORTED IMAGE IN NEW ROUTE
//                                      IconButton(
//                                        icon: const Icon(Icons.check),
//                                        color: Colors.blue,
//                                        onPressed: () async {
//                                          if (_controller.isNotEmpty) {
//                                            var data = await _controller.toPngBytes();
//                                            Navigator.of(context).push(
//                                              MaterialPageRoute(
//                                                builder: (BuildContext context) {
//                                                  return Scaffold(
//                                                    appBar: AppBar(),
//                                                    body: Center(
//                                                        child: Container(
//                                                            color: Colors.grey[300], child: Image.memory(data))),
//                                                  );
//                                                },
//                                              ),
//                                            );
//                                          }
//                                        },
//                                      ),
                                      Spacer(),
                                      //CLEAR CANVAS
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: IconButton(
                                          icon: const Icon(Icons.clear),
                                          iconSize: 30,
                                          color: Colors.black,
                                          onPressed: () {
                                            setState(() => _controller.clear());
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Matrícula do Fiscal",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      //Adicionar segundo carro
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 20, bottom: 30, left: 20, right: 20),
                        child: FlatButton(
                          onPressed: () {
                            setState(() {
                              segundoCarro = !segundoCarro;
                            });
                          },
                          child: Row(
                            children: <Widget>[
                              Icon(
                                Icons.add_to_photos,
                                size: 30,
                                color: LightColors.kDarkYellow,
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Flexible(
                                child: Text(
                                  'Adicionar segundo veículo',
                                  style: TextStyle(
                                      color: Colors.grey[600], fontSize: 17.0),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                // mostra segundo veículo
                Visibility(
                  visible: segundoCarro,
                  child: Stack(
                    children: <Widget>[
                      //radio button grau da avaria
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Radio(
                            value: 1,
                            groupValue: id2,
                            onChanged: (val) {
                              setState(() {
                                radioButton2Item = 'ONE';
                                id2 = 1;
                              });
                            },
                          ),
                          Flexible(
                            child: Text('PEQUENA',
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 14.0)),
                          ),
                          Radio(
                            value: 2,
                            groupValue: id2,
                            onChanged: (val) {
                              setState(() {
                                radioButton2Item = 'TWO';
                                id2 = 2;
                              });
                            },
                          ),
                          Flexible(
                            child: Text('MÉDIA',
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 14.0)),
                          ),
                          Radio(
                            value: 3,
                            groupValue: id2,
                            onChanged: (val) {
                              setState(() {
                                radioButton2Item = 'THREE';
                                id2 = 3;
                              });
                            },
                          ),
                          Flexible(
                            child: Text('GRANDE',
                                style: TextStyle(
                                    color: Colors.grey[800], fontSize: 14.0)),
                          ),
                        ],
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 50),
                        child: Container(
                          margin: EdgeInsets.only(top: 10.0, bottom: 50.0),
                          child: Center(
                            child: Image(
                              image:
                                  AssetImage('images/carroAvariaComLinhas.jpg'),
                              //height: 100.0,
                            ),
                          ),
                        ),
                      ),

                      //botao 14
                      Padding(
                        padding: const EdgeInsets.only(left: 26, top: 53),
                        child: ListTile(
                          leading: InkWell(
                              onTap: () {
                                setState(() {
                                  botoes[13] = !botoes[13];
                                });
                              },
                              child: botoes[13]
                                  ? Icon(
                                      Icons.cancel,
                                      color: LightColors.kDarkYellow,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.add_circle,
                                      color: Colors.grey[400],
                                      size: 50,
                                    )),
                          title: new Text(' ',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                        ),
                      ),
                      //botao 15
                      Padding(
                        padding: const EdgeInsets.only(top: 113),
                        child: ListTile(
                          leading: InkWell(
                              onTap: () {
                                setState(() {
                                  botoes[14] = !botoes[14];
                                });
                              },
                              child: botoes[14]
                                  ? Icon(
                                      Icons.cancel,
                                      color: LightColors.kDarkYellow,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.add_circle,
                                      color: Colors.grey[400],
                                      size: 50,
                                    )),
                          title: new Text(' ',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                        ),
                      ),
                      //botao 16
                      Padding(
                        padding: const EdgeInsets.only(top: 192),
                        child: ListTile(
                          leading: InkWell(
                              onTap: () {
                                setState(() {
                                  botoes[15] = !botoes[15];
                                });
                              },
                              child: botoes[15]
                                  ? Icon(
                                      Icons.cancel,
                                      color: LightColors.kDarkYellow,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.add_circle,
                                      color: Colors.grey[400],
                                      size: 50,
                                    )),
                          title: new Text(' ',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                        ),
                      ),
                      //botao 17
                      Padding(
                        padding: const EdgeInsets.only(top: 298),
                        child: ListTile(
                          leading: InkWell(
                              onTap: () {
                                setState(() {
                                  botoes[16] = !botoes[16];
                                });
                              },
                              child: botoes[16]
                                  ? Icon(
                                      Icons.cancel,
                                      color: LightColors.kDarkYellow,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.add_circle,
                                      color: Colors.grey[400],
                                      size: 50,
                                    )),
                          title: new Text(' ',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                        ),
                      ),

                      //botao 18
                      Padding(
                        padding: const EdgeInsets.only(top: 415),
                        child: ListTile(
                          leading: InkWell(
                              onTap: () {
                                setState(() {
                                  botoes[17] = !botoes[17];
                                });
                              },
                              child: botoes[17]
                                  ? Icon(
                                      Icons.cancel,
                                      color: LightColors.kDarkYellow,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.add_circle,
                                      color: Colors.grey[400],
                                      size: 50,
                                    )),
                          title: new Text(' ',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                        ),
                      ),
                      //botao 19
                      Padding(
                        padding: const EdgeInsets.only(top: 463),
                        child: ListTile(
                          leading: InkWell(
                              onTap: () {
                                setState(() {
                                  botoes[18] = !botoes[18];
                                });
                              },
                              child: botoes[18]
                                  ? Icon(
                                      Icons.cancel,
                                      color: LightColors.kDarkYellow,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.add_circle,
                                      color: Colors.grey[400],
                                      size: 50,
                                    )),
                          title: new Text(' ',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                        ),
                      ),
                      //botao 20
                      Padding(
                        padding: const EdgeInsets.only(left: 290, top: 58),
                        child: ListTile(
                          leading: InkWell(
                              onTap: () {
                                setState(() {
                                  botoes[19] = !botoes[19];
                                });
                              },
                              child: botoes[19]
                                  ? Icon(
                                      Icons.cancel,
                                      color: LightColors.kDarkYellow,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.add_circle,
                                      color: Colors.grey[400],
                                      size: 50,
                                    )),
                          title: new Text(' ',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                        ),
                      ),
                      //botao 21
                      Padding(
                        padding: const EdgeInsets.only(left: 290, top: 110),
                        child: ListTile(
                          leading: InkWell(
                              onTap: () {
                                setState(() {
                                  botoes[20] = !botoes[20];
                                });
                              },
                              child: botoes[20]
                                  ? Icon(
                                      Icons.cancel,
                                      color: LightColors.kDarkYellow,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.add_circle,
                                      color: Colors.grey[400],
                                      size: 50,
                                    )),
                          title: new Text(' ',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                        ),
                      ),
                      //botao 22
                      Padding(
                        padding: const EdgeInsets.only(left: 290, top: 227),
                        child: ListTile(
                          leading: InkWell(
                              onTap: () {
                                setState(() {
                                  botoes[21] = !botoes[21];
                                });
                              },
                              child: botoes[21]
                                  ? Icon(
                                      Icons.cancel,
                                      color: LightColors.kDarkYellow,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.add_circle,
                                      color: Colors.grey[400],
                                      size: 50,
                                    )),
                          title: new Text(' ',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                        ),
                      ),
                      //botao 23
                      Padding(
                        padding: const EdgeInsets.only(left: 290, top: 339),
                        child: ListTile(
                          leading: InkWell(
                              onTap: () {
                                setState(() {
                                  botoes[22] = !botoes[22];
                                });
                              },
                              child: botoes[22]
                                  ? Icon(
                                      Icons.cancel,
                                      color: LightColors.kDarkYellow,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.add_circle,
                                      color: Colors.grey[400],
                                      size: 50,
                                    )),
                          title: new Text(' ',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                        ),
                      ),
                      //botao 24
                      Padding(
                        padding: const EdgeInsets.only(left: 290, top: 399),
                        child: ListTile(
                          leading: InkWell(
                              onTap: () {
                                setState(() {
                                  botoes[23] = !botoes[23];
                                });
                              },
                              child: botoes[23]
                                  ? Icon(
                                      Icons.cancel,
                                      color: LightColors.kDarkYellow,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.add_circle,
                                      color: Colors.grey[400],
                                      size: 50,
                                    )),
                          title: new Text(' ',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                        ),
                      ),
                      //botao 25
                      Padding(
                        padding: const EdgeInsets.only(left: 290, top: 449),
                        child: ListTile(
                          leading: InkWell(
                              onTap: () {
                                setState(() {
                                  botoes[24] = !botoes[24];
                                });
                              },
                              child: botoes[24]
                                  ? Icon(
                                      Icons.cancel,
                                      color: LightColors.kDarkYellow,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.add_circle,
                                      color: Colors.grey[400],
                                      size: 50,
                                    )),
                          title: new Text(' ',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                        ),
                      ),
                      //botao 26
                      Padding(
                        padding: const EdgeInsets.only(left: 158.0, top: 290),
                        child: ListTile(
                          leading: InkWell(
                              onTap: () {
                                setState(() {
                                  botoes[25] = !botoes[25];
                                });
                              },
                              child: botoes[25]
                                  ? Icon(
                                      Icons.cancel,
                                      color: LightColors.kDarkYellow,
                                      size: 50,
                                    )
                                  : Icon(
                                      Icons.add_circle,
                                      color: Colors.grey[400],
                                      size: 50,
                                    )),
                          title: new Text(' ',
                              style: new TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14.0)),
                        ),
                      ),

//                    Padding(
//                      padding: const EdgeInsets.only(left: 160.0, top: 250),
//                      child: RawMaterialButton(
//                        onPressed: () {},
//                        elevation: 2.0,
//                        fillColor: Colors.orange,
//                        child: Text('13'),
//                        padding: EdgeInsets.all(15.0),
//                        shape: CircleBorder(),
//                      ),
//                    )
                      //Dados do carro 1 com avaria
                      Container(
                        margin: EdgeInsets.only(top: 540),
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(30.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Align(
                                  alignment: Alignment.topLeft,
                                  child: Text(
                                    "Dados do veículo com avarias:",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 15,
                                ),
                                Center(
                                  child: Form(
                                    key: formdropDownMarcaCarro2AvariaKey,
                                    child: Container(
                                      child: DropDownFormField(
                                        titleText: 'Marca',
                                        hintText: 'Escolha uma marca',
                                        value: _dropDownMarcaCarro2Avaria,
                                        onSaved: (value) {
                                          setState(() {
                                            _dropDownMarcaCarro2Avaria = value;
                                          });
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _dropDownMarcaCarro2Avaria = value;
                                          });
                                        },
                                        dataSource: [
                                          {
                                            "display": "Agrale",
                                            "value": "Agrale",
                                          },
                                          {
                                            "display": "Aston Martin",
                                            "value": "Aston Martin",
                                          },
                                          {
                                            "display": "Audi",
                                            "value": "Audi",
                                          },
                                          {
                                            "display": "Bentley",
                                            "value": "Bentley",
                                          },
                                          {
                                            "display": "BMW",
                                            "value": "BMW",
                                          },
                                          {
                                            "display": "BYD",
                                            "value": "BYD",
                                          },
                                          {
                                            "display": "Caoa Chery",
                                            "value": "Caoa Chery",
                                          },
                                          {
                                            "display": "Changan",
                                            "value": "Changan",
                                          },
                                          {
                                            "display": "Chevrolet",
                                            "value": "Chevrolet",
                                          },
                                          {
                                            "display": "Chrysler",
                                            "value": "Chrysler",
                                          },
                                          {
                                            "display": "Citroen",
                                            "value": "Citroen",
                                          },
                                          {
                                            "display": "Dodge",
                                            "value": "Dodge",
                                          },
                                          {
                                            "display": "Dongfeng",
                                            "value": "Dongfeng",
                                          },
                                          {
                                            "display": "Effa",
                                            "value": "Effa",
                                          },
                                          {
                                            "display": "Ferrari",
                                            "value": "Ferrari",
                                          },
                                          {
                                            "display": "Fiat",
                                            "value": "Fiat",
                                          },
                                          {
                                            "display": "Ford",
                                            "value": "Ford",
                                          },
                                          {
                                            "display": "Foton",
                                            "value": "Foton",
                                          },
                                          {
                                            "display": "Geely",
                                            "value": "Geely",
                                          },
                                          {
                                            "display": "Hafei",
                                            "value": "Hafei",
                                          },
                                          {
                                            "display": "Honda",
                                            "value": "Honda",
                                          },
                                          {
                                            "display": "Hyundai",
                                            "value": "Hyundai",
                                          },
                                          {
                                            "display": "Iveco",
                                            "value": "Iveco",
                                          },
                                          {
                                            "display": "JAC",
                                            "value": "JAC",
                                          },
                                          {
                                            "display": "Jaguar",
                                            "value": "Jaguar",
                                          },
                                          {
                                            "display": "Jeep",
                                            "value": "Jeep",
                                          },
                                          {
                                            "display": "Jinbei",
                                            "value": "Jinbei",
                                          },
                                          {
                                            "display": "KIA",
                                            "value": "KIA",
                                          },
                                          {
                                            "display": "Lamborghini",
                                            "value": "Lamborghini",
                                          },
                                          {
                                            "display": "Land Rover",
                                            "value": "Land Rover",
                                          },
                                          {
                                            "display": "Lexus",
                                            "value": "Lexus",
                                          },
                                          {
                                            "display": "Lifan",
                                            "value": "Lifan",
                                          },
                                          {
                                            "display": "Maserati",
                                            "value": "Maserati",
                                          },
                                          {
                                            "display": "McLaren",
                                            "value": "McLaren",
                                          },
                                          {
                                            "display": "Mercedes",
                                            "value": "Mercedes",
                                          },
                                          {
                                            "display": "Mini",
                                            "value": "Mini",
                                          },
                                          {
                                            "display": "Mitsubishi",
                                            "value": "Mitsubishi",
                                          },
                                          {
                                            "display": "Nissan",
                                            "value": "Nissan",
                                          },
                                          {
                                            "display": "Peugeot",
                                            "value": "Peugeot",
                                          },
                                          {
                                            "display": "Porsche",
                                            "value": "Porsche",
                                          },
                                          {
                                            "display": "RAM",
                                            "value": "RAM",
                                          },
                                          {
                                            "display": "Rely",
                                            "value": "Rely",
                                          },
                                          {
                                            "display": "Renault",
                                            "value": "Renault",
                                          },
                                          {
                                            "display": "Rolls-Royce",
                                            "value": "Rolls-Royce",
                                          },
                                          {
                                            "display": "Shineray",
                                            "value": "Shineray",
                                          },
                                          {
                                            "display": "Smart",
                                            "value": "Smart",
                                          },
                                          {
                                            "display": "Subaru",
                                            "value": "Subaru",
                                          },
                                          {
                                            "display": "Suzuki",
                                            "value": "Suzuki",
                                          },
                                          {
                                            "display": "TAC",
                                            "value": "TAC",
                                          },
                                          {
                                            "display": "Tesla",
                                            "value": "Tesla",
                                          },
                                          {
                                            "display": "Toyota",
                                            "value": "Toyota",
                                          },
                                          {
                                            "display": "Troller",
                                            "value": "Troller",
                                          },
                                          {
                                            "display": "Volkswagen",
                                            "value": "Volkswagen",
                                          },
                                          {
                                            "display": "Volvo",
                                            "value": "Volvo",
                                          },
                                        ],
                                        textField: 'display',
                                        valueField: 'value',
                                      ),
                                    ),
//
                                  ),
                                ),

                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Modelo",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      maxLength: 8,
                                      decoration: InputDecoration(
                                          labelText: "Placa",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Center(
                                  child: Form(
                                    key: formdropDownCarro2AvariaKey,
                                    child:
//                              Stack(
//                                //mainAxisAlignment: MainAxisAlignment.start,
//                                children: <Widget>[
                                        Container(
                                      child: DropDownFormField(
                                        titleText: 'Cor',
                                        hintText: 'Escolha uma cor',
                                        value: _dropDownCarro2Avaria,
                                        onSaved: (value) {
                                          setState(() {
                                            _dropDownCarro2Avaria = value;
                                          });
                                        },
                                        onChanged: (value) {
                                          setState(() {
                                            _dropDownCarro2Avaria = value;
                                          });
                                        },
                                        dataSource: [
                                          {
                                            "display": "Amarela",
                                            "value": "Amarela",
                                          },
                                          {
                                            "display": "Azul",
                                            "value": "Azul",
                                          },
                                          {
                                            "display": "Bege",
                                            "value": "Bege",
                                          },
                                          {
                                            "display": "Branca",
                                            "value": "Branca",
                                          },
                                          {
                                            "display": "Castanha",
                                            "value": "Castanha",
                                          },
                                          {
                                            "display": "Cinza",
                                            "value": "Cinza",
                                          },
                                          {
                                            "display": "Laranja",
                                            "value": "Laranja",
                                          },
                                          {
                                            "display": "Marrom",
                                            "value": "Marrom",
                                          },
                                          {
                                            "display": "Vermelha",
                                            "value": "Vermelha",
                                          },
                                          {
                                            "display": "Prata",
                                            "value": "Prata",
                                          },
                                          {
                                            "display": "Preta",
                                            "value": "Preta",
                                          },
                                          {
                                            "display": "Rosa",
                                            "value": "Rosa",
                                          },
                                          {
                                            "display": "Roxa",
                                            "value": "Roxa",
                                          },
                                          {
                                            "display": "Verde",
                                            "value": "Verde",
                                          },
                                          {
                                            "display": "Vermelha",
                                            "value": "Vermelha",
                                          },
                                          {
                                            "display": "Vinho",
                                            "value": "Vinho",
                                          },
                                        ],
                                        textField: 'display',
                                        valueField: 'value',
                                      ),
                                    ),
//                                  Container(
//                                    padding: EdgeInsets.all(8),
//                                    child: RaisedButton(
//                                      child: Text('Save'),
//                                      onPressed: _saveForm,
//                                    ),
//                                  ),
//                                  Container(
//                                    padding: EdgeInsets.all(16),
//                                    child: Text(_dropDownCarro2AvariaResult),
//                                  )
//                                ],
//                              ),
                                  ),
                                ),
//                          TextFormField(
//                            decoration: InputDecoration(
//                                labelText: "Cor", hasFloatingPlaceholder: true),
//                          ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Nome",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Endereço",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      controller: telac2Controller,
                                      maxLength: 14,
                                      decoration: InputDecoration(
                                          labelText: "Telefone",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Seguro - Qual?",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "CNH",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      controller: data2Controller,
                                      maxLength: 10,
                                      decoration: InputDecoration(
                                          labelText: "Vencimento",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  children: <Widget>[
                                    Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child: Text(
                                        "Assinatura",
                                        style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 16),
                                      ),
                                    ),
                                  ],
                                ),

                                //SIGNATURE CANVAS
                                Signature(
                                  controller: _controllerTetst2,
                                  height: 300,
                                  backgroundColor: Colors.grey[100],
                                ),
                                //OK AND CLEAR BUTTONS
                                Container(
                                  decoration: const BoxDecoration(
                                      color: LightColors.kLightYellow2),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    mainAxisSize: MainAxisSize.max,
                                    children: <Widget>[
                                      //SHOW EXPORTED IMAGE IN NEW ROUTE
//                                      IconButton(
//                                        icon: const Icon(Icons.check),
//                                        color: Colors.blue,
//                                        onPressed: () async {
//                                          if (_controller.isNotEmpty) {
//                                            var data = await _controller.toPngBytes();
//                                            Navigator.of(context).push(
//                                              MaterialPageRoute(
//                                                builder: (BuildContext context) {
//                                                  return Scaffold(
//                                                    appBar: AppBar(),
//                                                    body: Center(
//                                                        child: Container(
//                                                            color: Colors.grey[300], child: Image.memory(data))),
//                                                  );
//                                                },
//                                              ),
//                                            );
//                                          }
//                                        },
//                                      ),
                                      Spacer(),
                                      //CLEAR CANVAS
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 20),
                                        child: IconButton(
                                          icon: const Icon(Icons.clear),
                                          iconSize: 30,
                                          color: Colors.black,
                                          onPressed: () {
                                            setState(() =>
                                                _controllerTetst2.clear());
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.grey[100],
                                    //borderRadius: BorderRadius.circular(10)
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                          labelText: "Matrícula do Fiscal",
                                          hasFloatingPlaceholder: true),
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20.0, right: 20.0, top: 40.0),
                  child: Row(
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Conclusões:',
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                ),

                //Tabela de conclusão
                Padding(
                  padding: const EdgeInsets.only(bottom: 50),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: DataTable(
//                        sortColumnIndex: 0,
//                        sortAscending: true,
//                      columnSpacing: widget.columnSpacing,
//                      horizontalMargin: widget.horizontalMargin,
                      dataRowHeight: 50.0,
                      columns: [
                        DataColumn(label: Text(' '), numeric: true),
                        DataColumn(label: Text(' ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[800]),)),
                        DataColumn(label: Text(' ', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[800]),), numeric: true),
                        ],
                      rows: [
                        DataRow(
                          //selected: true,
                            cells: [
                               DataCell(CheckboxListTile(
                                   title: new Text(
                                     ' ',
                                     style: TextStyle(
                                         color: Colors.grey[600],
                                         fontSize: 13.0,
                                         fontWeight: FontWeight.w600),
                                   ),
                                   value: _isChecked[0],
                                   activeColor: Colors.orange[600],
                                   onChanged: (bool value) {
                                     onChanged(value);
                                   }),),
                              DataCell(Text('Isento')),
                              DataCell(TextFormField(
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    labelText: 'Por quê?',
                                    labelStyle: TextStyle(
                                        fontSize: 9.0,
                                        color: Colors.grey[900])),
                              ),),
                            ]),
                        DataRow(cells: [
                           DataCell(CheckboxListTile(
                               title: new Text(
                                 ' ',
                                 style: TextStyle(
                                     color: Colors.grey[600],
                                     fontSize: 9.0,
                                     fontWeight: FontWeight.w600),
                               ),
                               value: _isChecked[1],
                               activeColor: Colors.orange[600],
                               onChanged: (bool value) {
                                 onChanged2(value);
                               }),),
                          DataCell(Text('Culpado')),
                          DataCell(TextFormField(

                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Por quê?',
                                labelStyle: TextStyle(
                                    fontSize: 9.0,
                                    color: Colors.grey[900])),
                          ),),
                        ]),
                        DataRow(cells: [
                          DataCell(CheckboxListTile(
                              title: new Text(
                                ' ',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              value: _isChecked[2],
                              activeColor: Colors.orange[600],
                              onChanged: (bool value) {
                                onChanged3(value);
                              }),),
                          DataCell(Text('Ônibus estava com defeito')),
                          DataCell(TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Qual?',
                                labelStyle: TextStyle(
                                    fontSize: 9.0,
                                    color: Colors.grey[900])),
                          ),),
                        ]),
                        DataRow(cells: [
                          DataCell(CheckboxListTile(
                              title: new Text(
                                ' ',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              value: _isChecked[3],
                              activeColor: Colors.orange[600],
                              onChanged: (bool value) {
                                onChanged4(value);
                              }),),
                          DataCell(Text('Bafômetro (etilômetro)')),
                          DataCell(Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: idBafometro,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItemBafometro = 'ONE';
                                    idBafometro = 1;
                                  });
                                },
                              ),
                              Text('Sim',
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 14.0)),
                              Radio(
                                value: 2,
                                groupValue: idBafometro,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItemBafometro = 'TWO';
                                    idBafometro = 2;
                                  });
                                },
                              ),
                              Text('Não',
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 14.0)),
                              Radio(
                                value: 3,
                                groupValue: idBafometro,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItemBafometro = 'THREE';
                                    idBafometro = 3;
                                  });
                                },
                              ),
                              Text('Recusou',
                                    style: TextStyle(
                                        color: Colors.grey[800], fontSize: 14.0)),
                            ],
                          ),),
                        ]),
                        DataRow(cells: [
                          DataCell(CheckboxListTile(
                              title: new Text(
                                ' ',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              value: _isChecked[4],
                              activeColor: Colors.orange[600],
                              onChanged: (bool value) {
                                onChanged5(value);
                              }),),
                          DataCell(Text('Testemunha 1')),
                          DataCell(TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Matrícula',
                                labelStyle: TextStyle(
                                    fontSize: 9.0,
                                    color: Colors.grey[900])),
                          ),),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(' ')),
                          DataCell(Row(
                            children: <Widget>[
                              Text('Assinatura da Testemunha 1'),
                              Spacer(),
                              //CLEAR CANVAS
                              IconButton(
                                  icon: const Icon(Icons.replay),
                                  iconSize: 30,
                                  color: LightColors.kDarkYellow,
                                  onPressed: () {
                                    setState(() =>
                                        _controllerTest1Conclusao.clear());
                                  },
                                ),

                            ],
                          )),
                          DataCell(
                            Row(children: <Widget>[
                              //SIGNATURE CANVAS
                              Flexible(
                                child: Signature(
                                  controller: _controllerTest1Conclusao,
                                  height: 50,
                                  width: double.infinity,
                                  backgroundColor: Colors.grey[100],
                                ),
                              ),


                            ],)
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(CheckboxListTile(
                              title: new Text(
                                ' ',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              value: _isChecked[5],
                              activeColor: Colors.orange[600],
                              onChanged: (bool value) {
                                onChanged6(value);
                              }),),
                          DataCell(Text('Testemunha 2')),
                          DataCell(TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Matrícula',
                                labelStyle: TextStyle(
                                    fontSize: 9.0,
                                    color: Colors.grey[900])),
                          ),),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(' ')),
                          DataCell(Row(
                            children: <Widget>[
                              Text('Assinatura da Testemunha 2'),
                              Spacer(),
                              //CLEAR CANVAS
                              IconButton(
                                icon: const Icon(Icons.replay),
                                iconSize: 30,
                                color: LightColors.kDarkYellow,
                                onPressed: () {
                                  setState(() =>
                                      _controllerTest2Conclusao.clear());
                                },
                              ),

                            ],
                          )),
                          DataCell(
                              Row(children: <Widget>[
                                //SIGNATURE CANVAS
                                Flexible(
                                  child: Signature(
                                    controller: _controllerTest2Conclusao,
                                    height: 50,
                                    width: double.infinity,
                                    backgroundColor: Colors.grey[100],
                                  ),
                                ),


                              ],)
                          ),
                        ]),
                        DataRow(cells: [
                          DataCell(CheckboxListTile(
                              title: new Text(
                                ' ',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              value: _isChecked[6],
                              activeColor: Colors.orange[600],
                              onChanged: (bool value) {
                                onChanged7(value);
                              }),),
                          DataCell(Text('Encaminhar ao Departamento Jurídico')),
                          DataCell(TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: ' ',
                                labelStyle: TextStyle(
                                    fontSize: 9.0,
                                    color: Colors.grey[900])),
                          ),),
                        ]),
                        DataRow(cells: [
                          DataCell(CheckboxListTile(
                              title: new Text(
                                ' ',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              value: _isChecked[7],
                              activeColor: Colors.orange[600],
                              onChanged: (bool value) {
                                onChanged8(value);
                              }),),
                          DataCell(Text('Encaminhar para reciclagem')),
                          DataCell(TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: ' ',
                                labelStyle: TextStyle(
                                    fontSize: 9.0,
                                    color: Colors.grey[900])),
                          ),),
                        ]),
                        DataRow(cells: [
                          DataCell(CheckboxListTile(
                              title: new Text(
                                ' ',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              value: _isChecked[8],
                              activeColor: Colors.orange[600],
                              onChanged: (bool value) {
                                onChanged9(value);
                              }),),
                          DataCell(Text('Outros')),
                          DataCell(TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: ' ',
                                labelStyle: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.grey[900])),
                          ),),
                        ]),
                        DataRow(cells: [
                          DataCell(CheckboxListTile(
                              title: new Text(
                                ' ',
                                style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13.0,
                                    fontWeight: FontWeight.w600),
                              ),
                              value: _isChecked[9],
                              activeColor: Colors.orange[600],
                              onChanged: (bool value) {
                                onChanged10(value);
                              }),),
                          DataCell(Text('Encaminhar para seguro')),
                          DataCell(TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Sinistro n.',
                                labelStyle: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.grey[900])),
                          ),),
                        ]),
                        DataRow(cells: [
                          DataCell(Text(' ')),
                          DataCell(TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                              labelText: 'Número do registro CNH',
                              labelStyle: TextStyle(
                                  fontSize: 13.0,
                                  color: Colors.grey[900])),
                          ),
                            ),
                          DataCell(TextFormField(
                            controller: dataVencimentoController,
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Data de Vencimento',
                                labelStyle: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.grey[900])),
                          ),),

                        ]),
                        DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'CPF',
                                labelStyle: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.grey[900])),
                          ),
                          ),
                          DataCell(TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Idade',
                                labelStyle: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.grey[900])),
                          ),),

                        ]),
                        DataRow(cells: [
                          DataCell(Text(' ')),
                          DataCell(Text('Estado Civil')),
                          DataCell(Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Radio(
                                value: 1,
                                groupValue: idEstadoCivil,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItemEstadoCivil = 'ONE';
                                    idEstadoCivil = 1;
                                  });
                                },
                              ),
                              Text('Solteiro',
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 14.0)),
                              Radio(
                                value: 2,
                                groupValue: idEstadoCivil,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItemEstadoCivil = 'TWO';
                                    idEstadoCivil = 2;
                                  });
                                },
                              ),
                              Text('Casado',
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 14.0)),
                              Radio(
                                value: 3,
                                groupValue: idEstadoCivil,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItemEstadoCivil = 'THREE';
                                    idEstadoCivil = 3;
                                  });
                                },
                              ),
                              Text('Divorciado',
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 14.0)),
                              Radio(
                                value: 4,
                                groupValue: idEstadoCivil,
                                onChanged: (val) {
                                  setState(() {
                                    radioButtonItemEstadoCivil = 'FOUR';
                                    idEstadoCivil = 4;
                                  });
                                },
                              ),
                              Text('Viúvo',
                                  style: TextStyle(
                                      color: Colors.grey[800], fontSize: 14.0)),

                            ],
                          ),),
                        ]),
                        DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'BO n.',
                                labelStyle: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.grey[900])),
                          ),
                          ),
                          DataCell(TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'DP do BO',
                                labelStyle: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.grey[900])),
                          ),),

                        ]),
                        DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'IC',
                                labelStyle: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.grey[900])),
                          ),
                          ),
                          DataCell(Text(' ')),

                        ]),
                        DataRow(cells: [
                          DataCell(Text('')),
                          DataCell(TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Chassi',
                                labelStyle: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.grey[900])),
                          ),
                          ),
                          DataCell(TextFormField(
                            decoration: InputDecoration(
                                border: InputBorder.none,
                                labelText: 'Ano Fabricação\/Modelo',
                                labelStyle: TextStyle(
                                    fontSize: 13.0,
                                    color: Colors.grey[900])),
                          ),),

                        ]),
                      ],
                    ),
                  ),
                ),
              ]),
            )));
  }
}


String getPrettyJSONString(jsonObject) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String jsonString = encoder.convert(json.decode(jsonObject));
  return jsonString;
}


