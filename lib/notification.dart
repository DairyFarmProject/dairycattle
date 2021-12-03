import 'dart:convert';
import 'package:dairycattle/models/NotiVac.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'Screens/Activity/Breeding/allrecordbreeding.dart';
import 'Screens/Cow/successdeletecow.dart';
import 'Screens/Cow/successrecord.dart';
import 'models/Abdominal.dart';
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
    List<JoinFarm> vacs = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'farm/requests'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      vacs = list.map((e) => JoinFarm.fromMap(e)).toList();
    }
    return vacs;
  }

  Future<List<Abdominal>> getAbWait() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<Abdominal> vacs = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'notification/ab/wait'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      vacs = list.map((e) => Abdominal.fromMap(e)).toList();
    }
    return vacs;
  }

  Future<List<Abdominal>> getAb() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<Abdominal> vacs = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'notification/ab'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      vacs = list.map((e) => Abdominal.fromMap(e)).toList();
    }
    return vacs;
  }

  Future<List<NotiVac>> getVaccine() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<NotiVac> vacs = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'notification/vac'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      vacs = list.map((e) => NotiVac.fromMap(e)).toList();
    }
    return vacs;
  }

  @override
  void initState() {
    super.initState();
    getJoinFarm();
    getVaccine();
    getAbWait();
    getAb();
  }

  Uri? url;

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder<List<JoinFarm>>(
                future: getJoinFarm(),
                builder: (context, snapshot) {
                  if (snapshot.data?.length == null) {
                    return const SingleChildScrollView();
                  }
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                          child: const Text(
                            'คำขอเข้าร่วมฟาร์ม',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              return Card(
                                  child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
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
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 0, 0),
                                              child: Text(
                                                  "${snapshot.data?[i].firstname}",
                                                  style: const TextStyle(
                                                      fontSize: 16)),
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(0, 0, 20, 10),
                                                    child: RaisedButton(
                                                      onPressed: () {
                                                        userAddWorker(
                                                            snapshot.data?[i]
                                                                .join_id,
                                                            user?.user_id,
                                                            user?.farm_id);
                                                      },
                                                      color: const Color(
                                                          0xff62b490),
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          39))),
                                                      child: Text(
                                                        'ยืนยัน',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blueGrey[50],
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14),
                                                      ),
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          5, 2.5, 5, 2.5),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 10),
                                                    child: RaisedButton(
                                                      onPressed: () async {
                                                        final ConfirmAction?
                                                            action =
                                                            await _asyncConfirmDialog(
                                                                context,
                                                                snapshot
                                                                    .data?[i]
                                                                    .join_id,
                                                                user?.farm_id,
                                                                user?.user_id);
                                                      },
                                                      color:
                                                          Colors.blueGrey[50],
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          39))),
                                                      child: const Text(
                                                        'ลบ',
                                                        style: TextStyle(
                                                            color: Color(
                                                                0xffd6786e),
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14),
                                                      ),
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          5, 2.5, 5, 2.5),
                                                    ),
                                                  ),
                                                ])
                                          ])
                                    ],
                                  )
                                ],
                              ));
                            })
                      ]);
                }),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder<List<Abdominal>>(
                future: getAbWait(),
                builder: (context, snapshot) {
                  if (snapshot.data?.length == null) {
                    return const SingleChildScrollView();
                  }
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                          child: const Text(
                            'อัปเดทการผสมพันธุ์',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              return Card(
                                  child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 40, 0),
                                        child: CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                '${snapshot.data?[i].cow_image}')),
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 0, 0),
                                              child: Text(
                                                  "${snapshot.data?[i].cow_name}, ${snapshot.data?[i].cow_no}",
                                                  style: const TextStyle(
                                                      fontSize: 16)),
                                            ),
                                            Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(0, 0, 20, 10),
                                                    child: RaisedButton(
                                                      onPressed: () {
                                                        abSuccess(
                                                            snapshot.data?[i]
                                                                .abdominal_id,
                                                            user?.user_id,
                                                            user?.farm_id);
                                                      },
                                                      color: Colors.red[300],
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          39))),
                                                      child: Text(
                                                        'สำเร็จ',
                                                        style: TextStyle(
                                                            color: Colors
                                                                .blueGrey[50],
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14),
                                                      ),
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          5, 2.5, 5, 2.5),
                                                    ),
                                                  ),
                                                  Container(
                                                    margin: const EdgeInsets
                                                        .fromLTRB(0, 0, 0, 10),
                                                    child: RaisedButton(
                                                      onPressed: () async {
                                                        abFail(
                                                            snapshot.data?[i]
                                                                .abdominal_id,
                                                            user?.user_id,
                                                            user?.farm_id);
                                                      },
                                                      color:
                                                          Colors.blueGrey[50],
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          39))),
                                                      child: const Text(
                                                        'ไม่สำเร็จ',
                                                        style: TextStyle(
                                                            color: Colors.brown,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            fontSize: 14),
                                                      ),
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          5, 2.5, 5, 2.5),
                                                    ),
                                                  ),
                                                ])
                                          ])
                                    ],
                                  )
                                ],
                              ));
                            })
                      ]);
                }),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder<List<Abdominal>>(
                future: getAb(),
                builder: (context, snapshot) {
                  if (snapshot.data?.length == null) {
                    return const SingleChildScrollView();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                        child: const Text(
                          'การผสมพันธุ์',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ),
                      ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, i) {
                            return Card(
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AllRecordBreeding()));
                                    },
                                    child: Row(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      20, 0, 40, 0),
                                              child: CircleAvatar(
                                                  radius: 30,
                                                  backgroundImage: NetworkImage(
                                                      '${snapshot.data?[i].cow_image}')),
                                            ),
                                            Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding: const EdgeInsets
                                                        .fromLTRB(10, 10, 0, 0),
                                                    child: Text(
                                                        "${snapshot.data?[i].cow_name}, ${snapshot.data?[i].cow_no}",
                                                        style: const TextStyle(
                                                            fontSize: 16)),
                                                  ),
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.fromLTRB(
                                                            10, 5, 0, 20),
                                                    child: Text(
                                                        "อยู่ในช่วงต้องติดตามการผสมพันธุ์",
                                                        style: TextStyle(
                                                            fontSize: 11)),
                                                  ),
                                                ])
                                          ],
                                        )
                                      ],
                                    )));
                          })
                    ],
                  );
                }),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            child: FutureBuilder<List<NotiVac>>(
                future: getVaccine(),
                builder: (context, snapshot) {
                  if (snapshot.data?.length == null) {
                    return const SingleChildScrollView();
                  }
                  return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 20, 10),
                          child: const Text(
                            'นัดหมายฉีดวัคซีน',
                            style: TextStyle(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ),
                        ListView.builder(
                            shrinkWrap: true,
                            itemCount: snapshot.data!.length,
                            itemBuilder: (context, i) {
                              return SingleChildScrollView(
                                  child: Card(
                                      child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 40, 0),
                                        child: const CircleAvatar(
                                            radius: 30,
                                            backgroundImage: NetworkImage(
                                                'https://westernmedicalclinic.ca/wp-content/uploads/2021/07/covidshot-1.png')),
                                      ),
                                      Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.fromLTRB(
                                                      10, 10, 0, 0),
                                              child: Text(
                                                  "วันที่จะฉีด : ${snapshot.data?[i].next_date}",
                                                  style: const TextStyle(
                                                      fontSize: 16)),
                                            ),
                                          ])
                                    ],
                                  )
                                ],
                              )));
                            })
                      ]);
                }),
          ),
        ],
      ),
    ));
  }

  userAddWorker(join_id, user, farm) async {
    Map data = {
      'join_id': join_id.toString(),
      'user_id': user.toString(),
      'farm_id': farm.toString()
    };

    print(data);

    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'requests/accept'),
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
        MaterialPageRoute(
          builder: (context) => SuccessRecord(),
        ),
      );
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(const SnackBar(content: Text("Please Try again")));
    }
  }

  abSuccess(ab_id, user, farm) async {
    Map data = {
      'abdominal_id': ab_id.toString(),
      'user_id': user.toString(),
      'farm_id': farm.toString()
    };

    print(data);

    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'abdominal/success'),
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
        MaterialPageRoute(
          builder: (context) => SuccessRecord(),
        ),
      );
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(const SnackBar(content: Text("Please Try again")));
    }
  }

  abFail(ab_id, user, farm) async {
    Map data = {
      'abdominal_id': ab_id.toString(),
      'user_id': user.toString(),
      'farm_id': farm.toString()
    };

    print(data);

    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'abdominal/fail'),
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
        MaterialPageRoute(
          builder: (context) => SuccessRecord(),
        ),
      );
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(const SnackBar(content: Text("Please Try again")));
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

  final response = await http.delete(
      Uri.https('heroku-diarycattle.herokuapp.com', 'requests/decline'),
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
        ?.showSnackBar(const SnackBar(content: Text("Please Try again")));
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
          insetPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          title: const Text(
            'ยืนยันที่จะลบคำขอนี้',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          content: const Text(
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
                  shape: const RoundedRectangleBorder(
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
                  shape: const RoundedRectangleBorder(
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
