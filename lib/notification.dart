import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Screens/Cow/successdeletecow.dart';
import 'Screens/Cow/successrecord.dart';
import 'models/JoinFarm.dart';
import 'models/User.dart';
import 'providers/user_provider.dart';
import 'package:http/http.dart' as http;

class Notifications extends StatefulWidget {
  @override
  _NotificationsState createState() => _NotificationsState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
void showInSnackBar(String value) {
  _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
}

class _NotificationsState extends State<Notifications> {
  Future<List<JoinFarm>> getJoinFarm() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    late List<JoinFarm> vacs;
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response =
        await http.post(Uri.http('127.0.0.1:3000', 'farm/requests'),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data,
            encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      print('Get Vaccine Schedule');
      final List list = db['data']['rows'];
      vacs = list.map((e) => JoinFarm.fromMap(e)).toList();
    }
    return vacs;
  }

  @override
  Uri? url;
  void initState() {
    super.initState();
    getJoinFarm();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
        body: Container(
            margin: EdgeInsets.fromLTRB(20, 10, 20, 5),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    child: Text(
                      'ตอบรับคำขอเข้าร่วม',
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                    ),
                    margin: EdgeInsets.only(top: 10),
                  ),
                  Container(
                      child: FutureBuilder<List<JoinFarm>>(
                          future: getJoinFarm(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Container(
                                child: Card(
                                  child: Text('ไม่มีรายการ'),
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
                                                child: Row(
                                      children: [
                                        Container(
                                            child: Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 40, 0),
                                              child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(
                                                      '${snapshot.data?[i].user_image}')),
                                            ),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 10, 0, 0),
                                                    child: Text(
                                                        "${snapshot.data?[i].firstname}",
                                                        style: TextStyle(
                                                            fontSize: 16)),
                                                  ),
                                                  Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      children: [
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 20, 10),
                                                          child: RaisedButton(
                                                            onPressed: () {
                                                              userAddWorker(
                                                                  snapshot
                                                                      .data?[i]
                                                                      .join_id,
                                                                  user?.user_id,
                                                                  user?.farm_id);
                                                            },
                                                            color: Color(
                                                                0xff62b490),
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            39))),
                                                            child: Text(
                                                              'ยืนยัน',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                          .blueGrey[
                                                                      50],
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    5,
                                                                    2.5,
                                                                    5,
                                                                    2.5),
                                                          ),
                                                        ),
                                                        Container(
                                                          margin: EdgeInsets
                                                              .fromLTRB(
                                                                  0, 0, 0, 10),
                                                          child: RaisedButton(
                                                            onPressed:
                                                                () async {
                                                              final ConfirmAction?
                                                                  action =
                                                                  await _asyncConfirmDialog(
                                                                      context,
                                                                      snapshot
                                                                          .data?[
                                                                              i]
                                                                          .join_id,
                                                                      user?.farm_id,
                                                                      user?.user_id);
                                                            },
                                                            color: Colors
                                                                .blueGrey[50],
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            39))),
                                                            child: Text(
                                                              'ลบ',
                                                              style: TextStyle(
                                                                  color: Color(
                                                                      0xffd6786e),
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14),
                                                            ),
                                                            padding:
                                                                const EdgeInsets
                                                                        .fromLTRB(
                                                                    5,
                                                                    2.5,
                                                                    5,
                                                                    2.5),
                                                          ),
                                                        ),
                                                      ])
                                                ])
                                          ],
                                        ))
                                      ],
                                    ))));
                                  });
                          })),
                ],
              ),
            )));
  }

  userAddWorker(join_id, user, farm) async {
    Map data = {
      'join_id': join_id.toString(),
      'user_id': user.toString(),
      'farm_id': farm.toString()
    };

    print(data);

    final response =
        await http.post(Uri.http('127.0.0.1:3000', 'requests/accept'),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data,
            encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      Map<String, dynamic> user = resposne['data'];
      print(user['message']);
      Navigator.push(
        context,
        new MaterialPageRoute(
          builder: (context) => new SuccessRecord(),
        ),
      );
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please Try again")));
    }
  }
}

deleteJoin(context, user_id, farm_id, join_id) async {
  Map data = {
    'user_id': user_id.toString(),
    'farm_id': farm_id.toString(),
    'join_id': join_id.toString(),
  };
  print(data.toString());

  final response =
      await http.delete(Uri.http('127.0.0.1:3000', 'requests/decline'),
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
    context, join_id, farm_id, user_id) async {
  return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.fromLTRB(20, 10, 20, 0),
          title: Text(
            'ยืนยันที่จะลบคำขอนี้',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'เมื่อคุณกดปุ่ม "ยืนยัน" แล้ว คำขอจะถูกลบออกไปโดยทันที ',
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
                    deleteJoin(context, user_id, farm_id, join_id);
                  },
                ),
              ),
            ])
          ],
        );
      });
}
