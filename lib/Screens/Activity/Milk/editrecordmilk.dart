import 'dart:convert';

import '/models/Milks.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../Cow/successrecord.dart';

class EditRecordMilk extends StatefulWidget {
  final Milks milk;
  EditRecordMilk({required this.milk});
  @override
  _EditRecordMilkState createState() => _EditRecordMilkState();
}

class _EditRecordMilkState extends State<EditRecordMilk> {
  @override
  void initState() {
    super.initState();
  }

  var num1 = 0, num2 = 0, sum = 0;
  DateTime? now = DateTime.now();
  var formatter = DateFormat.yMMMMd("th_TH");

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
  }

  final TextEditingController t1 = TextEditingController(text: "0");
  final TextEditingController t2 = TextEditingController(text: "0");

  Color color = Colors.grey;
  String title = 'บันทึกแล้ว';

  void doAddition() {
    if (t1.text.isEmpty) {
      _scaffoldKey.currentState?.showSnackBar(
          const SnackBar(content: Text("กรุณากรอกปริมาณน้ำนมช่วงเช้า")));
      return;
    }
    if (t2.text.isEmpty) {
      _scaffoldKey.currentState?.showSnackBar(
          const SnackBar(content: Text("กรุณากรอกปริมาณน้ำนมช่วงเย็น")));
      return;
    }

    setState(() {
      num1 = int.parse(t1.text);
      num2 = int.parse(t2.text);

      sum = num1 + num2;
    });
  }

  void doClear() {
    setState(() {
      t1.text = "0";
      t2.text = "0";
    });
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          title: const Text("แก้ไขการบันทึกน้ำนมวัว",
              style: TextStyle(fontWeight: FontWeight.bold)),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: const Color.fromRGBO(234, 177, 93, 5),
        ),
        body: Form(
            key: _formKey,
            child: Container(
              margin: const EdgeInsets.fromLTRB(20, 15, 20, 5),
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Center(
                      child: Container(
                        margin: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            IconButton(
                                icon:
                                    const Icon(Icons.navigate_before, size: 28),
                                onPressed: () {}),
                            Text(
                              DateFormat.yMMMMd("th_TH").format(DateTime.parse(
                                  widget.milk.milk_date.toString())),
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              textAlign: TextAlign.center,
                            ),
                            IconButton(
                                icon: const Icon(
                                  Icons.navigate_next,
                                  size: 24,
                                ),
                                onPressed: () {}),
                          ],
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: const Text(
                        'ช่วงเช้า',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: const Text('จำนวนน้ำนมวัว'),
                        ),
                        SizedBox(
                          width: 100,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                  hintText:
                                      widget.milk.milk_liter_morn.toString()),
                              controller: t1,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: const Text(
                            'ลิตร',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        TextButton(
                          child: const Text('บันทึก',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(10)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.brown),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          onPressed: doAddition,
                          onLongPress: () {
                            TextButton(
                              child: const Text('แก้ไข',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white)),
                              style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.all(10)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          (Colors.grey[400])!),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ))),
                              onPressed: () {},
                            );
                          },
                        ),
                      ],
                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: const Text(
                        'ช่วงเย็น',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: const Text('จำนวนน้ำนมวัว'),
                        ),
                        SizedBox(
                          width: 100,
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                hintText: '${widget.milk.milk_liter_even}',
                              ),
                              controller: t2 == 0 ? null : t2,
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.fromLTRB(0, 0, 15, 0),
                          child: const Text(
                            'ลิตร',
                            style: TextStyle(fontSize: 14),
                          ),
                        ),
                        TextButton(
                          child: const Text('บันทึก',
                              style:
                                  TextStyle(fontSize: 14, color: Colors.white)),
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all<EdgeInsets>(
                                  const EdgeInsets.all(10)),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  Colors.brown),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          onPressed: doAddition,
                          onLongPress: () {
                            TextButton(
                              child: const Text('แก้ไข',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.white)),
                              style: ButtonStyle(
                                  padding:
                                      MaterialStateProperty.all<EdgeInsets>(
                                          const EdgeInsets.all(10)),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          (Colors.grey[400])!),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ))),
                              onPressed: () {},
                            );
                          },
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.all(20),
                      margin: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                      decoration: const BoxDecoration(
                          color: Color(0xffd6786e),
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Text('จำนวนน้ำนมทั้งหมด $sum ลิตร',
                          style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 16)),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
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
                                        color: Colors.brown,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                )
                              ],
                            )),
                        Container(
                            margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                            child: Column(
                              children: [
                                RaisedButton(
                                  onPressed: () {
                                    if (t1.text.isEmpty) {
                                      _scaffoldKey.currentState?.showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "กรุณากรอกปริมาณน้ำนมช่วงเช้า")));
                                      return;
                                    }
                                    if (t2.text.isEmpty) {
                                      _scaffoldKey.currentState?.showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  "กรุณากรอกปริมาณน้ำนมช่วงเย็น")));
                                      return;
                                    }
                                    if (t1.text.isNotEmpty &&
                                        t2.text.isNotEmpty) {
                                      editMilk(
                                          widget.milk.milk_id,
                                          t1.text,
                                          t2.text,
                                          user?.farm_id,
                                          user?.user_id,
                                          widget.milk.milk_date);
                                    }
                                  },
                                  color: Colors.brown,
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(39))),
                                  child: const Text(
                                    'บันทึกการแก้ไข',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14),
                                  ),
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 12, 20, 12),
                                )
                              ],
                            )),
                      ],
                    ),
                  ],
                ),
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
          style: TextStyle(fontSize: 15),
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

  editMilk(milk_id, milk_litermorn, milkliter_even, farm_id, user_id,
      milk_date) async {
    int num1 = int.parse(milk_litermorn);
    int num2 = int.parse(milkliter_even);

    int sum = num1 + num2;

    Map<String, dynamic> data = {
      "milk_id": milk_id.toString(),
      "milk_liter_morn": num1.toString(),
      "milk_liter_even": num2.toString(),
      "milk_date": milk_date.toString(),
      "total": sum.toString(),
      "farm_id": farm_id.toString(),
      "user_id": user_id.toString()
    };
    print(data.toString());
    final response = await http.put(
        Uri.https('heroku-diarycattle.herokuapp.com', 'milks/edit'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      var user = resposne['data'];
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("${user}")));
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return SuccessRecord();
      }));
    }
    if (response.statusCode == 500) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      Map<String, dynamic> user = resposne['data'];
      String mess = user['message'];
      _showerrorDialog(mess);
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please try again!")));
    }
  }
}
