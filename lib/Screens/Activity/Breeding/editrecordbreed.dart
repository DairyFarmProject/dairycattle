import 'dart:convert';

import 'package:dairycattle/models/Abdominal.dart';
import 'package:dairycattle/models/Cows.dart';
import 'package:dairycattle/models/User.dart';
import 'package:dairycattle/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:dropdown_search/dropdown_search.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '/Screens/Cow/successrecord.dart';
import '../../../models/AllChoose.dart';
import '/main.dart';
import 'package:flutter/material.dart';

class EditRecordBreed extends StatefulWidget {
  final Abdominal ab;
  EditRecordBreed({Key? key, required this.ab}) : super(key: key);

  @override
  _EditRecordBreedState createState() => _EditRecordBreedState();
}

class _EditRecordBreedState extends State<EditRecordBreed> {
  Future<List<Cows>> getCow() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    late List<Cows> cows;
    Map data = {
      'farm_id': user?.farm_id.toString(),
      'user_id': user?.user_id.toString()
    };
    final response = await http.post(Uri.http('127.0.0.1:3000', 'farms/cow'),
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

  @override
  _EditRecordBreedState createState() => _EditRecordBreedState();
  void initState() {
    super.initState();
    getCow();
  }

  DateTime? _dateTime;

  bool isShowOtherField = false;

  int _counter = 1;
  int selectCow = 1;
  int selectSpecie = 1;

  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final dadController = TextEditingController();
  final dadIdController = TextEditingController();
  final noteController = TextEditingController();

  increment() => setState(() {
        _counter++;
      });

  decrement() => setState(() {
        _counter--;
      });

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('แก้ไขบันทึกการผสมพันธ์'),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromRGBO(185, 110, 110, 5),
        ),
        body: Form(
            key: _formKey,
            child: Container(
                child: FutureBuilder<List<Cows>>(
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
                        // ignore: curly_braces_in_flow_control_structures
                        return SingleChildScrollView(
                          child: Column(
                            children: [
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                alignment: Alignment.topLeft,
                                child: Text('ชื่อแม่พันธ์',
                                    style:
                                        TextStyle(fontWeight: FontWeight.w500)),
                              ),
                              Container(
                                padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                alignment: Alignment.topLeft,
                                child: DropdownButton<Cows>(
                                  isExpanded: true,
                                  hint: new Text('select cow'),
                                  value: selectCow == null
                                      ? null
                                      : snapshot.data?[selectCow],
                                  items: snapshot.data?.map((data) {
                                    // ignore: unnecessary_new
                                    return new DropdownMenuItem<Cows>(
                                      alignment: Alignment.centerLeft,
                                      //enabled: false,
                                      value: data,
                                      child: new SizedBox(
                                        child: Text(data.cow_name),
                                      ),

                                      //enabled: false,
                                    );
                                  }).toList(growable: isShowOtherField),
                                  onChanged: (value) {
                                    setState(() {
                                      selectCow =
                                          snapshot.data!.indexOf(value!);
                                    });
                                  },
                                ),
                              ),
                              // Visibility(
                              //   visible: isShowOtherField,
                              //   child: Padding(
                              //     padding:
                              //         const EdgeInsets.fromLTRB(20, 0, 20, 20),
                              //     child: TextFormField(
                              //       decoration: InputDecoration(
                              //           labelText: 'ชื่อวัว',
                              //           fillColor: Colors.blueGrey,
                              //           focusedBorder: OutlineInputBorder(
                              //             borderSide: BorderSide(
                              //                 color: Colors.blueGrey, width: 2),
                              //           )),
                              //       onChanged: (String name) {},
                              //     ),
                              //   ),
                              // ),
                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.topLeft,
                                    margin: EdgeInsets.all(0),
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 10, 0, 10),
                                    child: Text(
                                      'รอบการผสมพันธ์',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Row(children: [
                                    Padding(
                                        padding:
                                            EdgeInsets.fromLTRB(40, 0, 0, 0),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.indeterminate_check_box,
                                            color: Colors.brown,
                                          ),
                                          onPressed: decrement,
                                        )),
                                    Padding(
                                      padding: EdgeInsets.all(3),
                                      child: Text('$_counter'),
                                    ),
                                    Padding(
                                        padding: EdgeInsets.all(0),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.add_box,
                                            color: Colors.brown,
                                          ),
                                          onPressed: increment,
                                        )),
                                  ])
                                ],
                              ),
                              Column(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                      const EdgeInsets.only(top: 10, left: 20),
                                  child: Text('หมายเลขพ่อพันธุ์',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: TextField(
                                    controller: dadIdController,
                                    decoration: InputDecoration(
                                      hintText: '${widget.ab.semen_id}',
                                      fillColor: Colors.blueGrey,
                                    ),
                                    onChanged: (String name) {},
                                  ),
                                )
                              ]),
                              Column(children: [
                                Container(
                                  alignment: Alignment.topLeft,
                                  padding:
                                      const EdgeInsets.only(top: 20, left: 20),
                                  child: Text('ชื่อพ่อพันธุ์',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500)),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: TextField(
                                    controller: dadController,
                                    decoration: InputDecoration(
                                      hintText: '${widget.ab.semen_name}',
                                      fillColor: Colors.blueGrey,
                                    ),
                                    onChanged: (String name) {},
                                  ),
                                )
                              ]),
                              Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                                    alignment: Alignment.topLeft,
                                    child: Text('ชื่อสายพันธ์',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 0, 20, 10),
                                    child: DropdownButton<Specie>(
                                      isExpanded: true,
                                      hint: new Text("Select a specie"),
                                      value: selectSpecie == null
                                          ? null
                                          : species[selectSpecie],
                                      onChanged: (newValue) {
                                        setState(() {
                                          selectSpecie =
                                              species.indexOf(newValue!);
                                          print(selectSpecie);
                                        });
                                      },
                                      items: species.map((Specie status) {
                                        return new DropdownMenuItem<Specie>(
                                          value: status,
                                          child: new Text(
                                            status.name,
                                            style: new TextStyle(
                                                color: Colors.black),
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                ],
                              ),

                              Column(
                                children: [
                                  Container(
                                    alignment: Alignment.bottomLeft,
                                    padding:
                                        const EdgeInsets.fromLTRB(20, 0, 0, 0),
                                    child: Text('วันที่',
                                        style: TextStyle(
                                            fontWeight: FontWeight.w500)),
                                  ),
                                  Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 0, 0),
                                        child: Text(
                                          _dateTime == null
                                              ? '${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.ab.ab_date.toString()))}'
                                              : '${DateFormat('dd-MM-yyyy').format(DateTime.parse(_dateTime.toString()))}',
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                            20, 0, 0, 0),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.calendar_today_sharp,
                                            color: Colors.brown,
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
                                      padding:
                                          EdgeInsets.fromLTRB(20, 0, 20, 0),
                                      child: Text('รายละเอียดอื่นๆ',
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          20, 0, 20, 0),
                                      child: TextField(
                                        controller: noteController,
                                        decoration: InputDecoration(
                                          hintText: '${widget.ab.note}',
                                          fillColor: Colors.blueGrey,
                                        ),
                                        onChanged: (String name) {},
                                      ),
                                    )
                                  ]),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 20, 0, 20),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              // ignore: deprecated_member_use
                                              RaisedButton(
                                                onPressed: () {
                                                  Navigator.pop(context);
                                                },
                                                color: Colors.blueGrey[50],
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                39))),
                                                child: Text(
                                                  'ยกเลิก',
                                                  style: TextStyle(
                                                      color: Colors.brown,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                ),
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        30, 10, 30, 10),
                                              )
                                            ],
                                          )),
                                      Container(
                                          margin:
                                              EdgeInsets.fromLTRB(0, 20, 0, 20),
                                          child: Column(
                                            children: [
                                              // ignore: deprecated_member_use
                                              RaisedButton(
                                                onPressed: () {
                                                  userEditAb(
                                                      widget.ab.abdominal_id,
                                                      selectCow,
                                                      _counter,
                                                      '${DateFormat('dd-MM-yyyy').format(DateTime.parse(_dateTime.toString()))}',
                                                      widget.ab.ab_caretaker,
                                                      dadIdController.text,
                                                      dadController.text,
                                                      selectSpecie,
                                                      noteController.text,
                                                      user?.user_id,
                                                      user?.farm_id);
                                                },
                                                color: Colors.brown,
                                                shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                39))),
                                                child: Text(
                                                  'บันทึกข้อมูล',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      fontSize: 14),
                                                ),
                                                padding:
                                                    const EdgeInsets.fromLTRB(
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
                        );
                    }))));
  }

  userEditAb(ab_id, cow_id, round, ab_date, caretaker, id, name, specie, note,
      user, farm) async {
    String ab_status = 'wait';
    String ab_calf = 'false';

    Map data = {
      'abdominal_id': ab_id.toString(),
      'cow_id': cow_id.toString(),
      'round': round.toString(),
      'ab_date': ab_date,
      'ab_status': ab_status,
      'ab_caretaker': caretaker,
      'semen_id': id,
      'semen_name': name,
      'semen_specie': specie.toString(),
      'ab_calf': ab_calf,
      'note': note,
      'user_id': user.toString(),
      'farm_id': farm.toString()
    };

    print(data);

    final response =
        await http.put(Uri.http('127.0.0.1:3000', 'abdominal/edit'),
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
