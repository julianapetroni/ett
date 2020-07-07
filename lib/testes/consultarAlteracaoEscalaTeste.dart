import 'package:ett_app/models/user.dart';
import 'package:ett_app/services/services.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class ConsultarAlteracaoEscalaTeste extends StatefulWidget {
  ConsultarAlteracaoEscalaTeste() : super();

  @override
  ConsultarAlteracaoEscalaTesteState createState() => ConsultarAlteracaoEscalaTesteState();
}

class Debouncer {
  final int milliseconds;
  VoidCallback action;
  Timer _timer;

  Debouncer({this.milliseconds});

  run(VoidCallback action) {
    if (null != _timer) {
      _timer.cancel();
    }
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }
}

class ConsultarAlteracaoEscalaTesteState extends State<ConsultarAlteracaoEscalaTeste>
{
  // https://jsonplaceholder.typicode.com/users

  final _debouncer = Debouncer(milliseconds: 500);
  List<User> users = List();
  List<User> filteredUsers = List();

  @override
  void initState() {
    super.initState();
    Services.getUsers().then((usersFromServer) {
      setState(() {
        users = usersFromServer;
        filteredUsers = users;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: new IconThemeData(color: Colors.grey[600]),
        title: Center(
            child: Text(
              ' ',
              style: TextStyle(color: Colors.grey[700]),
            )),
        backgroundColor: Colors.yellow[800],
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 30.0, top: 30.0),
            child: Container(
              child: Text("Alteração de Escala - Consultar",
                  style: TextStyle(
                      fontSize: 19.0,
                      color: Colors.grey[700],
                      fontFamily: "Poppins-Bold",
                      letterSpacing: .6)),
            ),
          ),
          SizedBox(
            height: 30.0,
          ),

          Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: TextField(
              decoration: InputDecoration(
                //contentPadding: EdgeInsets.all(15.0),
                hintText: 'Pesquisar',
              ),
              onChanged: (string) {
                _debouncer.run(() {
                  setState(() {
                    filteredUsers = users
                        .where((u) => (u.name
                        .toLowerCase()
                        .contains(string.toLowerCase()) ||
                        u.email.toLowerCase().contains(string.toLowerCase())))
                        .toList();
                  });
                });
              },
            ),
          ),
          SizedBox(
            height: 10.0,
          ),

          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.all(10.0),
             // scrollDirection: Axis.horizontal,
              itemCount: filteredUsers.length,
              itemBuilder: (BuildContext context, int index) {
                return

//                DataTable(
//                    onSelectAll: (b) {},
//                    sortColumnIndex: 1,
//                    sortAscending: true,
//                    columns: <DataColumn>[
//                      DataColumn(
//                        label: Text("Nome"),
//                        numeric: false,
//                        onSort: (i, b) {
//                          print("$i $b");
//                          setState(() {
//                            filteredUsers.sort((a, b) => a.name.compareTo(b.name));
//                          });
//                        },
//                        tooltip: "Crescente",
//                      ),
//                      DataColumn(
//                        label: Text("Email"),
//                        numeric: false,
//                        onSort: (i, b) {
//                          print("$i $b");
//                          setState(() {
//                            filteredUsers.sort((a, b) => a.name.compareTo(b.name));
//                          });
//                        },
//                        tooltip: "To display last name of the Name",
//                      ),
//                    ],
//                    rows: filteredUsers
//                        .map(
//                          (users) => DataRow(
//                        cells: [
//                          DataCell(
//                            Text(filteredUsers[index].name),
//                            showEditIcon: false,
//                            placeholder: false,
//                          ),
//                          DataCell(
//                            Text(filteredUsers[index].email.toLowerCase()),
//                            showEditIcon: false,
//                            placeholder: false,
//                          )
//                        ],
//                      ),
//                    )
//                        .toList());
////
                  Column(
                    children: <Widget>[

                      Card(
                        //leading: Text('${filteredUsers[index].id}'),
                        child: Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Container(
                                //width: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      filteredUsers[index].name,
                                      style: TextStyle(
                                        fontSize: 16.0,
                                        color: Colors.black87,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Spacer(),
                              Container(
                                //width: 150,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Text(
                                      filteredUsers[index].email.toLowerCase(),
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Colors.grey,
                                      ),
                            ),
                                  ],
                                ),
                              ),
                          ],
                        ),
                      ),

                ),
                    ],
                  );
              },
            ),
          ),
        ],
      ),
    );
  }
}