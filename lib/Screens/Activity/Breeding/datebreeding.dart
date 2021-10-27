import 'dart:convert';

import '/models/DateAb.dart';
import '/Screens/Cow/successdeletecow.dart';
import '/models/DistinctCowAb.dart';
import '/Screens/Activity/Breeding/editrecordbreed.dart';
import '/models/Abdominal.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class DateBreeding extends StatefulWidget {
  final DistinctCowAb ab;
  DateBreeding({required this.ab});
  @override
  _DateBreedingState createState() => _DateBreedingState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
void showInSnackBar(String value) {
  _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
}

class _DateBreedingState extends State<DateBreeding> {
  Future<List<DateAb>> getDateAb() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<DateAb> adb = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString(),
      'cow_id': widget.ab.cow_id.toString()
    };

    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'cows/abdominals'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['all'];
      adb = list.map((e) => DateAb.fromMap(e)).toList();
    }
    return adb;
  }

  @override
  void initState() {
    super.initState();
    getDateAb();
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
    User? user = Provider.of<UserProvider>(context, listen: false).user;
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
          backgroundColor: Color.fromRGBO(185, 110, 110, 5),
        ),
        body: FutureBuilder<List<DateAb>>(
            future: getDateAb(),
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
                                      DataCell(Text(
                                          '${DateFormat('dd/MM/yyyy').format(DateTime.parse(snapshot.data![i].firstHeat))}')),
                                      DataCell(
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (snapshot
                                                      .data![i].secondcount ==
                                                  -1)
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2),
                                                      )),
                                                  child: Text(
                                                    'เสร็จสิ้น'.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              if (snapshot
                                                      .data![i].secondcount ==
                                                  0)
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2),
                                                      )),
                                                  child: Text(
                                                    'วันนี้'.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              if (snapshot
                                                      .data![i].secondcount >
                                                  0)
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red[800],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2),
                                                      )),
                                                  child: Text(
                                                    '${snapshot.data![i].firstcount}'
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                )
                                            ]),
                                      ),
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text('กลับสัด 2')),
                                      DataCell(Text(
                                          '${DateFormat('dd/MM/yyyy').format(DateTime.parse(snapshot.data![i].secondHeat))}')),
                                      DataCell(
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (snapshot
                                                      .data![i].secondcount ==
                                                  -1)
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2),
                                                      )),
                                                  child: Text(
                                                    'เสร็จสิ้น'.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              if (snapshot
                                                      .data![i].secondcount ==
                                                  0)
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2),
                                                      )),
                                                  child: Text(
                                                    'วันนี้'.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              if (snapshot
                                                      .data![i].secondcount >
                                                  0)
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red[800],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2),
                                                      )),
                                                  child: Text(
                                                    '${snapshot.data![i].secondcount}'
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                            ]),
                                      )
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text('กลับสัด 3')),
                                      DataCell(Text(
                                          '${DateFormat('dd/MM/yyyy').format(DateTime.parse(snapshot.data![i].thirdHeat))}')),
                                      DataCell(
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (snapshot
                                                      .data![i].thirdcount ==
                                                  -1)
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2),
                                                      )),
                                                  child: Text(
                                                    'เสร็จสิ้น'.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              if (snapshot
                                                      .data![i].thirdcount ==
                                                  0)
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2),
                                                      )),
                                                  child: Text(
                                                    'วันนี้'.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              if (snapshot.data![i].thirdcount >
                                                  0)
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red[800],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2),
                                                      )),
                                                  child: Text(
                                                    '${snapshot.data![i].thirdcount}'
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                            ]),
                                      )
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text('พักท้อง')),
                                      DataCell(Text(
                                          '${DateFormat('dd/MM/yyyy').format(DateTime.parse(snapshot.data![i].dryDate))}')),
                                      DataCell(
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (snapshot.data![i].drycount ==
                                                  -1)
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2),
                                                      )),
                                                  child: Text(
                                                    'เสร็จสิ้น'.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              if (snapshot.data![i].drycount ==
                                                  0)
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2),
                                                      )),
                                                  child: Text(
                                                    'วันนี้'.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              if (snapshot.data![i].drycount >
                                                  0)
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red[800],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2),
                                                      )),
                                                  child: Text(
                                                    '${snapshot.data![i].drycount}'
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                            ]),
                                      )
                                    ]),
                                    DataRow(cells: <DataCell>[
                                      DataCell(Text('กำหนดคลอด')),
                                      DataCell(Text(
                                          '${DateFormat('dd/MM/yyyy').format(DateTime.parse(snapshot.data![i].parDate))}')),
                                      DataCell(
                                        Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              if (snapshot.data![i].parcount ==
                                                  -1)
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.grey,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2),
                                                      )),
                                                  child: Text(
                                                    'เสร็จสิ้น'.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              if (snapshot.data![i].parcount ==
                                                  0)
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.yellow,
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2),
                                                      )),
                                                  child: Text(
                                                    'วันนี้'.toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                              if (snapshot.data![i].parcount >
                                                  0)
                                                Container(
                                                  padding: EdgeInsets.fromLTRB(
                                                      10, 5, 10, 5),
                                                  decoration: BoxDecoration(
                                                      color: Colors.red[800],
                                                      borderRadius:
                                                          BorderRadius.all(
                                                        Radius.circular(2),
                                                      )),
                                                  child: Text(
                                                    '${snapshot.data![i].parcount}'
                                                        .toString(),
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ),
                                            ]),
                                      )
                                    ])
                                  ],
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 20, 0, 20),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            RaisedButton(
                                              onPressed: () async {
                                                final ConfirmAction? action =
                                                    await _asyncConfirmDialog(
                                                        context,
                                                        snapshot.data?[i]
                                                            .abdominal_id,
                                                        user?.farm_id,
                                                        user?.user_id);
                                              },
                                              color: Colors.blueGrey[50],
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(39))),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 5),
                                                    child: Icon(
                                                      Icons.delete,
                                                      color: Colors.brown,
                                                    ),
                                                  ),
                                                  Text(
                                                    'ลบข้อมูล',
                                                    style: TextStyle(
                                                        color: Colors.brown,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontSize: 14),
                                                  )
                                                ],
                                              ),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 10, 20, 10),
                                            )
                                          ],
                                        )),
                                    Container(
                                        margin:
                                            EdgeInsets.fromLTRB(0, 20, 0, 20),
                                        child: Column(
                                          children: [
                                            // ignore: deprecated_member_use

                                            RaisedButton(
                                              onPressed: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            EditRecordBreed(
                                                                key:
                                                                    ValueKey(i),
                                                                ab: snapshot
                                                                        .data![
                                                                    i])));
                                              },
                                              color: Colors.brown,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.all(
                                                          Radius.circular(39))),
                                              child: Center(
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 5),
                                                      child: Icon(
                                                        Icons.edit,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                    Text(
                                                      'แก้ไข',
                                                      style: TextStyle(
                                                          color: Colors.white,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          fontSize: 14),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      30, 12, 30, 12),
                                            ),
                                          ],
                                        )),
                                  ],
                                ),
                              ],
                            ),
                          ));
                    });
            }));
  }
}

