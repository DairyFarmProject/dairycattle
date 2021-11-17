import 'dart:convert';

import '../../../providers/user_provider.dart';
import '/Screens/Activity/Milk/editrecordmilk.dart';
import '/models/Milks.dart';
import 'package:flutter/material.dart';
import '../../../models/User.dart';
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
  DateTime? now = DateTime.now();
  var formatter = DateFormat.yMMMMd("th_TH");
  int? milks;

  Future<List<Milks>> getMilk() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<Milks> milks = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'milks/month'),
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

  Future getCount() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    String milk = '';
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'milks/month'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      milk = db['data']['total'];

      setState(() {
        milks = int.parse(milk);
      });
    }
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
      margin: EdgeInsets.fromLTRB(40, 15, 40, 5),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Text(
              'จำนวนน้ำนมภายในเดือน ${DateFormat.MMMM("th_TH").format(DateTime.parse(now.toString()))}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
            ),
            Text('${milks ?? 0}',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
            Container(
                margin: EdgeInsets.only(bottom: 20),
                child: Text(
                  'ลิตร',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),
                )),
            FutureBuilder<List<Milks>>(
                future: getMilk(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) {
                    return Container(
                      child: Center(
                        child: Text('Loading...'),
                      ),
                    );
                  }
                  return Column(children: [
                    ListView.builder(
                        //scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: snapshot.data!.length,
                        itemBuilder: (context, i) {
                          return ExpansionTile(
                            collapsedBackgroundColor:
                                Color.fromRGBO(234, 177, 93, 5),
                            tilePadding:
                                const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            title: Text(
                              'วันที่ ${DateFormat.MMMMd("th_TH").format(DateTime.parse(snapshot.data![i].milk_date.toString()))}',
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
                                            fontWeight: FontWeight.bold))),
                                    DataCell(Text('${snapshot.data![i].total}',
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
                                                    milk: snapshot.data![i])));
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
                          );
                        }),
                    Container(
                      height: 400,
                    )
                  ]);
                }),
          ],
        ),
      ),
    ));
  }
}
