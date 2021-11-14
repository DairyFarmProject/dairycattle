import 'dart:convert';
import 'package:dairycattle/Screens/Cow/successrecord.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';

import '/models/Cows.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '/models/AllChoose.dart';

class RecordVacine extends StatefulWidget {
  @override
  _RecordVacineState createState() => _RecordVacineState();
}

class _RecordVacineState extends State<RecordVacine> {
  Future<List<Cows>> getCow() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<Cows> cows = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'farms/cow'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      cows = list.map((e) => Cows.fromMap(e)).toList();
    }
    return cows;
  }

  int selectVaccine = 0;
  int vac = 0;
  int? cow_id;
  int? cow;
  int? one = 1;
  var date2;
  DateTime? _dateTime;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final noteController = TextEditingController();

  getDate(date) {
    DateTime dateTime = DateTime.parse(date);
    var newDate = DateTime(dateTime.year, dateTime.month + 1, dateTime.day);
    var date1 =
        (DateFormat('yyyy-MM-dd').format(DateTime.parse(newDate.toString())));

    setState(() {
      date2 = date1;
    });

    print(date2);

    return date1;
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text('บันทึกการฉีดวัคซีน'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromRGBO(111, 193, 148, 5),
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              FutureBuilder<List<Cows>>(
                  future: getCow(),
                  builder: (context, snapshot) {
                    if (snapshot.data == null) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: Color.fromRGBO(111, 193, 148, 5),
                        ),
                      );
                    }
                    return Container(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                      child: DropdownSearch<Cows>(
                        showSelectedItems: true,
                        compareFn: (Cows? i, Cows? s) => i!.isEqual(s),
                        label: "วัว",
                        onFind: (String? filter) => getData(filter),
                        onChanged: (Cows? data) {
                          setState(() {
                            cow_id = data!.cow_id;
                          });
                        },
                        dropdownBuilder: _customDropDown,
                        popupItemBuilder: _customPopup,
                      ),
                    );
                  }),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                child: const Text('ชื่อวัคซีน',
                    style: TextStyle(fontWeight: FontWeight.w500)),
              ),
              Container(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                child: DropdownButton<Vaccine>(
                  isExpanded: true,
                  hint: const Text("Select a vaccine"),
                  value: selectVaccine == null ? null : vacs[selectVaccine],
                  onChanged: (newValue) {
                    setState(() {
                      selectVaccine = vacs.indexOf(newValue!);
                      print(selectVaccine);
                    });
                  },
                  items: vacs.map((Vaccine status) {
                    return DropdownMenuItem<Vaccine>(
                      value: status,
                      child: Text(
                        status.name,
                        style: const TextStyle(color: Colors.black),
                      ),
                    );
                  }).toList(),
                ),
              ),
              Container(
                alignment: Alignment.topLeft,
                padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                child: const Text('วันที่',
                    style: TextStyle(fontWeight: FontWeight.w500)),
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                    child: Text(
                      _dateTime == null
                          ? 'วัน/เดือน/ปี'
                          : DateFormat('dd-MM-yyyy')
                              .format(DateTime.parse(_dateTime.toString())),
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
                  )
                ],
              ),
              Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.fromLTRB(20, 30, 0, 0),
                    child: const Text('รายละเอียดอื่นๆ',
                        style: TextStyle(fontWeight: FontWeight.w500)),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                    child: TextField(
                      controller: noteController,
                      decoration: const InputDecoration(
                        fillColor: Colors.blueGrey,
                      ),
                      onChanged: (String name) {},
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 40, 0, 30),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            color: Colors.blueGrey[50],
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(39))),
                            child: const Text(
                              'ยกเลิก',
                              style: TextStyle(
                                  color: Colors.brown,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10))
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(0, 40, 0, 30),
                    child: Column(
                      children: [
                        RaisedButton(
                            onPressed: () {
                              if (cow_id == null) {
                                _scaffoldKey.currentState?.showSnackBar(
                                    const SnackBar(
                                        content: Text(
                                            "กรุณาเลือกวัวที่จะบันทึกข้อมูล")));
                                return;
                              }
                              if (selectVaccine != null) {
                                setState(() {
                                  vac = selectVaccine;
                                  vac = vac + 1;
                                });
                              }
                              if (_dateTime == null) {
                                _scaffoldKey.currentState?.showSnackBar(
                                    const SnackBar(
                                        content:
                                            Text("กรุณากรอกวันฉีดวัคซีน")));
                                return;
                              }
                              if (noteController.text.isEmpty) {
                                setState(() {
                                  noteController.text = '-';
                                });
                              }
                              if (cow_id != null && _dateTime != null) {
                                userRecordVaccine(
                                    vac,
                                    cow_id,
                                    _dateTime,
                                    getDate(_dateTime.toString()),
                                    noteController.text,
                                    user?.user_id,
                                    user?.farm_id);
                              }
                            },
                            color: Colors.brown,
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(39))),
                            child: const Text(
                              'บันทึกข้อมูล',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 14),
                            ),
                            padding: const EdgeInsets.fromLTRB(20, 12, 20, 12))
                      ],
                    ),
                  )
                ],
              )
            ],
          ),
        ));
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

  userRecordVaccine(
      vac_id, cow_id, vac_date, next_date, note, user, farm) async {
    Map data = {
      'vaccine_id': vac_id.toString(),
      'cow_id': cow_id.toString(),
      'vac_date': vac_date,
      'next_date': next_date,
      'note': note,
      'user_id': user.toString(),
      'farm_id': farm.toString()
    };

    print(data);

    final response = await http.post(
        Uri.http('heroku-diarycattle.herokuapp.com', 'schedules/create'),
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

  Widget _customDropDown(BuildContext context, Cows? item) {
    return Container(
        child: (item?.cow_name == null)
            ? const ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.add_outlined),
                title: Text("กรุณาเลือกวัว"),
              )
            : ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item!.cow_image),
                ),
                title: Text("${item.cow_name}"),
              ));
  }

  Widget _customPopup(BuildContext context, Cows? item, bool isSelected) {
    return Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: !isSelected
            ? null
            : BoxDecoration(
                border: Border.all(color: const Color(0xff5a82de)),
                borderRadius: BorderRadius.circular(5),
                color: Colors.white),
        child: ListTile(
          selected: isSelected,
          title: Text(item!.cow_name),
          leading: CircleAvatar(
            backgroundImage: NetworkImage(item.cow_image),
          ),
        ));
  }

  Future<List<Cows>> getData(filter) async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<Cows> cows = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };

    final queryParameters = {'filter': filter};

    final response = await http.post(
        Uri.https(
            'heroku-diarycattle.herokuapp.com', 'farms/cow', queryParameters),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      cows = list.map((e) => Cows.fromMap(e)).toList();
    }
    return cows;
  }
}
