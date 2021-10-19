import 'dart:convert';
import 'dart:math';

import 'package:dairycattle/Screens/Cow/successdeletecow.dart';
import 'package:dairycattle/models/DistinctCow.dart';
import 'package:dairycattle/models/DistinctVac.dart';
import 'package:dairycattle/models/VacIDCow.dart';

import 'editrecordvaccine.dart';
import '/models/Vaccine_schedule.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../../../models/User.dart';
import 'recordvaccine.dart';

class EachVaccine extends StatefulWidget {
  final DistinctCow vac;
  EachVaccine({required this.vac});

  @override
  _EachVaccineState createState() => _EachVaccineState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
void showInSnackBar(String value) {
  _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
}

class _EachVaccineState extends State<EachVaccine> {
  Future<List<VacIDCow>> getVacS() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    late List<VacIDCow> vacs;
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString(),
      'cow_id': widget.vac.cow_id.toString(),
      'vaccine_id': widget.vac.vaccine_id.toString()
    };
    final response =
        await http.post(Uri.http('127.0.0.1:3000', 'cows/shedules/vac'),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data,
            encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      print('Get Vaccine Schedule History');
      final List list = db['data']['rows'];
      vacs = list.map((e) => VacIDCow.fromMap(e)).toList();
    }
    return vacs;
  }

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  _EachVaccineState createState() => _EachVaccineState();
  void initState() {
    super.initState();
    getVacS();
  }

  int _selectIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
            title: Text("บันทึกการฉีดวัคซีน"),
            leading: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
            ),
            backgroundColor: Color.fromRGBO(111, 193, 148, 5)),
        body: Form(
            key: _formKey,
            child: Container(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 20, 20, 0),
                      alignment: Alignment.topLeft,
                      child: Row(children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Text(
                              //     'วันที่ฉีด : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.vac.toString()))}'),
                              Text('ชื่อวัว : ${widget.vac.cow_name}'),
                              Text('ชื่อวัคซีน : ${widget.vac.vac_name_th}'),
                              Text('ชื่ออังกฤษ : ${widget.vac.vac_name_en}'),
                            ]),
                        Container(
                            margin: EdgeInsets.fromLTRB(120, 0, 0, 0),
                            child: CircleAvatar(
                                backgroundImage:
                                    NetworkImage('${widget.vac.cow_image}'),
                                radius: 40.0))
                      ])),
                  Container(
                      margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                      child: Column(
                        children: [
                          Container(
                              child: FutureBuilder<List<VacIDCow>>(
                                  future: getVacS(),
                                  builder: (context, snapshot) {
                                    if (snapshot.data == null) {
                                      return Container();
                                    } else
                                      return ListView.builder(
                                          shrinkWrap: true,
                                          itemCount: snapshot.data!.length,
                                          itemBuilder: (context, i) {
                                            return Container(
                                              padding: EdgeInsets.fromLTRB(
                                                  0, 5, 0, 0),
                                              margin: EdgeInsets.fromLTRB(
                                                  10, 10, 10, 10),
                                              height: 120,
                                              width: 300,
                                              child: Column(
                                                children: [
                                                  Text(
                                                      'วันที่ฉีด : ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${snapshot.data![i].vac_date.toString()}'))}'),
                                                  Text(
                                                      'วันที่ฉีด : ${DateFormat('dd-MM-yyyy').format(DateTime.parse('${snapshot.data![i].next_date.toString()}'))}'),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 5, 0, 5),
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            children: [
                                                              // ignore: deprecated_member_use
                                                              RaisedButton(
                                                                onPressed:
                                                                    () async {
                                                                  final ConfirmAction? action = await _asyncConfirmDialog(
                                                                      context,
                                                                      snapshot
                                                                          .data?[
                                                                              i]
                                                                          .schedule_id,
                                                                      user?.farm_id,
                                                                      user?.user_id);
                                                                },
                                                                color: Colors
                                                                    .blueGrey[50],
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(39))),
                                                                child: Row(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          right:
                                                                              5),
                                                                      child:
                                                                          Icon(
                                                                        Icons
                                                                            .delete,
                                                                        color: Colors
                                                                            .brown,
                                                                      ),
                                                                    ),
                                                                    Text(
                                                                      'ลบข้อมูล',
                                                                      style: TextStyle(
                                                                          color: Colors
                                                                              .brown,
                                                                          fontWeight: FontWeight
                                                                              .w600,
                                                                          fontSize:
                                                                              14),
                                                                    )
                                                                  ],
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        10,
                                                                        5,
                                                                        10,
                                                                        5),
                                                              )
                                                            ],
                                                          )),
                                                      Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 5, 0, 5),
                                                          child: Column(
                                                            children: [
                                                              RaisedButton(
                                                                onPressed: () {
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              EditRecordVaccine(vac: snapshot.data![i])));
                                                                },
                                                                color: Colors
                                                                    .brown,
                                                                shape: RoundedRectangleBorder(
                                                                    borderRadius:
                                                                        BorderRadius.all(
                                                                            Radius.circular(39))),
                                                                child: Center(
                                                                  child: Row(
                                                                    children: [
                                                                      Padding(
                                                                        padding:
                                                                            const EdgeInsets.only(right: 5),
                                                                        child:
                                                                            Icon(
                                                                          Icons
                                                                              .edit,
                                                                          color:
                                                                              Colors.white,
                                                                        ),
                                                                      ),
                                                                      Text(
                                                                        'แก้ไข',
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontWeight: FontWeight.w600,
                                                                            fontSize: 14),
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                                padding:
                                                                    const EdgeInsets
                                                                            .fromLTRB(
                                                                        15,
                                                                        7,
                                                                        15,
                                                                        7),
                                                              ),
                                                            ],
                                                          )),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              decoration: BoxDecoration(
                                                  border: Border(
                                                    top: BorderSide(
                                                        color: Colors.white),
                                                    bottom: BorderSide(
                                                        color: Colors.white),
                                                    left: BorderSide(
                                                        width: 5,
                                                        color: Colors.brown),
                                                  ),
                                                  color: Colors.white),
                                            );
                                          });
                                  }))
                        ],
                      )),
                ],
              ),
            ))));
  }
}

deleteVac(context, user_id, farm_id, schedule_id) async {
  Map data = {
    'user_id': user_id.toString(),
    'farm_id': farm_id.toString(),
    'schedule_id': schedule_id.toString(),
  };
  print(data.toString());

  final response =
      await http.delete(Uri.http('127.0.0.1:3000', 'schedules/delete'),
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
    context, schedule_id, farm_id, user_id) async {
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
                    deleteVac(context, user_id, farm_id, schedule_id);
                  },
                ),
              ),
            ])
          ],
        );
      });
}
