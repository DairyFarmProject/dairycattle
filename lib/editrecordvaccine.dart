import '/models/Vaccine_schedule.dart';
import 'package:flutter/material.dart';
import 'dart:convert';

import 'package:dropdown_search/dropdown_search.dart';

import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

import 'Screens/Cow/successrecord.dart';
import 'models/Vaccines.dart';

class EditRecordVaccine extends StatefulWidget {
  final Vaccine_schedule vac;
  EditRecordVaccine({required this.vac});
  @override
  _EditRecordVaccineState createState() => _EditRecordVaccineState();
}

class _EditRecordVaccineState extends State<EditRecordVaccine> {
  Future<List<Vaccines>> getVaccines() async {
    final response = await http.get(Uri.http('127.0.0.1:3000', 'vaccines'));

    Map<String, dynamic> data = jsonDecode(response.body);
    final List list = data['data']['rows'];

    List<Vaccines> vaccines = list.map((e) => Vaccines.fromMap(e)).toList();

    return vaccines;
  }

  @override
  void initState() {
    super.initState();
    getVaccines();
  }

  int _selectIndex = 0;

  void _onItemTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  DateTime? _dateTime;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('แก้ไขบันทึกการฉีดวัคซีน'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            // ignore: prefer_const_constructors
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color(0xff59aca9),
        ),
        body: Container(
            child: FutureBuilder<List<Vaccines>>(
          future: getVaccines(),
          builder: (context, snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                  child: Text('Loading...'),
                ),
              );
            } else
              return Container(
                child: Column(
                  children: [
                    Container(
                        child: Container(
                            margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                            child: DropdownSearch<String>(
                                mode: Mode.MENU,
                                showSelectedItems: true,
                                items: snapshot.data
                                    ?.map((data) => data.vac_name_th)
                                    .toList(),
                                label: "ชื่อวัคซีน",
                                hint: "country in menu mode",
                                popupItemDisabled: (String s) =>
                                    s.startsWith('I'),
                                onChanged: print,
                                selectedItem:
                                    '${snapshot.data?[0].vac_name_th}'),
                            padding: const EdgeInsets.all(20.0))
                        //     }
                        // )
                        ),
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
                          padding: EdgeInsets.fromLTRB(30, 20, 0, 20),
                          child: Text(
                            _dateTime == null
                                ? '${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.vac.vac_date))}'
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
                                        color: Color(0xffd6786e),
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
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 12, 20, 12))
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              );
          },
        )));
  }
}
