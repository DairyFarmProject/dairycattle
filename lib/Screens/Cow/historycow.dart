import 'dart:convert';

import '/models/Abdominal.dart';
import '/models/Cows.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HistoryCow extends StatefulWidget {
  final Cows cow;
  HistoryCow({required this.cow});
  @override
  _HistoryCowState createState() => _HistoryCowState();
}

class _HistoryCowState extends State<HistoryCow> {

  Future<List<Abdominal>> getAb() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<Abdominal> ab =[];
    Map data = {'farm_id': user!.farm_id.toString()};
    final response = await http.post(Uri.http('127.0.0.1:3000', 'cows/abdominal'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      ab = list.map((e) => Abdominal.fromMap(e)).toList();
    }
    return ab;
  }

  @override
  void initState() {
    super.initState();
    getAb();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ประวัติวัว"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Color(0xff62b490),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(20),
                width: 350,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  border: Border.all(color: (Colors.blueGrey[300])!, width: 2),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 5),
                                  child: Text(
                                    'ชื่อวัว : ${widget.cow.cow_name}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 5),
                                  child: Text(
                                    'วันเกิด : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.cow.cow_birthday))}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                          child: Text(
                            'รหัสประจำตัว : ${widget.cow.cow_no}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Color(0xff5a82de),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                          'สถานะปัจจุบัน : ${widget.cow.type_name}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              ExpansionTile(
                collapsedBackgroundColor: Colors.black26,
                title: Text('ประวัติการคลอด',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                children: <Widget>[
                  DataTable(columns: <DataColumn>[
                    DataColumn(
                        label: Text('จำนวนการคลอดลูกทั้งหมด',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('4',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('ครั้ง',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ], rows: const <DataRow>[
                    DataRow(cells: <DataCell>[
                      DataCell(Text('จำนวนการคลอดลูกสำเร็จ')),
                      DataCell(Text('2')),
                      DataCell(Text('ครั้ง')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('จำนวนการคลอดลูกไม่สำเร็จ')),
                      DataCell(Text('2')),
                      DataCell(Text('ครั้ง')),
                    ])
                  ]),
                ],
              ),
              ExpansionTile(
                collapsedBackgroundColor: Colors.teal[200],
                title: Text('ประวัติการผสมพันธ์',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                children: <Widget>[
                  DataTable(columns: <DataColumn>[
                    DataColumn(
                        label: Text('จำนวนการผสมพันธ์ทั้งหมด',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('4',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('ครั้ง',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ], rows: const <DataRow>[
                    DataRow(cells: <DataCell>[
                      DataCell(Text('ผสมติด')),
                      DataCell(Text('4')),
                      DataCell(Text('ครั้ง')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('ผสมไม่ติด')),
                      DataCell(Text('-')),
                      DataCell(Text('ครั้ง')),
                    ])
                  ]),
                  DataTable(columns: <DataColumn>[
                    DataColumn(
                        label: Text(
                      'สถานะผสมพันธ์ปัจจุบัน',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
                    DataColumn(
                        label: Text('วันที่',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ], rows: const <DataRow>[
                    DataRow(cells: <DataCell>[
                      DataCell(Text('วันที่เริ่มผสม')),
                      DataCell(Text('02 กรกฎาคม 2018')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('กลับสัดครั้งที่ 1')),
                      DataCell(Text('23 กรกฎาคม 2018')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('กลับสัดครั้งที่ 2')),
                      DataCell(Text('13 สิงหาคม 2018')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('กลับสัดครั้งที่ 3')),
                      DataCell(Text('03 กันยายน 2018')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('ครวจสอบตั้งท้อง')),
                      DataCell(Text('30  กันยายน 2018')),
                    ]),
                  ]),
                ],
              ),
              ExpansionTile(
                collapsedBackgroundColor: Colors.black26,
                title: Text('ประวัติการฉีดวัคซีน',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                children: <Widget>[
                  DataTable(columns: <DataColumn>[
                    DataColumn(
                        label: Text('ชื่อวัคซีน',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    DataColumn(
                        label: Text('วันที่',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                  ], rows: const <DataRow>[
                    DataRow(cells: <DataCell>[
                      DataCell(Text('มือปากเท้าเปื่อย')),
                      DataCell(Text('12 ธ.ค. 2563')),
                    ]),
                    DataRow(cells: <DataCell>[
                      DataCell(Text('มือปากเท้าเปื่อย')),
                      DataCell(Text('11 มี.ค. 2564')),
                    ])
                  ]),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class Parturition {
//   String nameOfCount;
//   String count;
//   String quantifying = 'ครั้ง';

//   Parturition({this.nameOfCount, this.count, this.quantifying});
// }

// var parturitions = <Parturition>[
//   Parturition(
//     nameOfCount: 'จำนวนการคลอดลูกสำเร็จ',
//     count: '2',
//   ),
//   Parturition(
//     nameOfCount: 'จำนวนการคลอดลูกไม่สำเร็จ',
//     count: '1',
//   ),
// ];
