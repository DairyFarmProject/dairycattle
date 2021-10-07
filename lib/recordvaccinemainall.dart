import '/editrecordvaccine.dart';
import 'package:flutter/material.dart';

import 'recordvaccine.dart';

class RecordVaccineMainAll extends StatefulWidget {
  const RecordVaccineMainAll({Key? key}) : super(key: key);

  @override
  _RecordVaccineMainAllState createState() => _RecordVaccineMainAllState();
}

class _RecordVaccineMainAllState extends State<RecordVaccineMainAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ExpansionTile(
                collapsedBackgroundColor: Color(0xff59aca9),
                tilePadding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                title: Text(
                  'โรงเรือน 1',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w500,
                      fontSize: 16),
                ),
                children: <Widget>[
                  DataTable(
                    columns: <DataColumn>[
                      DataColumn(
                          label: Text(
                        'ชื่อวัคซีน',
                      )),
                      DataColumn(
                          label: Text(
                        'รอบการฉีด',
                      )),
                      DataColumn(
                          label: Text(
                        'วันที่',
                      )),
                    ],
                    rows: <DataRow>[
                      DataRow(cells: <DataCell>[
                        DataCell(Text('มือปากเท้าเป่ือย')),
                        DataCell(Text('1/2564')),
                        DataCell(Text('2/2/2564')),
                      ]),
                      DataRow(cells: <DataCell>[
                        DataCell(Text('มือปากเท้าเป่ือย')),
                        DataCell(Text('2/2564')),
                        DataCell(Text('2/5/2564')),
                      ]),
                      DataRow(cells: <DataCell>[
                        DataCell(Text('มือปากเท้าเป่ือย')),
                        DataCell(Text('3/2564')),
                        DataCell(Text('2/8/2564')),
                      ]),
                    ],
                  ),
                  // Container(
                  //   margin: EdgeInsets.fromLTRB(100, 10, 100, 20),
                  //   child: RaisedButton(
                  //     onPressed: () {
                  //       Navigator.push(context,
                  //           MaterialPageRoute(builder: (context) {
                  //         return EditRecordVaccine();
                  //       }));
                  //     },
                  //     child: Center(
                  //       child: Row(
                  //         mainAxisAlignment: MainAxisAlignment.center,
                  //         children: [Icon(Icons.edit), Text('แก้ไข')],
                  //       ),
                  //     ),
                  //   ),
                  // )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
