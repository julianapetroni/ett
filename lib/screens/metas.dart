import 'package:flutter/material.dart';
import 'package:ett_app/style/lightColors.dart';

class MetasStatus extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}




