import 'dart:convert';

import 'package:dairycattle/util/shared_preference.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/Screens/Activity/Breeding/editrecordbreed.dart';
import '/Screens/Activity/Breeding/recordbreeding.dart';
import '/models/Abdominal.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DateBreeding extends StatefulWidget {
  final Abdominal ab;
  DateBreeding({required this.ab});
  @override
  _DateBreedingState createState() => _DateBreedingState();
}

class _DateBreedingState extends State<DateBreeding> {
  Future<List<Abdominal>> getAbdominal() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<Abdominal> adb = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString(),
      'cow_id': widget.ab.cow_id.toString()
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
      Abdominal currentCow = Abdominal.fromMap(db['data']['rows']);
      adb.add(currentCow);
    }
    return adb;
  }

  @override
  void initState() {
    super.initState();
    getAbdominal();
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
          title: Text("บันทึกการผสมพันธุ์"),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xffd6786e),
        ),
        body: FutureBuilder<List<Abdominal>>(
            future: getAbdominal(),
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container();
              } else
                return ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, i) {
                      return Container(
                          margin: EdgeInsets.fromLTRB(20, 15, 20, 5),
                          child: SingleChildScrollView(
                            child: Column(
                              children: <Widget>[
                                Text(
                                  'วันที่เริ่มผสม ${DateFormat('dd/MM/yyyy').format(DateTime.parse('${snapshot.data![i].ab_date}'))}',
                                  style: TextStyle(
                                      color: Colors.black, fontSize: 18),
                                ),
                                DataTable(
                                  columns: <DataColumn>[
                                    DataColumn(
                                        label: Text(
                                      'ชื่อกิจกรรม',
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'วันที่',
                                    )),
                                    DataColumn(
                                        label: Text(
                                      'อีกกี่วัน',
                                    )),
                                  ],
                                  rows: <DataRow>[
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text('กลับสัด 1')),
                                      DataCell(Text(getDate1(
                                          '${snapshot.data![i].ab_date}'))),
                                      DataCell(
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          decoration: BoxDecoration(
                                              color: Colors.red[800],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(2),
                                              )),
                                          child: Text(
                                            getDiff1(getDate1(
                                                    '${snapshot.data![i].ab_date}'))
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text('กลับสัด 2')),
                                      DataCell(Text(getDate2(
                                          '${snapshot.data![i].ab_date}'))),
                                      DataCell(
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          decoration: BoxDecoration(
                                              color: Colors.red[800],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(2),
                                              )),
                                          child: Text(
                                            getDiff1(getDate2(
                                                    '${snapshot.data![i].ab_date}'))
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text('กลับสัด 3')),
                                      DataCell(Text(getDate3(
                                          '${snapshot.data![i].ab_date}'))),
                                      DataCell(
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          decoration: BoxDecoration(
                                              color: Colors.red[800],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(2),
                                              )),
                                          child: Text(
                                            getDiff1(getDate3(
                                                    '${snapshot.data![i].ab_date}'))
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text('พักท้อง')),
                                      DataCell(Text(getDate4(
                                          '${snapshot.data![i].ab_date}'))),
                                      DataCell(
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          decoration: BoxDecoration(
                                              color: Colors.red[800],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(2),
                                              )),
                                          child: Text(
                                            getDiff1(getDate4(
                                                    '${snapshot.data![i].ab_date}'))
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text('กำหนดคลอด')),
                                      DataCell(Text(getDate5(
                                          '${snapshot.data![i].ab_date}'))),
                                      DataCell(
                                        Container(
                                          padding:
                                              EdgeInsets.fromLTRB(10, 5, 10, 5),
                                          decoration: BoxDecoration(
                                              color: Colors.red[800],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(2),
                                              )),
                                          child: Text(
                                            getDiff1(getDate5(
                                                    '${snapshot.data![i].ab_date}'))
                                                .toString(),
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ])
                                  ],
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(100, 10, 100, 20),
                                  child: RaisedButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  EditRecordBreed(
                                                      key: ValueKey(i),
                                                      ab: snapshot.data![i])));
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
                          ));
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
              return RecordBreeding();
            }));
          },
        ));
  }
}
