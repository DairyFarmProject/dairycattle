import 'dart:convert';

import '/Screens/Cow/successdeletecow.dart';
import '/models/Cows.dart';
import '/models/StatusCows.dart';
import '../../providers/user_provider.dart';
import '../../models/User.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

class DeleteCow extends StatefulWidget {
  final Cows cow;
  DeleteCow({required this.cow});
  @override
  _DeleteCowState createState() => _DeleteCowState();
}

class Status {
  const Status(this.name);
  final String name;
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
void showInSnackBar(String value) {
  _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
}

class _DeleteCowState extends State<DeleteCow> {
  int selectStatus = 0;
  List<Status> statuses = <Status>[
    Status('ขายออก'),
    Status('ป่วย'),
    Status('โคแก่'),
    Status('ตาย'),
    Status('อื่น ๆ')
  ];

  final cowNoteController = TextEditingController();

  int _selectIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  Widget optionCowButton() {
    return IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {
        print("you want to edit or delete");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
      appBar: AppBar(
        title: Text("ลบวัว"),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.brown[500],
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(0),
                margin: const EdgeInsets.all(20),
                width: 350,
                height: 150,
                decoration: BoxDecoration(
                  color: Colors.blueGrey[100],
                  border: Border.all(color: (Colors.blueGrey[300])!, width: 2),
                  borderRadius: BorderRadius.circular(3),
                ),
                child: Container(
                  padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(30)),
                  ),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(40, 10, 0, 0),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 5),
                                  child: Text(
                                    'ชื่อวัว : ${widget.cow.cow_name}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Container(
                                child: Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 5),
                                  child: Text(
                                    'วันเกิด : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.cow.cow_birthday))}',
                                    style:
                                        TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(0, 10, 0, 15),
                          child: Text(
                            'รหัสประจำตัว : ${widget.cow.cow_no}',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.brown[500],
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Text(
                          'สถานะปัจจุบัน : ${widget.cow.type_name}',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                child: DropdownButton<Status>(
                  hint: new Text("Select a status"),
                  value: selectStatus == null ? null : statuses[selectStatus],
                  onChanged: (newValue) {
                    setState(() {
                      selectStatus = statuses.indexOf(newValue!);
                      print(selectStatus);
                    });
                  },
                  items: statuses.map((Status status) {
                    return new DropdownMenuItem<Status>(
                      value: status,
                      child: new Text(
                        status.name,
                        style: new TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Column(children: [
                Container(
                  alignment: Alignment.topLeft,
                  margin: EdgeInsets.all(0),
                  padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                  child: Text('รายละเอียดอื่นๆ',
                      style: TextStyle(fontWeight: FontWeight.w500)),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 60),
                  child: TextField(
                    controller: cowNoteController,
                    decoration: InputDecoration(
                      hintText: '${widget.cow.note}',
                      fillColor: Colors.blueGrey,
                    ),
                    onChanged: (String name) {},
                  ),
                )
              ]),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          color: Colors.blueGrey[50],
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(39)),
                          ),
                          //hoverColor: Colors.brown[900],
                          child: Text(
                            'ยกเลิก',
                            style: TextStyle(
                              color: Colors.brown[900],
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                    child: Column(
                      children: [
                        RaisedButton(
                          onPressed: () async {
                            final ConfirmAction? action =
                                await _asyncConfirmDialog(
                                    context,
                                    selectStatus,
                                    widget.cow.cow_id,
                                    widget.cow.farm_id,
                                    user?.user_id);
                            print("Confirm Action $action");
                          },
                          padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                          color: Colors.brown[500],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(Radius.circular(39)),
                          ),
                          child: Text(
                            'บันทึกข้อมูล',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

deleteCow(context, status, user_id, farm_id, cow_id) async {
  Map data = {
    'user_id': user_id.toString(),
    'farm_id': farm_id.toString(),
    'cow_id': cow_id.toString(),
  };
  print(data.toString());

  final response = await http.delete(Uri.http('127.0.0.1:3000', 'cows/delete'),
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
    context, status, cow_id, farm_id, user_id) async {
  return showDialog<ConfirmAction>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          insetPadding: EdgeInsets.fromLTRB(20, 10, 20, 30),
          title: Text(
            'ยืนยันที่จะลบวัวตัวนี้',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
            textAlign: TextAlign.center,
          ),
          content: Text(
            'เมื่อคุณกดปุ่ม "ยืนยัน" แล้ว วัวของคุณจะถูกลบออกไปโดยทันที ',
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Container(
              //alignment: Alignment.center,
              width: 130,
              child: RaisedButton(
                child: const Text(
                  'ยกเลิก',
                  style: TextStyle(color: Color(0xFF3F2723)),
                ),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
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
              width: 130,
              child: RaisedButton(
                child: const Text(
                  'ยืนยัน',
                  style: TextStyle(color: Colors.white),
                ),
                padding: const EdgeInsets.fromLTRB(20, 12, 20, 12),
                color: Colors.brown[900],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(39)),
                ),
                onPressed: () {
                  deleteCow(context, status, user_id, farm_id, cow_id);
                },
              ),
            ),
          ],
        );
      });
}
