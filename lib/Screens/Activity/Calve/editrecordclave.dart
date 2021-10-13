import 'package:dropdown_search/dropdown_search.dart';
import '/Screens/Cow/successrecord.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import '../../../models/Abdominal.dart';
import 'package:http/http.dart' as http;

class EditRecordCalve extends StatefulWidget {
  const EditRecordCalve({Key? key}) : super(key: key);

  @override
  _EditRecordCalveState createState() => _EditRecordCalveState();
}

class _EditRecordCalveState extends State<EditRecordCalve> {
  DateTime? _dateTime;
  @override
  int _selectIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  String b1 = '11 ธันวาคม 63 รอบ 1 บุญมี ';
  String b2 = '21 ธันวาคม 63 รอบ 3 บุญจัง';

  String r1 = 'ปกติ';
  String r2 = 'แท้ง';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('แก้ไขบันทึกการคลอด'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xff5a82de),
        ),
        body: Container(
          child: FutureBuilder<List<Abdominal>>(
            builder: (context, snapshot) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text('Loading...'),
                  ),
                );
              } else
                return Container(
                    child: Column(children: [
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: DropdownSearch<String?>(
                        mode: Mode.MENU,
                        showSelectedItems: true,
                        items: snapshot.data
                            ?.map((data) => data.semen_name)
                            .toList(),
                        label: "ชื่อการผสมพันธ์",
                        popupItemDisabled: (String? s) => s!.startsWith('I'),
                        onChanged: print,
                        selectedItem: '${snapshot.data?[0].semen_name}'),
                    padding: const EdgeInsets.all(20.0),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        showSelectedItems: true,
                        items: [r1, r2],
                        label: "ผลการทำคลอด",
                        popupItemDisabled: (String s) => s.startsWith('I'),
                        onChanged: print,
                        selectedItem: r1),
                    padding: const EdgeInsets.all(20.0),
                  ),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.all(0),
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                        child: Text('วันที่',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
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
                                  lastDate: DateTime(2022),
                                ).then((date) {
                                  setState(() {
                                    _dateTime = date;
                                  });
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'ชื่อลูกวัว',
                              fillColor: Colors.blueGrey,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey, width: 2),
                              )),
                          onChanged: (String name) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'Tagวัว',
                              fillColor: Colors.blueGrey,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey, width: 2),
                              )),
                          onChanged: (String name) {},
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: TextFormField(
                          decoration: InputDecoration(
                              labelText: 'รายละเอียดอื่นๆ',
                              fillColor: Colors.blueGrey,
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    color: Colors.blueGrey, width: 2),
                              )),
                          onChanged: (String name) {},
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  // ignore: deprecated_member_use
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
                              margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Column(
                                children: [
                                  // ignore: deprecated_member_use

                                  RaisedButton(
                                    onPressed: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(builder: (context) {
                                        return SuccessRecord();
                                      }));
                                    },
                                    color: Color(0xff62b490),
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
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 12, 20, 12),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ],
                  )
                ]));
            },
          ),
        ));
  }
}
