import 'dart:io';

import 'package:ett_app/domains/solicitacao.dart';
import 'package:ett_app/screens/ponto/ui/ponto.strings.dart';
import 'package:ett_app/services/token.dart';
import 'package:ett_app/style/light_colors.dart';
import 'package:ett_app/style/top_container.dart';
import 'package:ett_app/widgets/dialog/alert_dialog_form.dart';
import 'package:ett_app/widgets/formUI/button/button_decoration.dart';
import 'package:ett_app/widgets/formUI/text_pattern/text_row.dart';
import 'package:flutter/cupertino.dart';
import 'package:ett_app/generalConfig/generalConfig.strings.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/style/size_config.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter_analog_clock/flutter_analog_clock.dart';
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';

import '../../dashboard/ui/dasboard.page.dart';

class CartaoDePonto extends StatefulWidget {
  Usuario user;
  Token token;
  Solicitacao sol;

  CartaoDePonto({Key key, this.user, this.token, this.sol}) : super(key: key);

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

  bool _geolocalizacao = false;
  bool _tirarFoto = true;

  final _nomeController = TextEditingController();

  var matriculaController = new MaskedTextController(mask: '000000');

  @override
  dispose() {
    _nomeController.dispose();

    super.dispose();
  }

  @override
  initState() {
    super.initState();
  }

  bool toggle = true;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Colors.white,
      body: _buildBody(context),
      floatingActionButton: _buildButton(context),
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return AppBar(
      title: Padding(
        padding:
            const EdgeInsets.only(top: 100, left: 70, right: 130, bottom: 100),
        child: Image.asset(GeneralConfig.logoImage),
      ),
      backgroundColor: LightColors.neonYellowLight,
      elevation: 0.0,
      iconTheme: new IconThemeData(color: LightColors.neonYellowDark),
    );
  }

  Widget _buildBody(BuildContext context) {
    double width = MediaQuery.of(context).size.width / 1.22;
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('d MMM').format(now);
    String formattedTime = DateFormat('kk:mm:ss').format(now);
    return SafeArea(
      right: false,
      left: false,
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
                  secondHandColor: LightColors.kRed,
                  numberColor: Colors.grey[600],
                  borderColor: LightColors.neonETT,
                  tickColor: Colors.grey[300],
                  centerPointColor: LightColors.kRed,
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
                  TextRow(CartaoDePontoStrings.title, Colors.black87),
                  SizedBox(
                    height: 40.0,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(CartaoDePontoStrings.name,
                          style: GeneralConfig.subtitleStyle),
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
                          style: GoogleFonts.poppins(
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
                        CartaoDePontoStrings.date,
                        style: GoogleFonts.poppins(
                            fontSize: 17.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        formattedDate,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.poppins(
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
                        CartaoDePontoStrings.startTime,
                        style: GoogleFonts.poppins(
                            fontSize: 17.0,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold),
                      ),
                      Spacer(),
                      Text(
                        formattedTime,
                        textAlign: TextAlign.end,
                        style: GoogleFonts.poppins(
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
                        Visibility(
                          visible: false,
                          child: Row(
                            children: [
                              Text(
                                CartaoDePontoStrings.place,
                                style: GoogleFonts.poppins(
                                    fontSize: 17.0,
                                    color: Colors.black87,
                                    fontWeight: FontWeight.bold),
                              ),
                              Expanded(
                                child: Text(
                                  _naETT,
                                  // _locationMessage,
                                  textAlign: TextAlign.end,
                                  style: GoogleFonts.poppins(
                                      fontSize: 17.0, color: Colors.black87),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              CartaoDePontoStrings.photo,
                              style: GoogleFonts.poppins(
                                  fontSize: 17.0,
                                  color: Colors.black87,
                                  fontWeight: FontWeight.bold),
                            ),
                            Spacer(),
                            Expanded(
                              child: Container(
                                child: _image == null
                                    ? Text(
                                        CartaoDePontoStrings.noPhoto,
                                        style: GoogleFonts.poppins(
                                            fontSize: 17.0, color: Colors.red),
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
        ],
      ),
    );
  }

  Widget _buildButton(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30),
      child: Stack(
        children: [
          Visibility(
            visible: _tirarFoto,
            child: ButtonDecoration(
              buttonTitle: CartaoDePontoStrings.addPhoto,
              shouldHaveIcon: true,
              icon: Icons.add_a_photo,
              sizedBox: 50.0,
              onPressed: () async {
                getImage();
                _getCurrentLocation();

                setState(() {
                  _geolocalizacao = true;
                  _tirarFoto = false;
                });
              },
            ),
          ),
          Visibility(
            visible: _geolocalizacao,
            child: ButtonDecoration(
              buttonTitle: CartaoDePontoStrings.register,
              shouldHaveIcon: false,
              onPressed: () {
                setState(() {
                  //
                });

                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    // return object of type Dialog
                    return AlertDialogForm(
                      textAlert: CartaoDePontoStrings.success,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    );
                  },
                );
                Future.delayed(Duration(seconds: 3), () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DashboardScreen(
                              user: user,
                              token: token,
                              sol: sol,
                            )),
                  );
                });
              },
            ),
          ),
        ],
      ),
    );
  }

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
}

String getPrettyJSONString(jsonObject) {
  JsonEncoder encoder = new JsonEncoder.withIndent('  ');
  String jsonString = encoder.convert(json.decode(jsonObject));
  return jsonString;
}
