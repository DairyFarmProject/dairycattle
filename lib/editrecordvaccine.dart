import 'package:dairycattle/models/AllChoose.dart';

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

  int selectVaccine = 1;
  int _selectIndex = 0;
  var date2;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _onItemTap(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  getDate(date) {
    DateTime dateTime = DateTime.parse(date);
    var newDate = new DateTime(dateTime.year, dateTime.month + 1, dateTime.day);
    var date1 =
        (DateFormat('yyyy-MM-dd').format(DateTime.parse(newDate.toString())));

    setState(() {
      date2 = date1;
    });

    print(date2);

    return date1;
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
        body: Form(
            key: _formKey,
            child: Container(
                child: FutureBuilder<List<Vaccines>>(
              future: getVaccines(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return Container(
                    child: Center(
                        child: CircularProgressIndicator(
                      color: Colors.green[400],
                    )),
                  );
                } else
                  return Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                        alignment: Alignment.topLeft,
                        child: Column(
                          children: [
                            Text('ชื่อวัคซีน',
                                style: TextStyle(fontWeight: FontWeight.w500)),
                            Container(
                                child: Container(
                                    margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                                    child: DropdownButton<Vaccines>(
                                      hint: new Text('select vaccine'),
                                      value: selectVaccine == null
                                          ? null
                                          : snapshot.data?[selectVaccine],
                                      items: snapshot.data?.map((data) {
                                        return new DropdownMenuItem<Vaccines>(
                                            value: data,
                                            child: new Text(data.vac_name_th));
                                      }).toList(),
                                      onChanged: (value) {
                                        setState(() {
                                          selectVaccine =
                                              snapshot.data!.indexOf(value!);
                                        });
                                      },
                                    ),
                                    padding: const EdgeInsets.all(20.0))
                                //     }
                                // )
                                ),
                            Container(
                              alignment: Alignment.topLeft,
                              margin: EdgeInsets.all(0),
                              padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                              child: Text('วันที่',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                            ),
                            Row(
                              children: [
                                Padding(
                                  padding: EdgeInsets.fromLTRB(30, 20, 0, 20),
                                  child: Text(
                                    _dateTime == null
                                        ? '${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.vac.vac_date))}'
                                        : '${DateFormat('dd-MM-yyyy').format(DateTime.parse(_dateTime.toString()))}',
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(10, 10, 0, 10),
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
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 10, 30, 10))
                                    ],
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.fromLTRB(0, 40, 0, 30),
                                  child: Column(
                                    children: [
                                      RaisedButton(
                                          onPressed: () {
                                            userRecordVaccine(
                                                widget.vac.schedule_id,
                                                selectVaccine,
                                                widget.vac.cow_id,
                                                '${DateFormat('yyyy-MM-dd').format(DateTime.parse(_dateTime.toString()))}',
                                                getDate(_dateTime.toString()));
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
                                              20, 12, 20, 12))
                                    ],
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  );
              },
            ))));
  }

  userRecordVaccine(
      schedule_id, vaccine_id, cow_id, vac_date, next_date) async {
    String note = '-';

    Map data = {
      'schedule_id': schedule_id.toString(),
      'vaccine_id': vaccine_id.toString(),
      'cow_id': cow_id.toString(),
      'vac_date': vac_date,
      'next_date': next_date,
      'note': note
    };

    print(data);

    final response =
        await http.put(Uri.http('127.0.0.1:3000', 'schedules/edit'),
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
