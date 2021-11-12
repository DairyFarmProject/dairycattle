import 'dart:convert';
import 'package:dairycattle/Screens/Activity/Milk/recordmilktoday.dart';
import '/Screens/Activity/Milk/recordmilk.dart';
import '/Screens/Activity/Milk/recordmilkMonth.dart';
import '/Screens/Activity/Milk/recordmilkYear.dart';
import '/models/Milks.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:http/http.dart' as http;
import '/Screens/Activity/Milk/editrecordmilk.dart';
import 'package:provider/provider.dart';

class RecordMilkDay extends StatefulWidget {
  const RecordMilkDay({Key? key}) : super(key: key);

  @override
  _RecordMilkDayState createState() => _RecordMilkDayState();
}

class _RecordMilkDayState extends State<RecordMilkDay> {
  DateTime? now = new DateTime.now();
  var formatter = new DateFormat.yMMMMd("th_TH");

  @override
  void initState() {
    super.initState();
    initializeDateFormatting();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "บันทึกน้ำนมวัว",
            // style: TextStyle(fontWeight: FontWeight.bold)
          ),
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
        body: SingleChildScrollView(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: <
                  Widget>[
            SizedBox(height: 20.0),
            DefaultTabController(
                length: 3, // length of tabs
                initialIndex: 0,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: TabBar(
                          unselectedLabelColor: Color.fromRGBO(234, 177, 93, 5),
                          indicatorSize: TabBarIndicatorSize.label,
                          indicator: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Color.fromRGBO(234, 177, 93, 5)),
                          tabs: [
                            Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: Color.fromRGBO(234, 177, 93, 5),
                                        width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("วัน"),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: Color.fromRGBO(234, 177, 93, 5),
                                        width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("เดือน"),
                                ),
                              ),
                            ),
                            Tab(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border: Border.all(
                                        color: Color.fromRGBO(234, 177, 93, 5),
                                        width: 1)),
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text("ปี"),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                          height: 700, //height of TabBarView

                          decoration: BoxDecoration(
                              border: Border(
                                  top: BorderSide(
                                      color: Colors.grey, width: 0.5))),
                          child: TabBarView(children: <Widget>[
                            RecordMilkToday(),
                            RecordMilkMonth(),
                            RecordMilkYear(),
                          ]))
                    ])),
          ]),
        ),
        floatingActionButton: FloatingActionButton.extended(
          label: Text(
            ' เพิ่มการบันทึกข้อมูล',
            style: TextStyle(
                color: Colors.white, fontWeight: FontWeight.w200, fontSize: 14),
          ),
          icon: Icon(Icons.add),
          backgroundColor: Colors.brown[500],
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return RecordMilk();
            }));
          },
        ));
  }
}
