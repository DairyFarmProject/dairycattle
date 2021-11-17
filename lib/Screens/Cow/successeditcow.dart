import '/Screens/Cow/cow1.dart';
import '/navigator.dart';
import 'package:flutter/material.dart';

class SuccessEditCow extends StatefulWidget {
  const SuccessEditCow({Key? key}) : super(key: key);

  @override
  _SuccessEditCowState createState() => _SuccessEditCowState();
}

class _SuccessEditCowState extends State<SuccessEditCow> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("แก้ไขข้อมูลวัว"),
        leading: GestureDetector(
          onTap: () {},
        ),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
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
                  'แก้ไขข้อมูลวัวสำเร็จ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
          ),
          Container(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // ignore: deprecated_member_use
              RaisedButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return Homepage();
                  }));
                },
                color: Colors.blueGrey[50],
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(39))),
                child: Text(
                  'กลับหน้าแรก',
                  style: TextStyle(
                      color: Colors.brown,
                      fontWeight: FontWeight.w600,
                      fontSize: 14),
                ),
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              )
            ],
          )),
        ],
      ),
    );
  }
}