deleteAb(context, user_id, farm_id, abdominal_id) async {
  Map data = {
    'user_id': user_id.toString(),
    'farm_id': farm_id.toString(),
    'abdominal_id': abdominal_id.toString(),
  };
  print(data.toString());

  final response = await http.delete(
      Uri.https('heroku-diarycattle.herokuapp.com', 'abdominal/delete'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded"
      },
      body: data,
      encoding: Encoding.getByName("utf-8"));

  if (response.statusCode == 200) {
    Map<String, dynamic> resposne = jsonDecode(response.body);
    if (response.statusCode == 200) {
      print("Delete Success");
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SuccessDeleteCow();
      }));
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("${resposne['message']}")));
    }
    _scaffoldKey.currentState
        ?.showSnackBar(SnackBar(content: Text("${resposne['message']}")));
  } else {
    _scaffoldKey.currentState
        ?.showSnackBar(SnackBar(content: Text("Please Try again")));
  }
}

enum ConfirmAction { Cancle, Accept }
Future<ConfirmAction?> _asyncConfirmDialog(
    context, abdominal_id, farm_id, user_id) async {
  return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          title: Text(
            'ยืนยันที่จะลบข้อมูลนี้',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'เมื่อคุณกดปุ่ม "ยืนยัน" แล้ว ข้อมูลของคุณจะถูกลบออกไปโดยทันที ',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                // width: 130,
                child: RaisedButton(
                  child: const Text(
                    'ยกเลิก',
                    style: TextStyle(color: Color(0xFF3F2723)),
                  ),
                  padding: const EdgeInsets.fromLTRB(50, 12, 50, 12),
                  color: Colors.blueGrey[50],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(39)),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop(ConfirmAction.Cancle);
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                // width: 130,
                child: RaisedButton(
                  child: const Text(
                    'ยืนยัน',
                    style: TextStyle(color: Colors.white),
                  ),
                  padding: const EdgeInsets.fromLTRB(50, 12, 50, 12),
                  color: Colors.brown[900],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(39)),
                  ),
                  onPressed: () {
                    deleteAb(context, user_id, farm_id, abdominal_id);
                  },
                ),
              ),
            ])
          ],
        );
      });
}
