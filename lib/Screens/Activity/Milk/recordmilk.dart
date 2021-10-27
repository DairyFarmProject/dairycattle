import 'dart:convert';

import '/Screens/Activity/Milk/edit_milkDay.dart';
import '/Screens/Activity/Milk/editrecordmilk.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:provider/provider.dart';

import '../../Cow/successrecord.dart';

import 'package:flutter/material.dart';

class RecordMilk extends StatefulWidget {
  @override
  _RecordMilkState createState() => _RecordMilkState();
}

class _RecordMilkState extends State<RecordMilk> {
  var num1 = 0, num2 = 0, sum = 0;
  DateTime? now = new DateTime.now();
  var formatter = new DateFormat.yMMMMd("th_TH");

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  void showInSnackBar(String value) {
    _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
  }

  final TextEditingController t1 = new TextEditingController(text: "0");
  final TextEditingController t2 = new TextEditingController(text: "0");

  Color color = Colors.grey;
  String title = 'บันทึกแล้ว';

  void doAddition() {
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
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context).user;
    return Scaffold(
        appBar: AppBar(
          title: Text("บันทึกน้ำนมวัว",
              style: TextStyle(fontWeight: FontWeight.bold)),
          leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
          backgroundColor: Color.fromRGBO(234, 177, 93, 5),
        ),
        body: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: <Widget>[
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.navigate_before, size: 24),
                          onPressed: () {}),
                      Text(
                        '${DateFormat.yMMMMd("th_TH").format(DateTime.parse(now.toString()))}',
                        style: TextStyle(
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
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
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
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text('จำนวนน้ำนมวัว'),
                    ),
                    SizedBox(
                      width: 100,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            hintText: "0",
                          ),
                          controller: t1,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Text(
                        'ลิตร',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    TextButton(
                      child: Text('บันทึก',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(10)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff62b490)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: doAddition,
                    )
                  ],
                ),
                Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                  child: Text(
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
                      padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                      child: Text('จำนวนน้ำนมวัว'),
                    ),
                    SizedBox(
                      width: 100,
                      child: Container(
                        padding: EdgeInsets.fromLTRB(20, 10, 20, 10),
                        child: TextField(
                          keyboardType: TextInputType.number,
                          decoration: new InputDecoration(
                            hintText: "0",
                          ),
                          controller: t2,
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 15, 0),
                      child: Text(
                        'ลิตร',
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                    TextButton(
                      child: Text('บันทึก',
                          style: TextStyle(fontSize: 14, color: Colors.white)),
                      style: ButtonStyle(
                          padding: MaterialStateProperty.all<EdgeInsets>(
                              EdgeInsets.all(10)),
                          backgroundColor: MaterialStateProperty.all<Color>(
                              Color(0xff62b490)),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: doAddition,
                    ),
                  ],
                ),
                Container(
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.fromLTRB(0, 30, 0, 0),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.brown,
                      width: 2,
                    ),
                    color: Colors.white,
                    shape: BoxShape.rectangle,
                    // borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  child: Text('จำนวนน้ำนมทั้งหมด $sum ลิตร',
                      style: TextStyle(
                          color: Colors.brown[500],
                          fontWeight: FontWeight.bold,
                          fontSize: 16)),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(39))),
                              child: Text(
                                'ยกเลิก',
                                style: TextStyle(
                                    color: Colors.brown[500],
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14),
                              ),
                              padding:
                                  const EdgeInsets.fromLTRB(30, 10, 30, 10),
                            )
                          ],
                        )),
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 40, 0, 0),
                        child: Column(
                          children: [
                            // ignore: deprecated_member_use
                            RaisedButton(
                              onPressed: () {
                                addMilk(t1.text, t2.text, user?.farm_id,
                                    user?.user_id);
                              },
                              color: Colors.brown[500],
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(39))),
                              child: Text(
                                'บันทึกข้อมูล',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
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
        ));
  }

  addMilk(milk_litermorn, milkliter_even, farm_id, user_id) async {
    int num1 = int.parse(milk_litermorn);
    int num2 = int.parse(milkliter_even);

    int sum = num1 + num2;

    String now = new DateTime.now().toString();
    Map<String, dynamic> data = {
      "milk_liter_morn": num1.toString(),
      "milk_liter_even": num2.toString(),
      "milk_date": now,
      "total": sum.toString(),
      "farm_id": farm_id.toString(),
      "user_id": user_id.toString()
    };
    print(data.toString());
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'milks/create'),
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
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please try again!")));
    }
  }
}
