import '/Screens/Activity/Breeding/allrecordbreeding.dart';
import '/Screens/Activity/Milk/recordmilkDay.dart';
import '/Screens/Activity/Calve/allrecordcalve.dart';
import 'Vaccine/recordvaccinemain.dart';
import 'package:flutter/material.dart';

class AddActivity extends StatefulWidget {
  @override
  _AddActivityState createState() => _AddActivityState();
}

class _AddActivityState extends State<AddActivity> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: <Widget>[
            Container(),
            Expanded(
                child: GridView.count(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
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
                      return const RecordMilkDay();
                    }));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 1,
                    color: const Color.fromRGBO(234, 177, 93, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 30),
                          child: const Text(
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
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                            color: Colors.amber[100],
                          ),
                          height: 100,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 30,
                                padding: const EdgeInsets.only(left: 20),
                                alignment: Alignment.center,
                              ),
                              const Icon(
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
                      return const RecordVaccineMain();
                    }));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 1,
                    color: const Color.fromRGBO(111, 193, 148, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 30),
                          child: const Text(
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
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                            color: Colors.green[100],
                          ),
                          height: 100,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 30,
                                padding: const EdgeInsets.only(left: 20),
                                alignment: Alignment.center,
                              ),
                              const Icon(
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
                    color: const Color.fromRGBO(185, 110, 110, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 30),
                          child: const Text(
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
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                            color: Colors.red[100],
                          ),
                          height: 100,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 30,
                                padding: const EdgeInsets.only(left: 20),
                                alignment: Alignment.center,
                              ),
                              const Icon(
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
                      return const AllRecordCalve();
                    }));
                  },
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    elevation: 1,
                    color: const Color.fromRGBO(93, 124, 234, 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.only(left: 30),
                          child: const Text(
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
                            borderRadius: const BorderRadius.only(
                                bottomLeft: Radius.circular(20),
                                topLeft: Radius.circular(20)),
                            color: Colors.indigo[100],
                          ),
                          height: 100,
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: 30,
                                padding: const EdgeInsets.only(left: 20),
                                alignment: Alignment.center,
                              ),
                              const Icon(
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
      
    );
  }
}
