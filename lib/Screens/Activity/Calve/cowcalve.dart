import 'dart:convert';
import '/models/DistinctCowAb.dart';
import '/Screens/Cow/successdeletecow.dart';
import 'package:intl/intl.dart';
import '../../Activity/Calve/editrecordclave.dart';
import '../../Activity/Calve/recordcalve.dart';
import '/models/Parturitions.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class CowCalve extends StatefulWidget {
  final DistinctCowAb ab;
  CowCalve({required this.ab});
  @override
  _CowCalveState createState() => _CowCalveState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
void showInSnackBar(String value) {
  _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
}

class _CowCalveState extends State<CowCalve> {
  Future<List<Parturition>> getParturition() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<Parturition> milks = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString(),
      'cow_id': widget.ab.cow_id.toString()
    };
    var body = json.encode(data);
    print(data);
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'cows/parturition'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      milks = list.map((e) => Parturition.fromMap(e)).toList();
    }
    return milks;
  }

  @override
  void initState() {
    super.initState();
    getParturition();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
        appBar: AppBar(
          title: const Text('บันทึกการคลอด'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color(0xff5a82de),
        ),
        body: Form(
            child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                  margin: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                  alignment: Alignment.topLeft,
                  child: Row(children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('ชื่อวัว : ${widget.ab.cow_name}'),
                          Text('หมายเลขวัว : ${widget.ab.cow_no}'),
                        ]),
                    Container(
                        margin: const EdgeInsets.fromLTRB(150, 0, 0, 0),
                        child: CircleAvatar(
                            backgroundImage: NetworkImage(widget.ab.cow_image),
                            radius: 40.0))
                  ])),
              Container(
                  margin: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                  child: Column(
                    children: [
                      FutureBuilder<List<Parturition>>(
                          future: getParturition(),
                          builder: (context, snapshot) {
                            if (snapshot.data == null) {
                              return Container();
                            }
                            return ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data!.length,
                                itemBuilder: (context, i) {
                                  return Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 10, 0, 0),
                                    margin: const EdgeInsets.fromLTRB(
                                        10, 10, 10, 10),
                                    height: 170,
                                    width: 300,
                                    child: Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: const [
                                                Text(
                                                  'วันที่',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  'ผลการทำคลอด',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  'ชื่อลูกวัว',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                ),
                                                Text(
                                                  'หมายเหตุ',
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.w500),
                                                )
                                              ],
                                            ),
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(DateFormat('dd-MM-yyyy')
                                                    .format(DateTime.parse(
                                                        snapshot.data![i]
                                                            .par_date))),
                                                Text(snapshot
                                                    .data![i].par_status),
                                                Text(snapshot
                                                    .data![i].calf_name),
                                                Text(snapshot.data![i].note)
                                              ],
                                            ),
                                          ],
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 5, 0, 5),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    // ignore: deprecated_member_use
                                                    RaisedButton(
                                                      onPressed: () async {
                                                        final ConfirmAction?
                                                            action =
                                                            await _asyncConfirmDialog(
                                                                context,
                                                                snapshot
                                                                    .data?[i]
                                                                    .parturition_id,
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
                                                      child: Row(
                                                        children: const [
                                                          Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    right: 5),
                                                            child: Icon(
                                                              Icons.delete,
                                                              color:
                                                                  Colors.brown,
                                                            ),
                                                          ),
                                                          Text(
                                                            'ลบข้อมูล',
                                                            style: TextStyle(
                                                                color: Colors
                                                                    .brown,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontSize: 14),
                                                          )
                                                        ],
                                                      ),
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          10, 5, 10, 5),
                                                    )
                                                  ],
                                                )),
                                            Container(
                                                margin:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 5, 0, 5),
                                                child: Column(
                                                  children: [
                                                    RaisedButton(
                                                      onPressed: () {
                                                        Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) => EditRecordCalve(
                                                                    key:
                                                                        ValueKey(
                                                                            i),
                                                                    par: snapshot
                                                                            .data![
                                                                        i])));
                                                      },
                                                      color: Colors.brown,
                                                      shape: const RoundedRectangleBorder(
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius
                                                                      .circular(
                                                                          39))),
                                                      child: Center(
                                                        child: Row(
                                                          children: const [
                                                            Padding(
                                                              padding: EdgeInsets
                                                                  .only(
                                                                      right: 5),
                                                              child: Icon(
                                                                Icons.edit,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                            ),
                                                            Text(
                                                              'แก้ไข',
                                                              style: TextStyle(
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600,
                                                                  fontSize: 14),
                                                            )
                                                          ],
                                                        ),
                                                      ),
                                                      padding: const EdgeInsets
                                                              .fromLTRB(
                                                          15, 7, 15, 7),
                                                    ),
                                                  ],
                                                )),
                                          ],
                                        ),
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        border: const Border(
                                          top: BorderSide(color: Colors.white),
                                          bottom:
                                              BorderSide(color: Colors.white),
                                          left: BorderSide(
                                              width: 5, color: Colors.brown),
                                        ),
                                        color: Colors.brown[50]),
                                  );
                                });
                          })
                    ],
                  )),
            ],
          ),
        )),
        floatingActionButton: FloatingActionButton.extended(
          label: const Text(
            ' เพิ่มการบันทึกข้อมูล',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 14),
          ),
          icon: const Icon(Icons.add),
          backgroundColor: Colors.brown,
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RecordCalve();
            }));
          },
        ));
  }
}

deletePar(context, user_id, farm_id, parturition_id) async {
  Map data = {
    'user_id': user_id.toString(),
    'farm_id': farm_id.toString(),
    'parturition_id': parturition_id.toString(),
  };
  print(data.toString());

  final response = await http.delete(
      Uri.https('heroku-diarycattle.herokuapp.com', 'parturition/delete'),
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
  } 
  else {
    _scaffoldKey.currentState
        ?.showSnackBar(SnackBar(content: Text("Please Try again")));
  }
}

enum ConfirmAction { Cancle, Accept }
Future<ConfirmAction?> _asyncConfirmDialog(
    context, parturition_id, farm_id, user_id) async {
  return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
          title: const Text(
            'ยืนยันที่จะลบข้อมูลนี้',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          content: const Text(
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
                    deletePar(context, user_id, farm_id, parturition_id);
                  },
                ),
              ),
            ])
          ],
        );
      });
}
