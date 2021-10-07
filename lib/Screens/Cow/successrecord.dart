import '/Screens/Activity/addactivity.dart';
import '/navigator.dart';
import 'package:flutter/material.dart';

class SuccessRecord extends StatefulWidget {
  @override
  _SuccessRecordState createState() => _SuccessRecordState();
}

class _SuccessRecordState extends State<SuccessRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(""),
          leading: GestureDetector(
            onTap: () {},
          ),
          backgroundColor: Color(0xff62b490),
        ),
        body: Column(children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0, 150, 0, 40),
            child: Icon(
              Icons.check_circle,
              color: Color(0xff62b490),
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
                  'บันทึกข้อมูลสำเร็จ',
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
                        return Homepage();
                      }));
                    },
                    color: Colors.blueGrey[50],
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(39))),
                    child: Text(
                      'กลับหน้าแรก',
                      style: TextStyle(
                          color: Color(0xff59aca9),
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
                        return AddActivity();
                      }));
                    },
                    color: Color(0xff59aca9),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(39))),
                    child: Text(
                      'เพิ่มกิจกรรม',
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
