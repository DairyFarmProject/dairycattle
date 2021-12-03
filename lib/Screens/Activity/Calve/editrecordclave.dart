import '/models/Parturitions.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '/Screens/Cow/successrecord.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class EditRecordCalve extends StatefulWidget {
  final Parturition par;
  const EditRecordCalve({Key? key, required this.par}) : super(key: key);

  @override
  _EditRecordCalveState createState() => _EditRecordCalveState();
}

class _EditRecordCalveState extends State<EditRecordCalve> {
  DateTime? _dateTime;
  int selectSex = 1;
  String? sex;
  String? status;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final calfNameController = TextEditingController();
  final caretakerController = TextEditingController();
  final noteController = TextEditingController();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('แก้ไขบันทึกการคลอด'),
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
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.all(0),
                      padding: const EdgeInsets.all(20),
                      child: const Text('ชื่อลูกวัว',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextField(
                        controller: calfNameController,
                        decoration: InputDecoration(
                          hintText: widget.par.calf_name,
                          fillColor: Colors.blueGrey,
                        ),
                        onChanged: (String name) {},
                      ),
                    )
                  ]),
                  Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: const Text('เพศลูกวัว',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          items: const ["", "เพศผู้", "เพศเมีย"],
                          label: "เพศ",
                          hint: "เพศลูกวัว",
                          popupItemDisabled: (String s) => s.startsWith('I'),
                          onChanged: (newValue) {
                            print(newValue);
                            if (newValue == "เพศผู้") {
                              setState(() {
                                sex = "M";
                              });
                            } else {
                              setState(() {
                                sex = "F";
                              });
                            }
                          }),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  ]),
                  Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: const EdgeInsets.all(20),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: const Text('ผู้ดูแล',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextField(
                        controller: caretakerController,
                        decoration: InputDecoration(
                          hintText: widget.par.par_caretaker,
                          fillColor: Colors.blueGrey,
                        ),
                        onChanged: (String name) {},
                      ),
                    )
                  ]),
                  Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(20),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: const Text('สถานะ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        showSelectedItems: true,
                        items: const ["", "ปกติ", "แท้ง"],
                        label: "สถานะ",
                        hint: "สถานะ",
                        popupItemDisabled: (String s) => s.startsWith('I'),
                        onChanged: (newValue) {
                          if (newValue == "แท้ง") {
                            setState(() {
                              status = "แท้ง";
                            });
                          } else {
                            setState(() {
                              status = "ปกติ";
                            });
                          }
                        },
                      ),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  ]),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: const EdgeInsets.all(0),
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: const Text('วันที่คลอด',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                            child: Text(
                              _dateTime == null
                                  ? DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(
                                          widget.par.par_date.toString()))
                                  : DateFormat('dd-MM-yyyy').format(
                                      DateTime.parse(_dateTime.toString())),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                            child: IconButton(
                              icon: const Icon(
                                Icons.calendar_today_sharp,
                                color: Colors.brown,
                              ),
                              onPressed: () {
                                showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1970),
                                    lastDate: DateTime(2022),
                                    builder: (context, picker) {
                                      return Theme(
                                        data: ThemeData.light().copyWith(
                                          colorScheme: ColorScheme.dark(
                                            primary: Colors.brown.shade200,
                                            onPrimary: Colors.white,
                                            surface: Colors.brown.shade200,
                                            onSurface: Colors.brown,
                                          ),
                                          dialogBackgroundColor: Colors.white,
                                        ),
                                        child: picker!,
                                      );
                                    }).then((date) {
                                  setState(() {
                                    _dateTime = date;
                                  });
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Column(children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: const Text('รายละเอียดอื่นๆ',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextField(
                            controller: noteController,
                            decoration: InputDecoration(
                              hintText: widget.par.note,
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
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // ignore: deprecated_member_use
                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.pop(context);
                                    },
                                    color: Colors.blueGrey[50],
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(39))),
                                    child: const Text(
                                      'ยกเลิก',
                                      style: TextStyle(
                                          color: Color(0xffd6786e),
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    padding: const EdgeInsets.fromLTRB(
                                        30, 10, 30, 10),
                                  )
                                ],
                              )),
                          Container(
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Column(
                                children: [
                                  RaisedButton(
                                    onPressed: () {
                                      if (calfNameController.text.isEmpty) {
                                        setState(() {
                                          calfNameController.text =
                                              widget.par.calf_name;
                                        });
                                      }
                                      if (_dateTime == null) {
                                        _dateTime = DateTime.parse(
                                            widget.par.par_date.toString());
                                      }
                                      if (caretakerController.text.isEmpty) {
                                        setState(() {
                                          caretakerController.text =
                                              widget.par.par_caretaker;
                                        });
                                      }
                                      if (noteController.text.isEmpty) {
                                        setState(() {
                                          noteController.text = '-';
                                        });
                                      }
                                      if (status == null) {
                                        setState(() {
                                          status = 'ปกติ';
                                        });
                                      }
                                      if (sex == null) {
                                        setState(() {
                                          sex = 'F';
                                        });
                                      }
                                      if (_dateTime != null &&
                                          calfNameController.text != null &&
                                          sex != null &&
                                          caretakerController.text != null &&
                                          status != null &&
                                          noteController.text != null) {
                                        userEditAb(
                                            widget.par.parturition_id,
                                            widget.par.ab_id,
                                            _dateTime.toString(),
                                            calfNameController.text,
                                            sex,
                                            caretakerController.text,
                                            status,
                                            noteController.text,
                                            user?.user_id,
                                            user?.farm_id);
                                      }
                                    },
                                    color: Colors.brown,
                                    shape: const RoundedRectangleBorder(
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(39))),
                                    child: const Text(
                                      'บันทึกข้อมูล',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                          fontSize: 14),
                                    ),
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 12, 20, 12),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            )));
  }

  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'กรุณาตรวจสอบความถูกต้อง',
          style: TextStyle(fontSize: 17),
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 15),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  userEditAb(par_id, ab_id, date, name, sex, caretaker, status, note, user,
      farm) async {
    Map data = {
      'parturition_id': par_id.toString(),
      'ab_id': ab_id.toString(),
      'par_date': date,
      'calf_name': name,
      'calf_sex': sex,
      'par_caretaker': caretaker,
      'par_status': status,
      'note': note,
      'user_id': user.toString(),
      'farm_id': farm.toString()
    };

    print(data);

    final response = await http.put(
        Uri.https('heroku-diarycattle.herokuapp.com', 'parturition/edit'),
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
    }
    if (response.statusCode == 500) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      Map<String, dynamic> user = resposne['data'];
      String mess = user['message'];
      _showerrorDialog(mess);
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(const SnackBar(content: Text("Please Try again")));
    }
  }
}
