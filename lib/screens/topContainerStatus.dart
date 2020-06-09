import 'package:ett_app/style/topContainer.dart';
import 'package:flutter/material.dart';
import 'package:ett_app/style/lightColors.dart';

class TopContainerStatus extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return TopContainer(
      padding: EdgeInsets.only(left: 20, right: 20),
      width: width,
      child: Column(
        children: <Widget>[
          //MyBackButton(),
          SizedBox(
            height: 30,
          ),
          Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: Text(
                  'Como estamos nas Metas?', textAlign: TextAlign.justify,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),
              //SizedBox(height: 10.0,),
              Text(
                '- Novembro/2019', textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              SizedBox(height: 10.0,),
            ],
          ),
          SizedBox(height: 20),
          Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  //MyTextField(label: 'Title'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
//                                Expanded(
//                                  child: MyTextField(
//                                    label: 'Date',
//                                    icon: downwardIcon,
//                                  ),
//                                ),
//                                HomePage.calendarIcon(),
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }
}




