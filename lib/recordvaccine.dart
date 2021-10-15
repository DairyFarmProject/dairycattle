import 'dart:convert';

import 'package:dairycattle/checkbox_state.dart';
import 'package:dairycattle/models/User.dart';
import 'package:dairycattle/providers/user_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'Screens/Cow/successrecord.dart';
import 'models/Vaccines.dart';
import '../../models/AllChoose.dart';

class RecordVacine extends StatefulWidget {
  @override
  _RecordVacineState createState() => _RecordVacineState();
}

class _RecordVacineState extends State<RecordVacine> {
  int selectVaccine = 1;
  int _selectIndex = 0;

  final allowNotifications = CheckBoxState(title: 'ทุกตัว');

  final notifications = [
    CheckBoxState(title: 'วัว 1'),
    CheckBoxState(title: 'วัว 2'),
    CheckBoxState(title: 'วัว 3'),
    CheckBoxState(title: 'วัว 1'),
    CheckBoxState(title: 'วัว 2'),
    CheckBoxState(title: 'วัว 1'),
    CheckBoxState(title: 'วัว 2'),
  ];

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  DateTime? _dateTime;
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: AppBar(
          title: Text('บันทึกการฉีดวัคซีน'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromRGBO(111, 193, 148, 5),
        ),
        body: SingleChildScrollView(
          child: Form(
              key: _formKey,
              child: Container(
                child: Column(
                  children: [
                    Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Text('ชื่อวัคซีน',
                            style: TextStyle(fontWeight: FontWeight.w500))),
                    Container(
                      padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                      alignment: Alignment.topLeft,
                      child: DropdownButton<Vaccine>(
                        isExpanded: true,
                        hint: new Text("Select a specie"),
                        value:
                            selectVaccine == null ? null : vacs[selectVaccine],
                        onChanged: (newValue) {
                          setState(() {
                            selectVaccine = vacs.indexOf(newValue!);
                            print(selectVaccine);
                          });
                        },
                        items: vacs.map((Vaccine status) {
                          return new DropdownMenuItem<Vaccine>(
                            value: status,
                            child: new Text(
                              status.name,
                              style: new TextStyle(color: Colors.black),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Text('วันที่',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(30, 20, 0, 20),
                          child: Text(
                            _dateTime == null
                                ? 'yyyy/mm/dd'
                                : _dateTime.toString(),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                          child: IconButton(
                            icon: Icon(
                              Icons.calendar_today_sharp,
                              color: Colors.blueGrey,
                            ),
                            onPressed: () {
                              showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1970),
                                      lastDate: DateTime(2022))
                                  .then((date) {
                                setState(() {
                                  _dateTime = date;
                                });
                              });
                            },
                          ),
                        )
                      ],
                    ),
                    Container(
                      alignment: Alignment.topLeft,
                      // margin: EdgeInsets.only(top: 10),
                      padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                      child: Text('ชื่อวัวที่ฉีดวัคซีน',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Column(
                      children: [
                        buildGroupCheckBox(allowNotifications),
                        Divider(
                          color: Colors.grey,
                        ),
                        ...notifications.map(buildSingleCheckbox).toList(),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  color: Colors.blueGrey[50],
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(39))),
                                  child: Text(
                                    'ยกเลิก',
                                    style: TextStyle(
                                        color: Colors.brown,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 10, 30, 10))
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 40, 0, 30),
                          child: Column(
                            children: [
                              RaisedButton(
                                  onPressed: () {
                                    userRecordVaccine();
                                    // Navigator.push(context,
                                    //     MaterialPageRoute(builder: (context) {
                                    //   return SuccessRecord();
                                    // }));
                                  },
                                  color: Colors.brown,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(39))),
                                  child: Text(
                                    'บันทึกข้อมูล',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 12, 20, 12))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )),
        ));
  }

  buildSingleCheckbox(CheckBoxState checkBox) => CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.brown,
      value: checkBox.value,
      title: Text(checkBox.title),
      onChanged: (value) => setState(() {
            checkBox.value = value!;
            allowNotifications.value =
                notifications.every((Notification) => Notification.value);
          }));

  Widget buildGroupCheckBox(CheckBoxState checkbox) => CheckboxListTile(
      controlAffinity: ListTileControlAffinity.leading,
      activeColor: Colors.brown,
      value: checkbox.value,
      title: Text(checkbox.title),
      onChanged: toggleGroupCheckbox);
  void toggleGroupCheckbox(bool? value) {
    if (value == null) return;
    setState(() {
      allowNotifications.value = value;
      notifications.forEach((notification) => notification.value = value);
    });
  }

  userRecordVaccine() async {
    // final response = await http.post(Uri.http('127.0.0.1:3000', 'schedules/create'),
    //     headers: {
    //       "Accept": "application/json",
    //       "Content-Type": "application/x-www-form-urlencoded"
    //     },
    //     body: data,
    //     encoding: Encoding.getByName("utf-8"));

    // if (response.statusCode == 200) {
    //   Map<String, dynamic> resposne = jsonDecode(response.body);
    //   Map<String, dynamic> user = resposne['data'];
    //   print(user['message']);
    //   Navigator.push(
    //     context,
    //     new MaterialPageRoute(
    //       builder: (context) => new SuccessRecord(),
    //     ),
    //   );
    // } else {
    //   _scaffoldKey.currentState
    //       ?.showSnackBar(SnackBar(content: Text("Please Try again")));
    // }
  }
}
