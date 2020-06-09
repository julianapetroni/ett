import 'package:flutter/material.dart';
import 'package:ett_app/models/forms.dart';
import 'package:ett_app/utils/validators.dart';
import 'package:ett_app/domains/usuario.dart';
import 'package:flutter/services.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class FormComunicadoInterno extends StatefulWidget {

  Usuario user;

  FormComunicadoInterno(
      {Key key,
        // this.value,
        this.user})
      : super(key: key);

  @override
  FormComunicadoInternoState createState() {
    return FormComunicadoInternoState(user: user);
  }
}

  class FormComunicadoInternoState extends State<FormComunicadoInterno> {

    Usuario user;

    FormComunicadoInternoState({this.user});

    //mask
    var dataController = new MaskedTextController(mask: '00/00/0000');
    var horaController = new MaskedTextController(mask: '00:00:00');

  List data = List();

  int _charCount = 700;

  _onChanged(String value) {
    setState(() {
      _charCount = 700 - value.length;
    });
  }

  String _mySelection;
  String _mySelectionSentido;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<FormFieldState<String>> _dataKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _horaKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _veiculoKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _chapaKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _nomeKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _localKey =
  GlobalKey<FormFieldState<String>>();
  final GlobalKey<FormFieldState<String>> _mensagemKey =
  GlobalKey<FormFieldState<String>>();

  LoginFormData _loginData = LoginFormData();
  bool _autovalidate = false;

  final _dataController = TextEditingController();
  final _horaController = TextEditingController();
  final _veiculoController = TextEditingController();
  final _chapaController = TextEditingController();
  final _nomeController = TextEditingController();
  final _localController = TextEditingController();
  final _mensagemController = TextEditingController();

  TextEditingController _textFieldController = TextEditingController();

  //Linha e Sentido
    bool linha = false;
    bool sentido = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        SizedBox(
          height: 10.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, top: 5.0),
          child: Text("F-010 Comunicado Interno",
              style: TextStyle(
                  fontSize: 19.0,
                  color: Colors.grey[700],
                  fontFamily: "Poppins-Bold",
                  letterSpacing: .6)),
        ),
        SizedBox(
          height: 30.0,
        ),
        SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0),
          child: Row(
            children: <Widget>[
              Text(
                'Data: *',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17.0),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0),
          child: TextFormField(
            key: _dataKey,
            controller: dataController,
            validator: composeValidators('a data', [
              requiredValidator,
              dataValidator
            ]
            ),
            onSaved: (value) =>
            _loginData.foraDeServico = value,
            decoration: InputDecoration(
                hintText: ''),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0),
          child: Row(
            children: <Widget>[
              Text(
                'Hora: *',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17.0),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0),
          child: TextFormField(
            key: _horaKey,
            controller: horaController,
            validator: composeValidators('a hora', [
              requiredValidator,
              minLegthValidator]),
            onSaved: (value) =>
            _loginData.hora = value,
            decoration: InputDecoration(
                hintText: ''),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0),
          child: Row(
            children: <Widget>[

              Flexible(
                child: Text(
                  'Chapa do funcionário associado:',
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 17.0),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10.0),
          child: TextFormField(
            key: _chapaKey,
            controller: _chapaController,
            validator: composeValidators('a chapa', [
              minLegthValidator
            ]),
            onSaved: (value) =>
            _loginData.chapa = value,
            decoration: InputDecoration(
                hintText: ''),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0),
          child: Row(
            children: <Widget>[

              Text(
                'Nome:',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17.0),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10.0),
          child: TextFormField(
            key: _nomeKey,
            controller: _nomeController,
            validator: composeValidators('o nome', [
              minLegthValidator
            ]),
            onSaved: (value) =>
            _loginData.veiculo = value,
            decoration: InputDecoration(
                hintText: ''),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0),
          child: Row(
            children: <Widget>[

              Text(
                'Veículo:',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17.0),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10.0),
          child: TextFormField(
            key: _veiculoKey,
            controller: _veiculoController,
            validator: composeValidators('o veículo', [
              minLegthValidator
            ]),
            onSaved: (value) =>
            _loginData.veiculo = value,
            decoration: InputDecoration(
                hintText: ''),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0),
          child: Row(
            children: <Widget>[

              Text(
                'Local da ocorrência:',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17.0),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0, top: 10.0),
          child: TextFormField(
            key: _localKey,
            controller: _localController,
            validator: composeValidators('o local da ocorrência', [
              minLegthValidator
            ]),
            onSaved: (value) =>
            _loginData.local = value,
            decoration: InputDecoration(
                hintText: ''),
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0),
          child: Row(
            children: <Widget>[

              Text(
                'Linha:',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17.0),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: DropdownButton(
            items: data.map((item) {
              return new DropdownMenuItem(
                child: new Text(item['item_name']),
                value: item['id'].toString(),
              );
            }).toList(),
            onChanged: (newVal) {
              setState(() {
                linha = true;
                _mySelection = newVal;
              });
            },
            value: _mySelection,
            isExpanded: true,
            hint: Text('Selecione a linha'),
          ),
        ),

        SizedBox(
          height: 20.0,
        ),

        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0),
          child: Row(
            children: <Widget>[

              Text(
                'Sentido:',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17.0),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0),
          child: DropdownButton(
            items: data.map((item) {
              return new DropdownMenuItem(
                child: new Text(item['item_name']),
                value: item['id'].toString(),
              );
            }).toList(),
            onChanged: (valSentido) {
              setState(() {
                sentido = true;
                _mySelectionSentido = valSentido;
              });
            },
            value: _mySelectionSentido,
            isExpanded: true,
            hint: Text('Selecione o sentido'),
          ),
        ),

        SizedBox(
          height: 20.0,
        ),

        Padding(
          padding: const EdgeInsets.only(
              left: 20.0, right: 20.0),
          child: Row(
            children: <Widget>[

              Text(
                'Mensagem:',
                style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 17.0),
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
              child: Text( _charCount.toString() + " caracteres restantes",
                  style: TextStyle(color: Colors.grey[600],
                      fontSize: 12.0)),
            ),
          ],
        ),
      ],
    );
  }
}




