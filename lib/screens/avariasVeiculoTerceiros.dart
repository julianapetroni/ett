import 'dart:async';
import 'dart:io';
import 'package:ett_app/screens/testemunhas.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:ui';
import 'package:flutter/rendering.dart';
import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../style/lightColors.dart';
import "package:flutter/painting.dart";
import "package:flutter/foundation.dart";
import 'package:dropdown_formfield/dropdown_formfield.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:signature/signature.dart';
import 'package:ett_app/services/token.dart';

class AvariasVeiculoTerceiro extends StatefulWidget {
  Solicitacao sol;
  Usuario user;
  Token token;

  AvariasVeiculoTerceiro({Key key, this.sol, this.user, this.token})
      : super(key: key);

  @override
  AvariasVeiculoTerceiroState createState() {
    return AvariasVeiculoTerceiroState(sol: sol, user: user, token: token);
  }
}

class AvariasVeiculoTerceiroState extends State<AvariasVeiculoTerceiro> {
  Solicitacao sol;
  Usuario user;
  Token token;

  AvariasVeiculoTerceiroState({this.sol, this.user, this.token});

  //foto cnh
  //imagepicker
  File _image1;
  File _image;
  final picker = ImagePicker();

  Future getImage1(ImageSource src) async {
    File img1 = await ImagePicker.pickImage(
      source: src, // maxHeight: 50.0, maxWidth: 50.0
    );
    //final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image1 = File(img1.path);
    });
  }

  Future getImage(ImageSource src) async {
    File img = await ImagePicker.pickImage(
      source: src, //maxHeight: 50.0, maxWidth: 50.0
    );
    //final pickedFile = await picker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(img.path);
    });
  }

  final GlobalKey<FormFieldState<String>> _nomeKey =
      GlobalKey<FormFieldState<String>>();

  final _scaffoldKey = GlobalKey<ScaffoldState>();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = true;

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

  //Mask
  var telac1Controller = new MaskedTextController(mask: '(00)00000-0000');
  var telac2Controller = new MaskedTextController(mask: '(00)00000-0000');
  var data1Controller = new MaskedTextController(mask: '00/00/0000');
  var data2Controller = new MaskedTextController(mask: '00/00/0000');

  //Assinatura
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

  @override
  dispose() {
    _nomeController.dispose();
    _obsController.dispose();

    super.dispose();
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
  //var nbotoes = new List<int>(26);

  List<String> getListElements() {
    var items = List<String>.generate(13, (counter) => "$counter");
    return items;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.5;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM').format(now);
    String formattedTime = DateFormat('kk:mm:ss').format(now);

    @override
    void initState() {
      super.initState();

      _controller.addListener(() => print("Value changed"));
      _controllerTetst2.addListener(() => print("Value changed"));
      _dropDownCarroAvaria = ' ';
      _dropDownCarroAvariaResult = ' ';
      _dropDownCarro2Avaria = ' ';
      _dropDownCarro2AvariaResult = ' ';
      _dropDownMarcaCarroAvaria = ' ';
      _dropDownMarcaCarroAvariaResult = ' ';
      _dropDownMarcaCarro2Avaria = ' ';
      _dropDownMarcaCarro2AvariaResult = ' ';
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
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 20.0, bottom: 20.0),
                child: Row(
                  children: <Widget>[
                    Flexible(
                      child: Text(
                        'Avarias no veículo de terceiro:',
                        style: GoogleFonts.raleway(
                            color: Colors.black87,
                            fontSize: 17.0,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.7),
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
                    activeColor: Colors.black87,
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
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        haAvariaNoCarro = true;
                        radioButtonItem = 'ONE';
                        id = 1;
                      });
                    },
                    child: Text('PEQUENA',
                        style:
                            TextStyle(color: Colors.grey[800], fontSize: 14.0)),
                  )),
                  Radio(
                    activeColor: Colors.black87,
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
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          haAvariaNoCarro = true;
                          radioButtonItem = 'TWO';
                          id = 2;
                        });
                      },
                      child: Text('MÉDIA',
                          style: TextStyle(
                              color: Colors.grey[800], fontSize: 14.0)),
                    ),
                  ),
                  Radio(
                    activeColor: Colors.black87,
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
                      child: GestureDetector(
                    onTap: () {
                      setState(() {
                        haAvariaNoCarro = true;
                        radioButtonItem = 'THREE';
                        id = 3;
                      });
                    },
                    child: Text('GRANDE',
                        style:
                            TextStyle(color: Colors.grey[800], fontSize: 14.0)),
                  )),
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
                              image:
                                  AssetImage('images/carroAvariaComLinhas.jpg'),
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

                                  print('botao 1 deveria ser true: ' +
                                      botoes[0].toString());
                                },
                                child: botoes[0]
                                    ? Icon(
                                        Icons.cancel,
                                        color: Colors.black87,
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
                                        color: Colors.black87,
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
                                        color: Colors.black87,
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
                                        color: Colors.black87,
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
                                        color: Colors.black87,
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
                                        color: Colors.black87,
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
                                        color: Colors.black87,
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
                                        color: Colors.black87,
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
                                        color: Colors.black87,
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
                                        color: Colors.black87,
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
                                        color: Colors.black87,
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
                                        color: Colors.black87,
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
                          padding: const EdgeInsets.only(left: 158.0, top: 240),
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
                                        color: Colors.black87,
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
                                    color: Colors.black87,
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30.0, bottom: 20.0),
                                child: Container(
                                  color: Colors.grey[100],
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          'Foto da CNH',
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 16.0),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Stack(
                                          children: <Widget>[
                                            Center(
                                              child: FlatButton(
                                                onPressed: () {
                                                  //setState(() {});
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                            title: Text(
                                                              "Selecionar imagem da galeria ou tirar foto?",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      600]),
                                                            ),
                                                            content:
                                                                new Text(''),
                                                            actions: <Widget>[
                                                              new FlatButton(
                                                                onPressed:
                                                                    () async {
                                                                  Navigator.pop(
                                                                      context); //close the dialog box
                                                                  getImage1(
                                                                      ImageSource
                                                                          .gallery);
                                                                },
                                                                child:
                                                                    const Text(
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
                                                                  getImage1(
                                                                    ImageSource
                                                                        .camera,
                                                                  );
                                                                },
                                                                child:
                                                                    const Text(
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20.0),
                                                  child: Center(
                                                    child: IconButton(
                                                        icon: Icon(
                                                      Icons.add_a_photo,
                                                      color: Colors.black87,
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
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: _image1 == null
                                              ? Text(' ')
                                              : Image.file(
                                                  _image1,
                                                  scale: 50,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                    color: LightColors.neonYellowLight),
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
                                      padding: const EdgeInsets.only(right: 20),
                                      child: IconButton(
                                        icon: const Icon(Icons.clear),
                                        iconSize: 30,
                                        color: Colors.black87,
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
                              color: Colors.black87,
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Flexible(
                              child: Text(
                                'Adicionar segundo veículo',
                                style: TextStyle(
                                    color: Colors.black87, fontSize: 17.0),
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
                          activeColor: Colors.black87,
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
                            child: GestureDetector(
                          onTap: () {
                            setState(() {
                              radioButton2Item = 'ONE';
                              id2 = 1;
                            });
                          },
                          child: Text('PEQUENA',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 14.0)),
                        )),
                        Radio(
                          activeColor: Colors.black87,
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
                            child: GestureDetector(
                          onTap: () {
                            setState(() {
                              radioButton2Item = 'TWO';
                              id2 = 2;
                            });
                          },
                          child: Text('MÉDIA',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 14.0)),
                        )),
                        Radio(
                          activeColor: Colors.black87,
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
                            child: GestureDetector(
                          onTap: () {
                            setState(() {
                              radioButton2Item = 'THREE';
                              id2 = 3;
                            });
                          },
                          child: Text('GRANDE',
                              style: TextStyle(
                                  color: Colors.grey[800], fontSize: 14.0)),
                        )),
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
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
                                    color: Colors.black87,
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
                              Padding(
                                padding: const EdgeInsets.only(
                                    top: 30.0, bottom: 20.0),
                                child: Container(
                                  color: Colors.grey[100],
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Text(
                                          'Foto da CNH',
                                          style: TextStyle(
                                              color: Colors.grey[600],
                                              fontSize: 16.0),
                                        ),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(bottom: 10),
                                        child: Stack(
                                          children: <Widget>[
                                            Center(
                                              child: FlatButton(
                                                onPressed: () {
                                                  //setState(() {});
                                                  showDialog(
                                                      context: context,
                                                      builder: (BuildContext
                                                          context) {
                                                        return AlertDialog(
                                                            title: Text(
                                                              "Selecionar imagem da galeria ou tirar foto?",
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .grey[
                                                                      600]),
                                                            ),
                                                            content:
                                                                new Text(''),
                                                            actions: <Widget>[
                                                              new FlatButton(
                                                                onPressed:
                                                                    () async {
                                                                  Navigator.pop(
                                                                      context); //close the dialog box
                                                                  getImage(
                                                                      ImageSource
                                                                          .gallery);
                                                                },
                                                                child:
                                                                    const Text(
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
                                                                  getImage(
                                                                    ImageSource
                                                                        .camera,
                                                                  );
                                                                },
                                                                child:
                                                                    const Text(
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
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 20.0),
                                                  child: Center(
                                                    child: IconButton(
                                                        icon: Icon(
                                                      Icons.add_a_photo,
                                                      color: Colors.black87,
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
                                      Padding(
                                        padding: const EdgeInsets.all(10.0),
                                        child: Center(
                                          child: _image == null
                                              ? Text(' ')
                                              : Image.file(
                                                  _image,
                                                  scale: 50,
                                                ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
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
                                    color: LightColors.neonYellowLight),
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
                                      padding: const EdgeInsets.only(right: 20),
                                      child: IconButton(
                                        icon: const Icon(Icons.clear),
                                        iconSize: 30,
                                        color: Colors.black87,
                                        onPressed: () {
                                          setState(
                                              () => _controllerTetst2.clear());
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
                    left: 10, right: 10, top: 40, bottom: 40),
                child: FlatButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Testemunhas(
                                user: user,
                                token: token,
                                sol: sol,
                              )),
                    );
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
            ],
          ),
        ),
      ),
    );
  }
}
