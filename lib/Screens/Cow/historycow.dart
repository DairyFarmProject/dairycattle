import 'dart:convert';

import 'package:dairycattle/models/Parturitions.dart';
import 'package:dairycattle/models/Vaccine_schedule.dart';
import 'package:dairycattle/models/Vaccines.dart';

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
    List<Abdominal> ab = [];
    Map data = {
      'farm_id': user!.farm_id.toString(),
      'user_id': user.user_id.toString(),
      'cow_id': widget.cow.cow_id.toString()
    };
    final response =
        await http.post(Uri.http('127.0.0.1:3000', 'cows/abdominal'),
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

  Future<List<Parturition>> getPar() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<Parturition> ab = [];
    Map data = {
      'farm_id': user!.farm_id.toString(),
      'user_id': user.user_id.toString(),
      'cow_id': widget.cow.cow_id.toString()
    };
    final response =
        await http.post(Uri.http('127.0.0.1:3000', 'cows/parturition'),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data,
            encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      ab = list.map((e) => Parturition.fromMap(e)).toList();
    }
    return ab;
  }

  Future<List<Vaccine_schedule>> getVac() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<Vaccine_schedule> ab = [];
    Map data = {
      'farm_id': user!.farm_id.toString(),
      'user_id': user.user_id.toString(),
      'cow_id': widget.cow.cow_id.toString()
    };
    final response =
        await http.post(Uri.http('127.0.0.1:3000', 'cows/shedules'),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data,
            encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      ab = list.map((e) => Vaccine_schedule.fromMap(e)).toList();
    }
    return ab;
  }

  @override
  void initState() {
    super.initState();
    getAb();
    getPar();
    getVac();
  }

  getDate1(date) {
    DateTime dateTime = DateTime.parse(date);
    var newDate =
        new DateTime(dateTime.year, dateTime.month, dateTime.day + 21);
    var date1 =
        (DateFormat('dd/MM/yyyy').format(DateTime.parse(newDate.toString())));
    return date1;
  }

  getDate2(date) {
    DateTime dateTime = DateTime.parse(date);
    var newDate =
        new DateTime(dateTime.year, dateTime.month, dateTime.day + 42);
    var date2 =
        (DateFormat('dd/MM/yyyy').format(DateTime.parse(newDate.toString())));
    return date2;
  }

  getDate3(date) {
    DateTime dateTime = DateTime.parse(date);
    var newDate =
        new DateTime(dateTime.year, dateTime.month, dateTime.day + 63);
    var date3 =
        (DateFormat('dd/MM/yyyy').format(DateTime.parse(newDate.toString())));
    return date3;
  }

  getDate4(date) {
    DateTime dateTime = DateTime.parse(date);
    var newDate =
        new DateTime(dateTime.year, dateTime.month, dateTime.day + 210);
    var date4 =
        (DateFormat('dd/MM/yyyy').format(DateTime.parse(newDate.toString())));
    return date4;
  }

  getDate5(date) {
    DateTime dateTime = DateTime.parse(date);
    var newDate =
        new DateTime(dateTime.year, dateTime.month, dateTime.day + 282);
    var date5 =
        (DateFormat('dd/MM/yyyy').format(DateTime.parse(newDate.toString())));
    return date5;
  }

  getDiff1(date) {
    String hotfixYear(String _) =>
        _.substring(0, _.length - 2) + (_.substring(_.length - 2, _.length));
    DateFormat inputFormat = DateFormat('dd/MM/yyyy');
    DateTime dateTime = inputFormat.parse(hotfixYear(date));
    final now = inputFormat.parse(inputFormat.format(DateTime.now()));
    print(now.toString());
    print(dateTime.toString());
    final difference = dateTime.difference(now).inDays;
    return difference;
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
            child: Column(children: <Widget>[
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
              FutureBuilder<List<Parturition>>(
                  future: getPar(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    } else
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) {
                            return Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SingleChildScrollView(
                                    child: Column(children: <Widget>[
                                  ExpansionTile(
                                    collapsedBackgroundColor: Colors.black26,
                                    title: Text('ประวัติการคลอด',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    children: <Widget>[
                                      DataTable(columns: <DataColumn>[
                                        DataColumn(
                                            label: Text(
                                                'จำนวนการคลอดลูกทั้งหมด',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        DataColumn(
                                            label: Text('?',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        DataColumn(
                                            label: Text('ครั้ง',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ], rows: const <DataRow>[
                                        DataRow(cells: <DataCell>[
                                          DataCell(
                                              Text('จำนวนการคลอดลูกสำเร็จ')),
                                          DataCell(Text('?')),
                                          DataCell(Text('ครั้ง')),
                                        ]),
                                        DataRow(cells: <DataCell>[
                                          DataCell(
                                              Text('จำนวนการคลอดลูกไม่สำเร็จ')),
                                          DataCell(Text('?')),
                                          DataCell(Text('ครั้ง')),
                                        ])
                                      ]),
                                    ],
                                  )
                                ])));
                          });
                  }),
              FutureBuilder<List<Abdominal>>(
                  future: getAb(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return Container();
                    } else
                      return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) {
                            return Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SingleChildScrollView(
                                    child: Column(children: <Widget>[
                                  ExpansionTile(
                                    collapsedBackgroundColor: Colors.teal[200],
                                    title: Text('ประวัติการผสมพันธ์',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold)),
                                    children: <Widget>[
                                      DataTable(columns: <DataColumn>[
                                        DataColumn(
                                            label: Text(
                                                'จำนวนการผสมพันธ์ทั้งหมด',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        DataColumn(
                                            label: Text('4',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                        DataColumn(
                                            label: Text('ครั้ง',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ], rows: <DataRow>[
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
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        )),
                                        DataColumn(
                                            label: Text('วันที่',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold))),
                                      ], rows: <DataRow>[
                                        DataRow(cells: <DataCell>[
                                          DataCell(Text('วันที่เริ่มผสม')),
                                          DataCell(Text(
                                              '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${snapshot.data![i].ab_date}'))}')),
                                        ]),
                                        DataRow(cells: <DataCell>[
                                          DataCell(Text('กลับสัดครั้งที่ 1')),
                                          DataCell(Text(getDate1(
                                              '${snapshot.data![i].ab_date}'))),
                                        ]),
                                        DataRow(cells: <DataCell>[
                                          DataCell(Text('กลับสัดครั้งที่ 2')),
                                          DataCell(Text(getDate2(
                                              '${snapshot.data![i].ab_date}'))),
                                        ]),
                                        DataRow(cells: <DataCell>[
                                          DataCell(Text('กลับสัดครั้งที่ 3')),
                                          DataCell(Text(getDate3(
                                              '${snapshot.data![i].ab_date}'))),
                                        ]),
                                        DataRow(cells: <DataCell>[
                                          DataCell(Text('พักท้อง')),
                                          DataCell(Text(getDate4(
                                              '${snapshot.data![i].ab_date}'))),
                                        ]),
                                        DataRow(cells: <DataCell>[
                                          DataCell(Text('กำหนดคลอด')),
                                          DataCell(Text(getDate5(
                                              '${snapshot.data![i].ab_date}'))),
                                        ]),
                                      ]),
                                    ],
                                  )
                                ])));
                          });
                  }),
              ExpansionTile(
                collapsedBackgroundColor: Colors.black26,
                title: Text('ประวัติการฉีดวัคซีน',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                children: [
                  FutureBuilder<List<Vaccine_schedule>>(
                      future: getVac(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) {
                          return Container();
                        } else
                          return SingleChildScrollView(
                              child: DataTable(
                                  columns: <DataColumn>[
                                DataColumn(
                                    label: Text('ชื่อวัคซีน',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('วันที่ฉีด',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                                DataColumn(
                                    label: Text('ครั้งถัดไป',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold))),
                              ],
                                  rows: snapshot.data!.map<DataRow>((e) {
                                    return DataRow(cells: <DataCell>[
                                      DataCell(Text('${e.vac_name_th}')),
                                      DataCell(Text(
                                          '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${e.vac_date}'))}')),
                                      DataCell(Text(
                                          '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${e.next_date}'))}')),
                                    ]);
                                  }).toList()));
                      }),
                ],
              ),
            ]),
          ),
        ));
  }
}