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

import 'edit_milkDay.dart';

class RecordMilkToday extends StatefulWidget {
  const RecordMilkToday({Key? key}) : super(key: key);

  @override
  _RecordMilkTodayState createState() => _RecordMilkTodayState();
}

class _RecordMilkTodayState extends State<RecordMilkToday> {
  DateTime? now = new DateTime.now();
  var formatter = new DateFormat.yMMMMd("th_TH");

  Future<List<Milks>> getMilk() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    late List<Milks> milks;
    Map data = {
      'farm_id': user!.farm_id.toString(),
      'user_id': user.user_id.toString()
    };
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

  @override
  void initState() {
    super.initState();
    getMilk();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                            Container(
                              height: 700, //height of TabBarView

                              decoration: BoxDecoration(
                                  border: Border(
                                      top: BorderSide(
                                          color: Colors.grey, width: 0.5))),
                              child: Container(
                                  child: Container(
                                margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
                                child: Column(
                                  children: [
                                    Text("จำนวนน้ำนมรวมภายในวันนี้",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w400)),
                                    Text(
                                      '${snapshot.data![270].total}',
                                      style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                    Container(
                                        margin: EdgeInsets.only(bottom: 20),
                                        child: Text('กิโลกรัม',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w400))),
                                    ExpansionTile(
                                      initiallyExpanded: true,
                                      collapsedBackgroundColor:
                                          Color.fromRGBO(234, 177, 93, 5),
                                      tilePadding:
                                          const EdgeInsets.fromLTRB(5, 0, 5, 0),
                                      title: Text(
                                        '${DateFormat.yMMMMd("th_TH").format(DateTime.parse(now.toString()))}',
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
                                              'รอบ',
                                            )),
                                            DataColumn(
                                                label: Text(
                                              'จำนวน',
                                            )),
                                          ],
                                          rows: <DataRow>[
                                            DataRow(cells: <DataCell>[
                                              DataCell(Text('รอบเช้า')),
                                              DataCell(Text(
                                                  '${snapshot.data![270].milk_liter_morn}')),
                                            ]),
                                            DataRow(cells: <DataCell>[
                                              DataCell(Text('รอบเย็น')),
                                              DataCell(Text(
                                                  '${snapshot.data![270].milk_liter_even}')),
                                            ]),
                                            DataRow(cells: <DataCell>[
                                              DataCell(Text('รวม',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold))),
                                              DataCell(Text(
                                                  '${snapshot.data![270].total}',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.red[700],
                                                      fontSize: 18))),
                                            ]),
                                          ],
                                        ),
                                        Container(
                                          margin: EdgeInsets.fromLTRB(
                                              20, 20, 20, 0),
                                          child: RaisedButton(
                                            onPressed: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          EditMilkDay(
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
                                  ],
                                ),
                              )),
                            )
                          ]));
                    });
            }));
  }
}
