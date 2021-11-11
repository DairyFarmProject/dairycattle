import 'package:flutter/material.dart';
import 'cow1.dart';
import '/Screens/Cow/addcow1.dart';

class SuccessAddCow extends StatefulWidget {
  @override
  _SuccessAddCowState createState() => _SuccessAddCowState();
}

class _SuccessAddCowState extends State<SuccessAddCow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("เพิ่มวัว"),
          leading: GestureDetector(
            onTap: () {},
          ),
          backgroundColor: Colors.brown,
        ),
        body: Column(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 150, 0, 40),
            child: Icon(
              Icons.check_circle,
              color: Colors.brown,
              size: 80,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 0, 20),
            child: Container(
              alignment: FractionalOffset.center,
              child: Padding(
                padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                child: Text(
                  'เพิ่มข้อมูลวัวสำเร็จ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return AddCow();
                      }));
                    },
                    color: Colors.blueGrey[50],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(39))),
                    child: Text(
                      'เพิ่มวัวเพิ่ม',
                      style: TextStyle(
                          color: Colors.brown,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  )
                ],
              )),
              Container(
                  child: Column(
                children: [
                  // ignore: deprecated_member_use
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return Cow();
                      }));
                    },
                    color: Colors.brown,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(39))),
                    child: Text(
                      'ดูวัวทั้งหมด',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 14),
                    ),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                  )
                ],
              )),
            ],
          ),
        ]));
  }
}
