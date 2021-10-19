import '/Screens/Activity/Breeding/allrecordbreeding.dart';
import '/Screens/Activity/Milk/recordmilkDay.dart';
import '/Screens/Cow/cow1.dart';
import '/Screens/Cow/onecow.dart';
import '/Screens/Activity/Calve/allrecordcalve.dart';

import 'Vaccine/recordvaccinemain.dart';
import 'package:flutter/material.dart';

class AddActivity extends StatefulWidget {
  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {
  int _selectPage = 0;

  final _pageOptions = [OneCow, Cow(), AddActivity(), Navigator(), Navigator()];

  void _onItemTap(int index) {
    setState(() {
      _selectPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Column(
          children: <Widget>[
            Container(),
            Expanded(
                child: GridView.count(
              padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
              mainAxisSpacing: 10,
              crossAxisCount: 1,
              childAspectRatio: (200 / 75),
              primary: false,
              crossAxisSpacing: 5,
              children: <Widget>[
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RecordMilkDay();
                    }));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 1,
                    color: Color.fromRGBO(234, 177, 93, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            'บันทึกน้ำนมวัว',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Image.asset(
                          "assets/images/milk.png",
                          height: 80,
                          color: Colors.amber[100],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                            color: Colors.amber[100],
                          ),
                          height: 100,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 30,
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.center,
                              ),
                              Icon(
                                Icons.arrow_back_rounded,
                                color: Color.fromRGBO(234, 177, 93, 5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return RecordVaccineMain();
                    }));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 1,
                    color: Color.fromRGBO(111, 193, 148, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            'บันทึกการฉีดวัคซีน',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Image.asset(
                          "assets/images/vaccines.png",
                          height: 80,
                          color: Colors.green[100],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                            color: Colors.green[100],
                          ),
                          height: 100,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 30,
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.center,
                              ),
                              Icon(
                                Icons.arrow_back_rounded,
                                color: Color.fromRGBO(111, 193, 148, 5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AllRecordBreeding();
                    }));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 1,
                    color: Color.fromRGBO(185, 110, 110, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            'บันทึกการผสมพันธ์',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Image.asset(
                          "assets/images/love.png",
                          height: 80,
                          color: Colors.red[50],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                            color: Colors.red[100],
                          ),
                          height: 100,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 30,
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.center,
                              ),
                              Icon(
                                Icons.arrow_back_rounded,
                                color: Color.fromRGBO(185, 110, 110, 5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return AllRecordCalve();
                    }));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 1,
                    color: Color.fromRGBO(93, 124, 234, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: EdgeInsets.only(left: 30),
                          child: Text(
                            'บันทึกการคลอด',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                                fontSize: 18),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Image.asset(
                          "assets/images/pacifier.png",
                          height: 80,
                          color: Colors.indigo[100],
                        ),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                            color: Colors.indigo[100],
                          ),
                          height: 100,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 30,
                                padding: EdgeInsets.only(left: 20),
                                alignment: Alignment.center,
                              ),
                              Icon(
                                Icons.arrow_back_rounded,
                                color: Color.fromRGBO(93, 124, 234, 5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
          ],
        ),
      ),
    );
  }
}
