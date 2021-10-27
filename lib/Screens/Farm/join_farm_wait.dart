import 'dart:convert';
import 'package:dairycattle/Screens/Cow/cow1.dart';
import 'package:dairycattle/Screens/Farm/home.dart';
import 'package:dairycattle/Screens/member/navigator_member.dart';

import '/models/UserDairys.dart';
import '/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '/Screens/member/farm_data_member.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class JoinFarmWait extends StatefulWidget {
  const JoinFarmWait({Key? key}) : super(key: key);

  @override
  _JoinFarmWaitState createState() => _JoinFarmWaitState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
void showInSnackBar(String value) {
  _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
}

class _JoinFarmWaitState extends State<JoinFarmWait> {
  @override
  Widget build(BuildContext context) {
    UserDairys? user =
        Provider.of<UserProvider>(context, listen: false).userDairys;
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      // Navigator.pop(context);
                    },
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.brown,
                        ))),
              ),
              Center(
                child: Text('เข้าร่วมฟาร์ม'),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
              )),
            ],
          ),
          backgroundColor: Colors.brown),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 40),
              width: 350,
              height: 190,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blueGrey[50],
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20, bottom: 20),
                    child: Text(
                      'ส่งคำขอเข้าร่วมฟาร์มเรียบร้อยแล้ว',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Icon(
                    Icons.watch_later,
                    size: 62,
                    color: Colors.brown[700],
                  ),
                  Container(
                      margin: EdgeInsets.only(top: 20, bottom: 20),
                      child: Text('สถานะ : รอเจ้าของฟาร์มอนุมัติ'))
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50, bottom: 30),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () async {
                        final ConfirmAction? action =
                            await _asyncConfirmDialog(context, user?.user_id);
                      },
                      color: Colors.blueGrey[50],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(39))),
                      child: Text(
                        'ยกเลิกคำขอ',
                        style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                    )
                  ],
                )),
                Container(
                    child: Center(
                  child: Column(
                    children: [
                      RaisedButton(
                        onPressed: () {
                          checkJoin(user?.user_id);
                        },
                        color: Colors.brown,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(39))),
                        child: Text(
                          'รีเฟรช',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  checkJoin(user_id) async {
    Map data = {
      'user_id': user_id.toString(),
    };
    print(data);

    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'farms/check'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      if (response.statusCode == 200) {
        var user = resposne['data']['message'];
        if (user == 'D') {
          print("Join Success");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return Homepage_Member();
          }));
        } else {
          print("Wait Join");
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return JoinFarmWait();
          }));
        }
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
}

userCancle(context, user_id) async {
  Map data = {
    'user_id': user_id.toString(),
  };
  print(data.toString());

  final response = await http.delete(
      Uri.https('heroku-diarycattle.herokuapp.com', 'requests/cancel'),
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
        return Home();
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
Future<ConfirmAction?> _asyncConfirmDialog(context, user_id) async {
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
                    userCancle(context, user_id);
                  },
                ),
              ),
            ])
          ],
        );
      });
}
