import 'package:flutter/material.dart';
import 'package:ett_app/style/lightColors.dart';

class TableStatus extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
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
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: //TabelaStatus()
            DataTable(
//                        sortColumnIndex: 0,
//                        sortAscending: true,
//                      columnSpacing: widget.columnSpacing,
//                      horizontalMargin: widget.horizontalMargin,
              dataRowHeight: 50.0,
              columns: [
                //DataColumn(label: Text(' '), numeric: true),
                DataColumn(label: Text('Meta', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[800]),)),
                DataColumn(label: Text('Realizado', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[800]),), numeric: true),
                DataColumn(label: Text('Status', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.grey[800]),)),
              ],
              rows: [
                DataRow(
                  //selected: true,
                    cells: [
                      // DataCell(Text('1')),
                      DataCell(Text('Redução de Recolhe')),
                      DataCell(Text('615')),
                      DataCell(Icon(Icons.arrow_upward, color: Colors.greenAccent[400],)),
                    ]),
                DataRow(cells: [
                  // DataCell(Text('2')),
                  DataCell(Text('Redução de Socorro')),
                  DataCell(Text('255')),
                  DataCell(Icon(Icons.arrow_upward, color: Colors.greenAccent[400],)),
                ]),
                DataRow(cells: [
                  //DataCell(Text('3')),
                  DataCell(Text('Almoxarifado')),
                  DataCell(Text('99')),
                  DataCell(Icon(Icons.arrow_upward, color: Colors.greenAccent[400],)),
                ]),
                DataRow(cells: [
                  //DataCell(Text('4')),
                  DataCell(Text('Acidentes')),
                  DataCell(Text('488')),
                  DataCell(Icon(Icons.arrow_downward, color: Colors.redAccent[400],)),
                ]),
                DataRow(cells: [
                  //DataCell(Text('5')),
                  DataCell(Text('Faltas')),
                  DataCell(Text('318')),
                  DataCell(Icon(Icons.arrow_downward, color: Colors.redAccent[400],)),
                ]),
              ],
            ),
          ),
        ],
      ),
    );
  }
}




