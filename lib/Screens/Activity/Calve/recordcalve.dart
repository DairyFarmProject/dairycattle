import '../../../models/CowAb.dart';
import '../../../models/Cows.dart';
import '../../../models/Parturitions.dart';
import '../../../models/User.dart';
import '../../../providers/user_provider.dart';
import 'package:dio/dio.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '/Screens/Cow/successrecord.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import '../../../models/Abdominal.dart';
import 'package:http/http.dart' as http;

class RecordCalve extends StatefulWidget {
  @override
  _RecordCalveState createState() => _RecordCalveState();
}

class _RecordCalveState extends State<RecordCalve> {
  int? ab_id;

  Future<List<CowAb>> getCow() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<CowAb> cows = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response =
        await http.post(Uri.http('127.0.0.1:3000', 'farms/abdominal/cows'),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data,
            encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      cows = list.map((e) => CowAb.fromMap(e)).toList();
    }
    return cows;
  }

  Future<List<Parturition>> getPar(int? cow_id) async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<Parturition> cows = [];
    Map data = {'user_id': user?.user_id.toString()};
    final response =
        await http.post(Uri.http('127.0.0.1:3000', 'cows/parturition'),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data,
            encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      Parturition currentCow = Parturition.fromMap(db['data']['rows']);
      cows.add(currentCow);

      setState(() {
        ab_id = currentCow.ab_id;
      });
    }
    return cows;
  }

  DateTime? _dateTime;
  int selectSex = 1;
  int? selectCow = 1;
  String? cow_id;
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
        appBar: AppBar(
          title: Text('บันทึกการคลอด'),
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
        body: Form(
            key: _formKey,
            child: Container(
                child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(children: [
                    Container(
                        child: FutureBuilder<List<CowAb>>(
                            future: getCow(),
                            builder: (context, snapshot) {
                              if (snapshot.data == null) {
                                return Container(
                                  child: Center(
                                      child: CircularProgressIndicator(
                                    color: Colors.red[400],
                                  )),
                                );
                              } else
                                return Container(
                                  padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  child: DropdownSearch<CowAb>(
                                    showSelectedItems: true,
                                    compareFn: (CowAb? i, CowAb? s) =>
                                        i!.isEqual(s),
                                    label: "วัว",
                                    onFind: (String? filter) => getData(filter),
                                    onChanged: (CowAb? data) {
                                      setState(() {
                                        ab_id = data!.abdominal_id;
                                      });
                                      print(selectCow);
                                    },
                                    dropdownBuilder: _customDropDown,
                                    popupItemBuilder: _customPopup,
                                  ),
                                );
                            })),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(0),
                      padding: const EdgeInsets.all(20),
                      child: Text('ชื่อลูกวัว',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextField(
                        controller: calfNameController,
                        decoration: InputDecoration(
                          hintText: 'ชื่อลูกวัว',
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
                      child: Text('เพศลูกวัว',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      child: DropdownSearch<String>(
                          mode: Mode.MENU,
                          showSelectedItems: true,
                          items: ["", "เพศผู้", "เพศเมีย"],
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
                            ;
                          }),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  ]),
                  Column(children: [
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.all(20),
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text('ผู้ดูแล',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                      child: TextField(
                        controller: caretakerController,
                        decoration: InputDecoration(
                          hintText: 'ชื่อผู้แล',
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
                      child: Text('สถานะ',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                    ),
                    Container(
                      child: DropdownSearch<String>(
                        mode: Mode.MENU,
                        showSelectedItems: true,
                        items: ["", "ปกติ", "แท้ง"],
                        label: "สถานะ",
                        hint: "สถานะ",
                        popupItemDisabled: (String s) => s.startsWith('I'),
                        onChanged: (newValue) {
                          setState(() {
                            status = newValue;
                          });
                        },
                      ),
                      padding: const EdgeInsets.all(20.0),
                    ),
                  ]),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.all(0),
                        padding: const EdgeInsets.fromLTRB(20, 0, 0, 10),
                        child: Text('วันที่คลอด',
                            style: TextStyle(fontWeight: FontWeight.bold)),
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(30, 20, 0, 20),
                            child: Text(
                              _dateTime == null
                                  ? 'วัน/เดือน/ปี'
                                  : '${DateFormat('dd-MM-yyyy').format(DateTime.parse(_dateTime.toString()))}',
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
                      Column(children: [
                        Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.all(20),
                          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: Text('รายละเอียดอื่นๆ',
                              style: TextStyle(fontWeight: FontWeight.w500)),
                        ),
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: TextField(
                            controller: noteController,
                            decoration: InputDecoration(
                              hintText: 'รายละเอียด',
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
                                      userAddPar(
                                          ab_id,
                                          _dateTime.toString(),
                                          calfNameController.text,
                                          sex,
                                          caretakerController.text,
                                          status,
                                          noteController.text,
                                          user?.user_id,
                                          user?.farm_id);
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
                  ),
                ],
              ),
            ))));
  }

  userAddPar(
      ab_id, date, name, sex, caretaker, status, note, user, farm) async {
    Map data = {
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

    final response =
        await http.post(Uri.http('127.0.0.1:3000', 'parturition/create'),
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

  Widget _customDropDown(BuildContext context, CowAb? item) {
    return Container(
        child: (item?.cow_name == null)
            ? ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.add_outlined),
                title: Text("กรุณาเลือกวัว"),
              )
            : ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item!.cow_image),
                ),
                title: Text("${item.cow_name}"),
              ));
  }

  Widget _customPopup(BuildContext context, CowAb? item, bool isSelected) {
    return Container(
        margin: EdgeInsets.symmetric(horizontal: 8),
        decoration: !isSelected
            ? null
            : BoxDecoration(
                border: Border.all(color: Color(0xff5a82de)),
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

  Future<List<CowAb>> getData(filter) async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<CowAb> cows = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };

    final queryParameters = {'filter': filter};

    final response = await http.post(
        Uri.http('127.0.0.1:3000', 'farms/abdominal/cows', queryParameters),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['rows'];
      cows = list.map((e) => CowAb.fromMap(e)).toList();
    }
    return cows;
  }
}
