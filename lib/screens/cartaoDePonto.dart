import 'dart:io';

import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/services/token.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/widgets/buttonDecoration.dart';
import 'package:ett_app/widgets/inputFormWithDecoration.dart';
import 'package:ett_app/widgets/logoETTForm.dart';
import 'package:ett_app/widgets/textRow.dart';
import 'package:ett_app/widgets/titleFormBold.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/style/sizeConfig.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter/widgets.dart';
import '../style/lightColors.dart';
import 'dasboardScreen.dart';
import '../style/topContainer.dart';
import 'package:geolocator/geolocator.dart';

class CartaoDePonto extends StatefulWidget {
  Usuario user;
  Token token;
  Solicitacao sol;

  CartaoDePonto(
      {Key key,
      // this.value,
      this.user,
      this.token,
      this.sol})
      : super(key: key);

  @override
  CartaoDePontoState createState() {
    return CartaoDePontoState(user: user, token: token, sol: sol);
  }
}

class CartaoDePontoState extends State<CartaoDePonto> {
  Usuario user;
  Token token;
  Solicitacao sol;

  CartaoDePontoState({this.user, this.token, this.sol});

  File _image;
  final picker = ImagePicker();

  Future<void> getImage() async {
    var image = await ImagePicker.pickImage(source: ImageSource.camera);
    setState(() {
      _image = image;
    });
  }

  String _locationMessage = "";
  String _naETT = "";

  Future<void> _getCurrentLocation() async {
    final position = await Geolocator()
        .getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(position);

    setState(() {
      _locationMessage = "${position.latitude}, ${position.longitude}";
      position.latitude == -23.540299 && position.longitude == -46.833385
          ? _naETT = "ETT Carapicuíba"
          : _naETT = "Fora da empresa";
    });
  }

  bool _geolocalizacao = false;
  bool _tirarFoto = true;

  final _nomeController = TextEditingController();

  var matriculaController = new MaskedTextController(mask: '000000');

  @override
  dispose() {
    _nomeController.dispose();

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

  @override
  initState() {
    super.initState();
    fetchData();
  }

  bool toggle = true;

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

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 1.22;
    final halfMediaWidth = MediaQuery.of(context).size.width / 2.5;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM').format(now);
    String formattedTime = DateFormat('kk:mm:ss').format(now);

    SizeConfig().init(context);
    var heightLogoETT = 80.0;

    return Scaffold(
      appBar: AppBar(
        title: Padding(
          padding: const EdgeInsets.only(
              top: 100, left: 70, right: 130, bottom: 100),
          child: Image.asset('images/logo-slim.png'),
        ),
        backgroundColor: LightColors.neonYellowLight,
        elevation: 0.0,
        iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: ListView(
          children: <Widget>[
            TopContainer(
              padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 40.0),
              width: width,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 30.0),
                  FlutterAnalogClock(
                    dateTime: DateTime.now(),
                    dialPlateColor: Colors.white,
                    hourHandColor: Colors.black,
                    minuteHandColor: Colors.black,
                    secondHandColor: LightColors.neonYellowDark,
                    numberColor: Colors.grey[600],
                    borderColor: LightColors.neonETT,
                    tickColor: Colors.grey[300],
                    centerPointColor: LightColors.neonYellowDark,
                    showBorder: false,
                    showTicks: true,
                    showMinuteHand: true,
                    showSecondHand: true,
                    showNumber: true,
                    borderWidth: 8.0,
                    hourNumberScale: 0.70,
                    isLive: true,
                    width: 200.0,
                    height: 200.0,
                    decoration: const BoxDecoration(),
                    child: Text(''),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
              child: Container(
                child: Column(
                  children: <Widget>[
                    TextRow('Registro de ponto', Colors.black87),
                    SizedBox(
                      height: 40.0,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nome: ',
                          style: GoogleFonts.montserrat(
                              fontSize: 17.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 20.0,
                        ),
                        Expanded(
                          child: Text(
                            '${user.nome}',
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                            softWrap: false,
                            textAlign: TextAlign.end,
                            style: GoogleFonts.montserrat(
                              fontSize: 17.0,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Data: ',
                          style: GoogleFonts.montserrat(
                              fontSize: 17.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          formattedDate,
                          textAlign: TextAlign.end,
                          style: GoogleFonts.montserrat(
                            fontSize: 17.0,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Row(
                      children: [
                        Text(
                          'Hora início: ',
                          style: GoogleFonts.montserrat(
                              fontSize: 17.0,
                              color: Colors.black87,
                              fontWeight: FontWeight.bold),
                        ),
                        Spacer(),
                        Text(
                          formattedTime,
                          textAlign: TextAlign.end,
                          style: GoogleFonts.montserrat(
                            fontSize: 17.0,
                            color: Colors.black87,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20.0,
                    ),
                    Visibility(
                      visible: _geolocalizacao,
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                'Local: ',
                                style: GoogleFonts.montserrat(
                                    fontSize: 17.0,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  _naETT,
                                  // _locationMessage,
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.montserrat(
                                      fontSize: 17.0, color: Colors.black87),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 20.0,
                          ),
                          Row(
                            children: [
                              Text(
                                'Foto: ',
                                style: GoogleFonts.montserrat(
                                    fontSize: 17.0,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              Spacer(),
                              Expanded(
                                child: Container(
                                  child: _image == null
                                      ? Text(
                                          'Sem imagem selecionada.',
                                          style: GoogleFonts.montserrat(
                                              fontSize: 17.0,
                                              color: Colors.red),
                                        )
                                      : Image.file(
                                          _image,
                                          scale: 30,
                                        ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Stack(
              children: [
                Visibility(
                  visible: _tirarFoto,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 40, bottom: 40),
                    child: FlatButton(
                        onPressed: () async {
                          getImage();
                          _getCurrentLocation();

                          setState(() {
                            _geolocalizacao = true;
                            _tirarFoto = false;
                          });
                        },
                        textColor: Colors.white,
                        color: Colors.white,
                        child: Container(
                          width: double.infinity,
                          height: 45.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25.0),
                            gradient: LinearGradient(
                              colors: <Color>[
                                Colors.black87,
                                Colors.black54,
                                Colors.black45,
                              ],
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.add_a_photo),
                              SizedBox(
                                width: 20,
                              ),
                              Text('ADICIONAR FOTO',
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        )),
                  ),
                ),
                Visibility(
                  visible: _geolocalizacao,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 10, right: 10, top: 40, bottom: 40),
                    child: FlatButton(
                      onPressed: () {
                        setState(() {
                          //
                        });
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => DashboardScreen(
                                    user: user,
                                    token: token,
                                    sol: sol,
                                  )),
                        );
                      },
                      textColor: Colors.white,
                      color: Colors.white,
                      child: ButtonDecoration('REGISTRAR PONTO'),
                    ),
                  ),
                ),
              ],
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
