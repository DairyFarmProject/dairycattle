import 'dart:convert';

import '/Screens/Activity/Milk/recordmilk.dart';
import '/Screens/Activity/Milk/recordmilkMonth.dart';
import '/Screens/Activity/Milk/recordmilkYear.dart';
import '/models/Milks.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;

import '/Screens/Activity/Milk/editrecordmilk.dart';
import 'package:provider/provider.dart';

class RecordMilkDay extends StatefulWidget {
  const RecordMilkDay({Key? key}) : super(key: key);

  @override
  _RecordMilkDayState createState() => _RecordMilkDayState();
}

class _RecordMilkDayState extends State<RecordMilkDay> {
  DateTime? now = new DateTime.now();
  var formatter = new DateFormat.yMMMMd("th_TH");

  Future<List<Milks>> getMilk() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    late List<Milks> milks;
    Map data = {'farm_id': user!.farm_id.toString()};
    final response = await http.post(Uri.http('127.0.0.1:3000', 'farms/milks'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      milks = list.map((e) => Milks.fromMap(e)).toList();
    }
    return milks;
  }

  // Future<List<Milks>> getMilk() async {
  //   final response = await http.get(Uri.http('127.0.0.1:3000', 'milks'));

  //   Map<String, dynamic> data = jsonDecode(response.body);
  //   final List list = data['data']['rows'];

  //   List<Milks> typecows = list.map((e) => Milks.fromMap(e)).toList();

  //   return typecows;
  // }

  @override
  void initState() {
    super.initState();
    getMilk();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("บันทึกน้ำนมวัว",
              style: TextStyle(fontWeight: FontWeight.bold)),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Colors.amber[600],
        ),
        body: FutureBuilder<List<Milks>>(
            future: getMilk(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text('Loading...'),
                  ),
                );
              } else
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return Container(
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: <Widget>[
                              SizedBox(height: 20.0),
                              DefaultTabController(
                                  length: 3, // length of tabs
                                  initialIndex: 0,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: <Widget>[
                                        Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 0, 0, 10),
                                          child: TabBar(
                                            unselectedLabelColor: Colors.red,
                                            indicatorSize:
                                                TabBarIndicatorSize.label,
                                            indicator: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(50),
                                                color: Colors.red),
                                            tabs: [
                                              Tab(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      border: Border.all(
                                                          color: Colors.red,
                                                          width: 1)),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text("วันนี้"),
                                                  ),
                                                ),
                                              ),
                                              Tab(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      border: Border.all(
                                                          color: Colors.red,
                                                          width: 1)),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text("เดือนนี้"),
                                                  ),
                                                ),
                                              ),
                                              Tab(
                                                child: Container(
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              50),
                                                      border: Border.all(
                                                          color: Colors.red,
                                                          width: 1)),
                                                  child: Align(
                                                    alignment: Alignment.center,
                                                    child: Text("ปีนี้"),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                            height: 700, //height of TabBarView

                                            decoration: BoxDecoration(
                                                border: Border(
                                                    top: BorderSide(
                                                        color: Colors.grey,
                                                        width: 0.5))),
                                            child: TabBarView(
                                                children: <Widget>[
                                                  Container(
                                                    child: Container(
                                                        margin:
                                                            EdgeInsets.fromLTRB(
                                                                20, 15, 20, 5),
                                                        child:
                                                            SingleChildScrollView(
                                                          child: Column(
                                                            children: [
                                                              Text(
                                                                  "จำนวนน้ำนมรวมภายในวันนี้"),
                                                              Text(
                                                                  '${snapshot.data![270].total}'),
                                                              Container(
                                                                  margin: EdgeInsets
                                                                      .only(
                                                                          bottom:
                                                                              20),
                                                                  child: Text(
                                                                      'กิโลกรัม')),
                                                              ExpansionTile(
                                                                initiallyExpanded:
                                                                    true,
                                                                collapsedBackgroundColor:
                                                                    Color(
                                                                        0xff59aca9),
                                                                tilePadding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        5,
                                                                        0,
                                                                        5,
                                                                        0),
                                                                title: Text(
                                                                  '${DateFormat.yMMMMd("th_TH").format(DateTime.parse(now.toString()))}',
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .black,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .w500,
                                                                      fontSize:
                                                                          16),
                                                                ),
                                                                children: <
                                                                    Widget>[
                                                                  DataTable(
                                                                    columns: <
                                                                        DataColumn>[
                                                                      DataColumn(
                                                                          label:
                                                                              Text(
                                                                        'รอบ',
                                                                      )),
                                                                      DataColumn(
                                                                          label:
                                                                              Text(
                                                                        'จำนวน',
                                                                      )),
                                                                    ],
                                                                    rows: <
                                                                        DataRow>[
                                                                      DataRow(
                                                                          cells: <
                                                                              DataCell>[
                                                                            DataCell(Text('รอบเช้า')),
                                                                            DataCell(Text('${snapshot.data![270].milk_liter_morn}')),
                                                                          ]),
                                                                      DataRow(
                                                                          cells: <
                                                                              DataCell>[
                                                                            DataCell(Text('รอบเย็น')),
                                                                            DataCell(Text('${snapshot.data![270].milk_liter_even}')),
                                                                          ]),
                                                                      DataRow(
                                                                          cells: <
                                                                              DataCell>[
                                                                            DataCell(Text('รวม',
                                                                                style: TextStyle(fontWeight: FontWeight.bold))),
                                                                            DataCell(Text('${snapshot.data![270].total}',
                                                                                style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red[700], fontSize: 18))),
                                                                          ]),
                                                                    ],
                                                                  ),
                                                                  Container(
                                                                    margin: EdgeInsets
                                                                        .fromLTRB(
                                                                            20,
                                                                            20,
                                                                            20,
                                                                            0),
                                                                    child:
                                                                        RaisedButton(
                                                                      onPressed:
                                                                          () {
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => EditRecordMilk(milk: snapshot.data![i])));
                                                                      },
                                                                      child:
                                                                          Center(
                                                                        child:
                                                                            Row(
                                                                          mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                          children: [
                                                                            Icon(Icons.edit),
                                                                            Text('แก้ไข')
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  )
                                                                ],
                                                              ),
                                                            ],
                                                          ),
                                                        )),
                                                  ),
                                                  RecordMilkMonth(),
                                                  RecordMilkYear(),
                                                ]))
                                      ])),
                            ]),
                      );
                    });
            }),
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            ' เพิ่มการบันทึกข้อมูล',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 14),
          ),
          icon: Icon(Icons.add),
          backgroundColor: Color(0xff62b490),
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RecordMilk();
            }));
          },
        ));
  }
}
