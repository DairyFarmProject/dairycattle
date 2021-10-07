import 'dart:convert';

import '/Screens/Activity/Milk/editrecordmilk.dart';
import '/models/Milks.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'recordmilk.dart';
import 'recordmilkDay.dart';
import 'recordmilkYear.dart';

class RecordMilkMonth extends StatefulWidget {
  @override
  _RecordMilkMonthState createState() => _RecordMilkMonthState();
}

class _RecordMilkMonthState extends State<RecordMilkMonth> {
  DateTime? now = new DateTime.now();
  var formatter = new DateFormat.yMMMMd("th_TH");
  int? milks;

  Future<List<Milks>> getMilk() async {
    final response = await http.get(Uri.http('127.0.0.1:3000', 'milks/month'));

    Map<String, dynamic> data = jsonDecode(response.body);
    final List list = data['data']['rows'];

    List<Milks> typecows = list.map((e) => Milks.fromMap(e)).toList();

    return typecows;
  }

  Future getCount() async {
    final response = await http.get(Uri.http('127.0.0.1:3000', 'milks/month'));

    Map<String, dynamic> data = jsonDecode(response.body);
    int? milk = data['data']['milk'];

    setState(() {
      milks = milk;
    });

    return milk;
  }

  @override
  void initState() {
    super.initState();
    getMilk();
    getCount();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              "จำนวนน้ำนมรวมภายในเดือนนี้",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Text('${milks}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  'กิโลกรัม',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                )),
            Container(
                child: FutureBuilder<List<Milks>>(
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
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              return Container(
                                  child: SingleChildScrollView(
                                      child: Card(
                                          child: Column(children: [
                                ExpansionTile(
                                  collapsedBackgroundColor:
                                      Colors.blueGrey[200],
                                  tilePadding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  title: Text(
                                    '${DateFormat.yMMMMd("th_TH").format(DateTime.parse(snapshot.data![i].milk_date.toString()))}',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w400,
                                        fontSize: 16),
                                  ),
                                  children: <Widget>[
                                    DataTable(
                                      columnSpacing: 20,
                                      columns: <DataColumn>[
                                        DataColumn(
                                            label: Text(
                                          'รอบ',
                                        )),
                                        DataColumn(
                                            label: Text(
                                          'จำนวน',
                                        )),
                                      ],
                                      rows: <DataRow>[
                                        DataRow(cells: <DataCell>[
                                          DataCell(Text('น้ำนมวัวรอบเช้า')),
                                          DataCell(Text(
                                              '${snapshot.data![i].milk_liter_morn}')),
                                        ]),
                                        DataRow(cells: <DataCell>[
                                          DataCell(Text('น้ำนมวัวรอบเย็น')),
                                          DataCell(Text(
                                              '${snapshot.data![i].milk_liter_even}')),
                                        ]),
                                        DataRow(cells: <DataCell>[
                                          DataCell(Text('รวม',
                                              style: TextStyle(
                                                  fontWeight:
                                                      FontWeight.bold))),
                                          DataCell(Text(
                                              '${snapshot.data![i].total}',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  color: Colors.red[700]))),
                                        ]),
                                      ],
                                    ),
                                    Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 20),
                                      child: RaisedButton(
                                        onPressed: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      EditRecordMilk(
                                                          milk: snapshot
                                                              .data![i])));
                                        },
                                        child: Center(
                                          child: Row(
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
                              ]))));
                            });
                    })),
          ],
        ),
      ),
    ));
  }
}
