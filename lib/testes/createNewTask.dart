//import 'package:flutter/material.dart';
////import 'package:flutter_task_planner_app/theme/colors/light_colors.dart';
////import 'package:flutter_task_planner_app/widgets/top_container.dart';
////import 'package:flutter_task_planner_app/widgets/back_button.dart';
////import 'package:flutter_task_planner_app/widgets/my_text_field.dart';
////import 'package:flutter_task_planner_app/screens/home_page.dart';
//
//class CreateNewTaskPage extends StatelessWidget {
//  @override
//  Widget build(BuildContext context) {
//    double width = MediaQuery.of(context).size.width;
//    var downwardIcon = Icon(
//      Icons.keyboard_arrow_down,
//      color: Colors.black54,
//    );
//    return Scaffold(
//      body: SafeArea(
//        child: Column(
//          children: <Widget>[
//            TopContainer(
//              padding: EdgeInsets.fromLTRB(20, 20, 20, 40),
//              width: width,
//              child: Column(
//                children: <Widget>[
//                  MyBackButton(),
//                  SizedBox(
//                    height: 30,
//                  ),
//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.start,
//                    children: <Widget>[
//                      Text(
//                        'Controle de Frequência de Linha',
//                        style: TextStyle(
//                            fontSize: 19.0, fontWeight: FontWeight.w700),
//                      ),
//                    ],
//                  ),
//                  SizedBox(height: 20),
//                  Container(
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          MyTextField(label: 'Title'),
//                          Row(
//                            mainAxisAlignment: MainAxisAlignment.start,
//                            crossAxisAlignment: CrossAxisAlignment.end,
//                            children: <Widget>[
//                              Expanded(
//                                child: MyTextField(
//                                  label: 'Date',
//                                  icon: downwardIcon,
//                                ),
//                              ),
//                              HomePage.calendarIcon(),
//                            ],
//                          )
//                        ],
//                      ))
//                ],
//              ),
//            ),
//            Expanded(
//                child: SingleChildScrollView(
//                  padding: EdgeInsets.symmetric(horizontal: 20),
//                  child: Column(
//                    children: <Widget>[
//                      Row(
//                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                        children: <Widget>[
//                          Expanded(
//                              child: MyTextField(
//                                label: 'Start Time',
//                                icon: downwardIcon,
//                              )),
//                          SizedBox(width: 40),
//                          Expanded(
//                            child: MyTextField(
//                              label: 'End Time',
//                              icon: downwardIcon,
//                            ),
//                          ),
//                        ],
//                      ),
//                      SizedBox(height: 20),
//                      MyTextField(
//                        label: 'Description',
//                        minLines: 3,
//                        maxLines: 3,
//                      ),
//                      SizedBox(height: 20),
//                      Container(
//                        alignment: Alignment.topLeft,
//                        child: Column(
//                          crossAxisAlignment: CrossAxisAlignment.start,
//                          children: <Widget>[
//                            Text(
//                              'Category',
//                              style: TextStyle(
//                                fontSize: 18,
//                                color: Colors.black54,
//                              ),
//                            ),
//                            Wrap(
//                              crossAxisAlignment: WrapCrossAlignment.start,
//                              //direction: Axis.vertical,
//                              alignment: WrapAlignment.start,
//                              verticalDirection: VerticalDirection.down,
//                              runSpacing: 0,
//                              //textDirection: TextDirection.rtl,
//                              spacing: 10.0,
//                              children: <Widget>[
//                                Chip(
//                                  label: Text("SPORT APP"),
//                                  backgroundColor: LightColors.kRed,
//                                  labelStyle: TextStyle(color: Colors.white),
//                                ),
//                                Chip(
//                                  label: Text("MEDICAL APP"),
//                                ),
//                                Chip(
//                                  label: Text("RENT APP"),
//                                ),
//                                Chip(
//                                  label: Text("NOTES"),
//                                ),
//                                Chip(
//                                  label: Text("GAMING PLATFORM APP"),
//                                ),
//                              ],
//                            ),
//                          ],
//                        ),
//                      )
//                    ],
//                  ),
//                )),
//            Container(
//              height: 80,
//              width: width,
//              child: Row(
//                crossAxisAlignment: CrossAxisAlignment.stretch,
//                children: <Widget>[
//                  Container(
//                    child: Text(
//                      'Create Task',
//                      style: TextStyle(
//                          color: Colors.white,
//                          fontWeight: FontWeight.w700,
//                          fontSize: 18),
//                    ),
//                    alignment: Alignment.center,
//                    margin: EdgeInsets.fromLTRB(20, 10, 20, 20),
//                    width: width - 40,
//                    decoration: BoxDecoration(
//                      color: LightColors.kBlue,
//                      borderRadius: BorderRadius.circular(30),
//                    ),
//                  ),
//                ],
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class LightColors  {
//  static const Color kLightYellow = Color(0xFFFFF9EC);
//  static const Color kLightYellow2 = Color(0xFFFFE4C7);
//  static const Color kDarkYellow = Color(0xFFF9BE7C);
//  static const Color kPalePink = Color(0xFFFED4D6);
//
//  static const Color kRed = Color(0xFFE46472);
//  static const Color kLavender = Color(0xFFD5E4FE);
//  static const Color kBlue = Color(0xFF6488E4);
//  static const Color kLightGreen = Color(0xFFD9E6DC);
//  static const Color kGreen = Color(0xFF309397);
//
//  static const Color kDarkBlue = Color(0xFF0D253F);
//}
//
//class TopContainer extends StatelessWidget {
//  final double height;
//  final double width;
//  final Widget child;
//  final EdgeInsets padding;
//  TopContainer({this.height, this.width, this.child, this.padding});
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//      padding: padding!=null ? padding : EdgeInsets.symmetric(horizontal: 20.0),
//      decoration: BoxDecoration(
//          color: LightColors.kDarkYellow,
//          borderRadius: BorderRadius.only(
//            bottomRight: Radius.circular(40.0),
//            bottomLeft: Radius.circular(40.0),
//          )),
//      height: height,
//      width: width,
//      child: child,
//    );
//  }
//}
//
//class MyBackButton extends StatelessWidget {
//
//
//  @override
//  Widget build(BuildContext context) {
//    return Hero(
//      tag: 'backButton',
//      child: GestureDetector(
//        onTap: (){
//          Navigator.pop(context);
//        },
//        child: Align(
//          alignment: Alignment.centerLeft,
//          child: Icon(
//            Icons.arrow_back_ios,
//            size: 25,
//            color: LightColors.kDarkBlue,
//          ),
//        ),
//      ),
//    );
//  }
//}
//
//class MyTextField extends StatelessWidget {
//  final String label;
//  final int maxLines;
//  final int minLines;
//  final Icon icon;
//  MyTextField({this.label, this.maxLines = 1, this.minLines = 1, this.icon});
//
//  @override
//  Widget build(BuildContext context) {
//    return TextField(
//
//      style: TextStyle(color: Colors.black87),
//      minLines: minLines,
//      maxLines: maxLines,
//      decoration: InputDecoration(
//          suffixIcon: icon == null ? null: icon,
//          labelText: label,
//          labelStyle: TextStyle(color: Colors.black45),
//
//          focusedBorder:
//          UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
//          border:
//          UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey))),
//    );
//  }
//}
//
//class HomePage extends StatelessWidget {
//  Text subheading(String title) {
//    return Text(
//      title,
//      style: TextStyle(
//          color: LightColors.kDarkBlue,
//          fontSize: 20.0,
//          fontWeight: FontWeight.w700,
//          letterSpacing: 1.2),
//    );
//  }
//  static CircleAvatar calendarIcon() {
//    return CircleAvatar(
//      radius: 25.0,
//      backgroundColor: LightColors.kGreen,
//      child: Icon(
//        Icons.calendar_today,
//        size: 20.0,
//        color: Colors.white,
//      ),
//    );
//  }
//
//  @override
//  Widget build(BuildContext context) {
//    double width = MediaQuery.of(context).size.width;
//    return Scaffold(
//      backgroundColor: LightColors.kLightYellow,
//      body: SafeArea(
//        child: Column(
//          children: <Widget>[
//            TopContainer(
//              height: 200,
//              width: width,
//              child: Column(
//                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                  children: <Widget>[
//                    Row(
//                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        Icon(Icons.menu,
//                            color: LightColors.kDarkBlue, size: 30.0),
//                        Icon(Icons.search,
//                            color: LightColors.kDarkBlue, size: 25.0),
//                      ],
//                    ),
////                    Padding(
////                      padding: const EdgeInsets.symmetric(
////                          horizontal: 0, vertical: 0.0),
////                      child: Row(
////                        crossAxisAlignment: CrossAxisAlignment.center,
////                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
////                        children: <Widget>[
////                          CircularPercentIndicator(
////                            radius: 90.0,
////                            lineWidth: 5.0,
////                            animation: true,
////                            percent: 0.75,
////                            circularStrokeCap: CircularStrokeCap.round,
////                            progressColor: LightColors.kRed,
////                            backgroundColor: LightColors.kDarkYellow,
////                            center: CircleAvatar(
////                              backgroundColor: LightColors.kBlue,
////                              radius: 35.0,
////                              backgroundImage: AssetImage(
////                                'assets/images/avatar.png',
////                              ),
////                            ),
////                          ),
////                          Column(
////                            crossAxisAlignment: CrossAxisAlignment.center,
////                            children: <Widget>[
////                              Container(
////                                child: Text(
////                                  'Sourav Suman',
////                                  textAlign: TextAlign.start,
////                                  style: TextStyle(
////                                    fontSize: 22.0,
////                                    color: LightColors.kDarkBlue,
////                                    fontWeight: FontWeight.w800,
////                                  ),
////                                ),
////                              ),
////                              Container(
////                                child: Text(
////                                  'App Developer',
////                                  textAlign: TextAlign.start,
////                                  style: TextStyle(
////                                    fontSize: 16.0,
////                                    color: Colors.black45,
////                                    fontWeight: FontWeight.w400,
////                                  ),
////                                ),
////                              ),
////                            ],
////                          )
////                        ],
////                      ),
////                    )
//                  ]),
//            ),
//            Expanded(
//              child: SingleChildScrollView(
//                child: Column(
//                  children: <Widget>[
//                    Container(
//                      color: Colors.transparent,
//                      padding: EdgeInsets.symmetric(
//                          horizontal: 20.0, vertical: 10.0),
//                      child: Column(
//                        children: <Widget>[
//                          Row(
//                            crossAxisAlignment: CrossAxisAlignment.center,
//                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                            children: <Widget>[
//                              subheading('My Tasks'),
//                              GestureDetector(
//                                onTap: () {
////                                  Navigator.push(
////                                    context,
////                                    MaterialPageRoute(
////                                        builder: (context) => CalendarPage()),
////                                  );
//                                },
//                                child: calendarIcon(),
//                              ),
//                            ],
//                          ),
//                          SizedBox(height: 15.0),
//                          TaskColumn(
//                            icon: Icons.alarm,
//                            iconBackgroundColor: LightColors.kRed,
//                            title: 'To Do',
//                            subtitle: '5 tasks now. 1 started',
//                          ),
//                          SizedBox(
//                            height: 15.0,
//                          ),
//                          TaskColumn(
//                            icon: Icons.blur_circular,
//                            iconBackgroundColor: LightColors.kDarkYellow,
//                            title: 'In Progress',
//                            subtitle: '1 tasks now. 1 started',
//                          ),
//                          SizedBox(height: 15.0),
//                          TaskColumn(
//                            icon: Icons.check_circle_outline,
//                            iconBackgroundColor: LightColors.kBlue,
//                            title: 'Done',
//                            subtitle: '18 tasks now. 13 started',
//                          ),
//                        ],
//                      ),
//                    ),
//                    Container(
//                      color: Colors.transparent,
//                      padding: EdgeInsets.symmetric(
//                          horizontal: 20.0, vertical: 10.0),
//                      child: Column(
//                        crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          subheading('Active Projects'),
//                          SizedBox(height: 5.0),
//                          Row(
//                            children: <Widget>[
//                              ActiveProjectsCard(
//                                cardColor: LightColors.kGreen,
//                                loadingPercent: 0.25,
//                                title: 'Medical App',
//                                subtitle: '9 hours progress',
//                              ),
//                              SizedBox(width: 20.0),
//                              ActiveProjectsCard(
//                                cardColor: LightColors.kRed,
//                                loadingPercent: 0.6,
//                                title: 'Making History Notes',
//                                subtitle: '20 hours progress',
//                              ),
//                            ],
//                          ),
//                          Row(
//                            children: <Widget>[
//                              ActiveProjectsCard(
//                                cardColor: LightColors.kDarkYellow,
//                                loadingPercent: 0.45,
//                                title: 'Sports App',
//                                subtitle: '5 hours progress',
//                              ),
//                              SizedBox(width: 20.0),
//                              ActiveProjectsCard(
//                                cardColor: LightColors.kBlue,
//                                loadingPercent: 0.9,
//                                title: 'Online Flutter Course',
//                                subtitle: '23 hours progress',
//                              ),
//                            ],
//                          ),
//                        ],
//                      ),
//                    ),
//                  ],
//                ),
//              ),
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class ActiveProjectsCard extends StatelessWidget {
//  final Color cardColor;
//  final double loadingPercent;
//  final String title;
//  final String subtitle;
//
//  ActiveProjectsCard({
//    this.cardColor,
//    this.loadingPercent,
//    this.title,
//    this.subtitle,
//  });
//
//  @override
//  Widget build(BuildContext context) {
//    return Expanded(
//      flex: 1,
//      child: Container(
//
//        margin: EdgeInsets.symmetric(vertical: 10.0),
//        padding: EdgeInsets.all(15.0),
//        height: 200,
//        decoration: BoxDecoration(
//          color: cardColor,
//          borderRadius: BorderRadius.circular(40.0),
//        ),
//        child: Column(
//          mainAxisAlignment: MainAxisAlignment.spaceBetween,
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
////            Padding(
////              padding: const EdgeInsets.all(10.0),
////              child: CircularPercentIndicator(
////                animation: true,
////                radius: 75.0,
////                percent: loadingPercent,
////                lineWidth: 5.0,
////                circularStrokeCap: CircularStrokeCap.round,
////                backgroundColor: Colors.white10,
////                progressColor: Colors.white,
////                center: Text(
////                  '${(loadingPercent*100).round()}%',
////                  style: TextStyle(
////                      fontWeight: FontWeight.w700, color: Colors.white),
////                ),
////              ),
////            ),
//            Column(
//              crossAxisAlignment: CrossAxisAlignment.start,
//              children: <Widget>[
//                Text(
//                  title,
//                  style: TextStyle(
//                    fontSize: 14.0,
//                    color: Colors.white,
//                    fontWeight: FontWeight.w700,
//                  ),
//                ),
//                Text(
//                  subtitle,
//                  style: TextStyle(
//                    fontSize: 12.0,
//                    color: Colors.white54,
//                    fontWeight: FontWeight.w400,
//                  ),
//                ),
//              ],
//            ),
//          ],
//        ),
//      ),
//    );
//  }
//}
//
//class CalendarDates extends StatelessWidget {
//  final String day;
//  final String date;
//  final Color dayColor;
//  final Color dateColor;
//
//  CalendarDates({this.day, this.date, this.dayColor, this.dateColor});
//
//  @override
//  Widget build(BuildContext context) {
//    return Padding(
//      padding: const EdgeInsets.only(right: 20.0),
//      child: Column(
//        children: <Widget>[
//          Text(
//            day,
//            style: TextStyle(
//                fontSize: 16, color: dayColor, fontWeight: FontWeight.w400),
//          ),
//          SizedBox(height: 10.0),
//          Text(
//            date,
//            style: TextStyle(
//                fontSize: 16, color: dateColor, fontWeight: FontWeight.w700),
//          ),
//        ],
//      ),
//    );
//  }
//}
//
//class TaskColumn extends StatelessWidget {
//  final IconData icon;
//  final Color iconBackgroundColor;
//  final String title;
//  final String subtitle;
//  TaskColumn({
//    this.icon,
//    this.iconBackgroundColor,
//    this.title,
//    this.subtitle,
//  });
//  @override
//  Widget build(BuildContext context) {
//    return Row(
//      crossAxisAlignment: CrossAxisAlignment.center,
//      children: <Widget>[
//        CircleAvatar(
//          radius: 20.0,
//          backgroundColor: iconBackgroundColor,
//          child: Icon(
//            icon,
//            size: 15.0,
//            color: Colors.white,
//          ),
//        ),
//        SizedBox(width: 10.0),
//        Column(
//          crossAxisAlignment: CrossAxisAlignment.start,
//          children: <Widget>[
//            Text(
//              title,
//              style: TextStyle(
//                fontSize: 16.0,
//                fontWeight: FontWeight.w700,
//              ),
//            ),
//            Text(
//              subtitle,
//              style: TextStyle(
//                  fontSize: 14.0,
//                  fontWeight: FontWeight.w500,
//                  color: Colors.black45),
//            ),
//          ],
//        )
//      ],
//    );
//  }
//}

import 'package:flutter/material.dart';

class CreateNewTaskPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: DefaultTabController(
        length: choices.length,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Tabbed AppBar'),
            bottom: TabBar(
              isScrollable: true,
              tabs: choices.map<Widget>((Choice choice) {
                return Tab(
                  text: choice.title,
                  icon: Icon(choice.icon),
                );
              }).toList(),
            ),
          ),
          body: TabBarView(
            children: choices.map((Choice choice) {
              return Padding(
                padding: const EdgeInsets.all(20.0),
                child: ChoicePage(
                  choice: choice,
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}

class Choice {
  final String title;
  final IconData icon;
  const Choice({this.title, this.icon});
}

const List<Choice> choices = <Choice>[
  Choice(title: 'CAR', icon: Icons.directions_car),
  Choice(title: 'BICYCLE', icon: Icons.directions_bike),
  Choice(title: 'BUS', icon: Icons.directions_bus),
  Choice(title: 'TRAIN', icon: Icons.directions_railway),
  Choice(title: 'WALK', icon: Icons.directions_walk),
  Choice(title: 'BOAT', icon: Icons.directions_boat),
];

class ChoicePage extends StatelessWidget {
  const ChoicePage({Key key, this.choice}) : super(key: key);
  final Choice choice;

  @override
  Widget build(BuildContext context) {
    final TextStyle textStyle = Theme.of(context).textTheme.display1;
    return Card(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Icon(
              choice.icon,
              size: 150.0,
              color: textStyle.color,
            ),
            Text(
              choice.title,
              style: textStyle,
            ),
          ],
        ),
      ),
    );
  }
}