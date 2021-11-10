import 'dart:convert';

import '/models/DateAb.dart';
import '/models/Parturitions.dart';
import '/models/Vaccine_schedule.dart';
import '/models/Vaccines.dart';

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
  List<Vaccine_schedule> abs = [];

  Future<List<DateAb>> getAb() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<DateAb> ab = [];
    Map data = {
      'farm_id': user!.farm_id.toString(),
      'user_id': user.user_id.toString(),
      'cow_id': widget.cow.cow_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'cows/abdominal'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['all'];
      ab = list.map((e) => DateAb.fromMap(e)).toList();
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
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'cows/parturition'),
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
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'cows/shedules'),
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

    setState(() {
      abs = ab;
    });

    return ab;
  }

  @override
  void initState() {
    super.initState();
    getAb();
    getPar();
    getVac();
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
          backgroundColor: Colors.brown[500],
        ),
        body: Container(
          child: SingleChildScrollView(
            child: (abs.isEmpty)
                ? Center(
                    child: Container(
                    padding: const EdgeInsets.only(top: 150),
                    width: 100,
                    height: 250,
                    child: const CircularProgressIndicator(
                      color: Colors.brown,
                    ),
                  ))
                : Column(children: <Widget>[
                    Container(
                      padding: const EdgeInsets.all(0),
                      margin: const EdgeInsets.all(20),
                      width: 350,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.blueGrey[100],
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
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 5),
                                        child: Text(
                                          'ชื่อวัว : ${widget.cow.cow_name}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 4,
                                    child: Container(
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            0, 10, 0, 5),
                                        child: Text(
                                          'วันเกิด : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.cow.cow_birthday))}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 0, 15),
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
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
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
                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 20, 0, 20),
                                            child: Text('ไม่มีประวัติการคลอด'))
                                      ])
                                ])));
                          } else
                            return MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                removeBottom: true,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, i) {
                                      return ExpansionTile(
                                        collapsedBackgroundColor:
                                            Colors.teal[200],
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
                                                label: Text(
                                                    '${snapshot.data![i].count}',
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
                                              DataCell(Text(
                                                  'จำนวนการคลอดลูกสำเร็จ')),
                                              DataCell(Text(
                                                  '${snapshot.data![i].countSuc}')),
                                              DataCell(Text('ครั้ง')),
                                            ]),
                                            DataRow(cells: <DataCell>[
                                              DataCell(Text(
                                                  'จำนวนการคลอดลูกไม่สำเร็จ')),
                                              DataCell(Text(
                                                  '${snapshot.data![i].countFail}')),
                                              DataCell(Text('ครั้ง')),
                                            ])
                                          ]),
                                        ],
                                      );
                                    }));
                        }),
                    FutureBuilder<List<DateAb>>(
                        future: getAb(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SingleChildScrollView(
                                    child: Column(children: <Widget>[
                                  ExpansionTile(
                                      collapsedBackgroundColor: Colors.black26,
                                      title: Text('ประวัติการผสมพันธุ์',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      children: <Widget>[
                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 20, 0, 20),
                                            child: Text(
                                                'ไม่มีประวัติการผสมพันธุ์'))
                                      ])
                                ])));
                          } else
                            return MediaQuery.removePadding(
                                context: context,
                                removeTop: true,
                                removeBottom: true,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemCount: snapshot.data!.length,
                                    itemBuilder: (context, i) {
                                      return ExpansionTile(
                                          collapsedBackgroundColor:
                                              Colors.teal[200],
                                          title: Text('ประวัติการผสมพันธุ์',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold)),
                                          children: <Widget>[
                                            DataTable(columns: <DataColumn>[
                                              DataColumn(
                                                  label: Text(
                                                      'จำนวนการผสมพันธุ์ทั้งหมด',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              DataColumn(
                                                  label: Text(
                                                      '${snapshot.data![i].count}',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold))),
                                              DataColumn(
                                                  label: Text('ครั้ง',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold))),
                                            ], rows: <DataRow>[
                                              DataRow(cells: <DataCell>[
                                                DataCell(Text('ผสมติด')),
                                                DataCell(Text(
                                                    '${snapshot.data![i].countSuc}')),
                                                DataCell(Text('ครั้ง')),
                                              ]),
                                              DataRow(cells: <DataCell>[
                                                DataCell(Text('ผสมไม่ติด')),
                                                DataCell(Text(
                                                    '${snapshot.data![i].countFail}')),
                                                DataCell(Text('ครั้ง')),
                                              ])
                                            ]),
                                            DataTable(columns: <DataColumn>[
                                              DataColumn(
                                                  label: Text(
                                                'สถานะผสมพันธุ์ปัจจุบัน',
                                                style: TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              )),
                                              DataColumn(
                                                  label: Text('วันที่',
                                                      style: TextStyle(
                                                          fontWeight: FontWeight
                                                              .bold))),
                                            ], rows: <DataRow>[
                                              DataRow(cells: <DataCell>[
                                                DataCell(
                                                    Text('วันที่เริ่มผสม')),
                                                DataCell(Text(
                                                    '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${snapshot.data![i].ab_date}'))}')),
                                              ]),
                                              DataRow(cells: <DataCell>[
                                                DataCell(
                                                    Text('กลับสัดครั้งที่ 1')),
                                                DataCell(Text(
                                                    '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${snapshot.data![i].firstHeat}'))}')),
                                              ]),
                                              DataRow(cells: <DataCell>[
                                                DataCell(
                                                    Text('กลับสัดครั้งที่ 2')),
                                                DataCell(Text(
                                                    '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${snapshot.data![i].secondHeat}'))}')),
                                              ]),
                                              DataRow(cells: <DataCell>[
                                                DataCell(
                                                    Text('กลับสัดครั้งที่ 3')),
                                                DataCell(Text(
                                                    '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${snapshot.data![i].thirdHeat}'))}')),
                                              ]),
                                              DataRow(cells: <DataCell>[
                                                DataCell(Text('พักท้อง')),
                                                DataCell(Text(
                                                    '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${snapshot.data![i].dryDate}'))}')),
                                              ]),
                                              DataRow(cells: <DataCell>[
                                                DataCell(Text('กำหนดคลอด')),
                                                DataCell(Text(
                                                    '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${snapshot.data![i].parDate}'))}')),
                                              ]),
                                            ]),
                                          ]);
                                    }));
                        }),
                    FutureBuilder<List<Vaccine_schedule>>(
                        future: getVac(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Container(
                                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                                child: SingleChildScrollView(
                                    child: Column(children: <Widget>[
                                  ExpansionTile(
                                      collapsedBackgroundColor: Colors.black26,
                                      title: Text('ประวัติการฉีดวัคซีน',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold)),
                                      children: <Widget>[
                                        Container(
                                            padding: EdgeInsets.fromLTRB(
                                                0, 20, 0, 20),
                                            child: Text(
                                                'ไม่มีประวัติการฉีดวัคซีน'))
                                      ])
                                ])));
                          } else
                            return ExpansionTile(
                              collapsedBackgroundColor: Colors.teal[200],
                              title: Text('ประวัติการฉีดวัคซีน',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              children: [
                                SingleChildScrollView(
                                    child: DataTable(
                                        columns: <DataColumn>[
                                      DataColumn(
                                          label: Text('ชื่อวัคซีน',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      DataColumn(
                                          label: Text('วันที่ฉีด',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                      DataColumn(
                                          label: Text('ครั้งถัดไป',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                    ],
                                        rows: snapshot.data!.map<DataRow>((e) {
                                          return DataRow(cells: <DataCell>[
                                            DataCell(Text('${e.vac_name_th}')),
                                            DataCell(Text(
                                                '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${e.vac_date}'))}')),
                                            DataCell(Text(
                                                '${DateFormat('dd/MM/yyyy').format(DateTime.parse('${e.next_date}'))}')),
                                          ]);
                                        }).toList()))
                              ],
                            );
                        })
                  ]),
          ),
        ));
  }
}
