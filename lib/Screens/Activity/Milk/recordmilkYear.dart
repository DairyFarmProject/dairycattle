import 'dart:convert';

import '/Screens/Activity/Milk/editrecordmilk.dart';
import '/models/MilkYear.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

import 'recordmilk.dart';
import 'recordmilkDay.dart';
import 'recordmilkYear.dart';

class RecordMilkYear extends StatefulWidget {
  const RecordMilkYear({Key? key}) : super(key: key);

  @override
  _RecordMilkYearState createState() => _RecordMilkYearState();
}

class _RecordMilkYearState extends State<RecordMilkYear> {
  DateTime? now = new DateTime.now();
  var formatter = new DateFormat.yMMMMd("th_TH");
  int milks = 0;

  Future<List<MilkYear>> getMilk() async {
    final response = await http.get(Uri.http('127.0.0.1:3000', 'milks/year'));

    Map<String, dynamic> data = jsonDecode(response.body);
    final List list = data['data']['rows'];

    List<MilkYear> typecows = list.map((e) => MilkYear.fromMap(e)).toList();

    print(typecows);
    return typecows;
  }

  Future getCount() async {
    final response = await http.get(Uri.http('127.0.0.1:3000', 'milks/year'));

    Map<String, dynamic> data = jsonDecode(response.body);
    int milk = data['data']['total'];

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
                "จำนวนน้ำนมรวมภายในปีนี้",
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
                  child: FutureBuilder<List<MilkYear>>(
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
                              scrollDirection: Axis.vertical,
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
                                      '${snapshot.data?[i].month} 2564',
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
                                            'จำนวน',
                                          )),
                                        ],
                                        rows: <DataRow>[
                                          DataRow(cells: <DataCell>[
                                            DataCell(Text(
                                                '${snapshot.data?[i].count}')),
                                          ]),
                                        ],
                                      ),
                                    ],
                                  ),
                                ]))));
                              });
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
