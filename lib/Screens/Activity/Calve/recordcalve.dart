import '../../../models/CowAb.dart';
import '../../../models/User.dart';
import '../../../providers/user_provider.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '/Screens/Cow/successrecord.dart';
import 'package:flutter/material.dart';

import 'dart:convert';
import 'package:http/http.dart' as http;

class RecordCalve extends StatefulWidget {
  @override
  _RecordCalveState createState() => _RecordCalveState();
}

class _RecordCalveState extends State<RecordCalve> {
  Future<List<CowAb>> getCow() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<CowAb> cows = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'cows/abdominal/success'),
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

  DateTime? _dateTime;
  int selectSex = 0;
  int? selectCow = 0;
  int? ab_id;
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
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Column(children: [
                    FutureBuilder<List<CowAb>>(
                        future: getCow(),
                        builder: (context, snapshot) {
                          if (snapshot.data == null) {
                            return Center(
                              child: CircularProgressIndicator(
                                color: Colors.red[400],
                              ),
                            );
                          }
                          return Container(
                            padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
                            child: DropdownSearch<CowAb>(
                              showSelectedItems: true,
                              compareFn: (CowAb? i, CowAb? s) => i!.isEqual(s),
                              label: "วัว",
                              onFind: (String? filter) => getData(filter),
                              onChanged: (CowAb? data) {
                                setState(() {
                                  ab_id = data!.abdominal_id;
                                });
                              },
                              dropdownBuilder: _customDropDown,
                              popupItemBuilder: _customPopup,
                            ),
                          );
                        }),
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
                        decoration: const InputDecoration(
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
                            ;
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
                        decoration: const InputDecoration(
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
                      margin: const EdgeInsets.all(20),
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
                                  ? 'วัน/เดือน/ปี'
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
                            decoration: const InputDecoration(
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
                              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
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
                                          color: Colors.brown,
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
                                      if (ab_id == null) {
                                        _scaffoldKey.currentState?.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "กรุณาเลือกวัวที่จะบันทึกข้อมูล")));
                                        return;
                                      }
                                      if (calfNameController.text.isEmpty) {
                                        _scaffoldKey.currentState?.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "กรุณากรอกชื่อลูกวัว")));
                                        return;
                                      }
                                      if (sex == null) {
                                        _scaffoldKey.currentState?.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "กรุณากรอกเพศลูกวัว")));
                                        return;
                                      }
                                      if (caretakerController.text.isEmpty) {
                                        _scaffoldKey.currentState?.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "กรุณากรอกชื่อผู้ดูแล")));
                                        return;
                                      }
                                      if (status == null) {
                                        _scaffoldKey.currentState?.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "กรุณากรอกผลสถานะการคลอด")));
                                        return;
                                      }
                                      if (_dateTime == null) {
                                        _scaffoldKey.currentState?.showSnackBar(
                                            const SnackBar(
                                                content: Text(
                                                    "กรุณากรอกวันที่ลูกวัวคลอด")));
                                        return;
                                      }
                                      if (noteController.text.isEmpty) {
                                        setState(() {
                                          noteController.text = '-';
                                        });
                                      }
                                      if (ab_id != null &&
                                          calfNameController.text.isNotEmpty &&
                                          sex != null &&
                                          caretakerController.text.isNotEmpty &&
                                          status != null &&
                                          _dateTime != null) {
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

    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'parturition/create'),
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
    }
    else {
      _scaffoldKey.currentState
          ?.showSnackBar(const SnackBar(content: Text("Please Try again")));
    }
  }

  Widget _customDropDown(BuildContext context, CowAb? item) {
    return Container(
        child: (item?.cow_name == null)
            ? const ListTile(
                contentPadding: EdgeInsets.all(0),
                leading: Icon(Icons.add_outlined),
                title: Text("กรุณาเลือกวัว"),
              )
            : ListTile(
                contentPadding: const EdgeInsets.all(0),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(item!.cow_image),
                ),
                title: Text("${item.cow_name}"),
              ));
  }

  Widget _customPopup(BuildContext context, CowAb? item, bool isSelected) {
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

  Future<List<CowAb>> getData(filter) async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    List<CowAb> cows = [];
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };

    final queryParameters = {'filter': filter};

    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'cows/abdominal/success',
            queryParameters),
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
