import '/Screens/Dashboard/dashboard.dart';
import '/Screens/Activity/addactivity.dart';
import '/Screens/Cow/cow1.dart';
import 'package:flutter/material.dart';

class OwnerAcceptJoin extends StatefulWidget {
  const OwnerAcceptJoin({Key? key}) : super(key: key);

  @override
  _OwnerAcceptJoinState createState() => _OwnerAcceptJoinState();
}

class _OwnerAcceptJoinState extends State<OwnerAcceptJoin> {
  int _selectPage = 0;

  final _pageOptions = [
    Dashboard(),
    Cow(),
    AddActivity(),
    Navigator(),
    Navigator()
  ];

  void _onItemTap(int index) {
    setState(() {
      _selectPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Expanded(
              child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Align(
                      alignment: Alignment.centerLeft,
                      child: Icon(
                        Icons.arrow_back_ios_outlined,
                        color: Colors.white,
                      ))),
            ),
            Center(
              child: Text('คำขอเข้าร่วมฟาร์ม'),
            ),
            Expanded(
                child: Align(
                    alignment: Alignment.centerRight,
                    child: CircleAvatar(
                      backgroundImage: AssetImage(
                          '/Users/prang/Documents/DairyCattle/finaldairy/assets/images/avatar_owner.jpeg'),
                      backgroundColor: Colors.white,
                    ))),
          ],
        ),
        backgroundColor: Colors.brown,
      ),
      body: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: 40),
                width: 450,
                height: 100,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: Colors.blueGrey[50],
                ),
                child: Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: 20)),
                    CircleAvatar(
                      backgroundImage: AssetImage(
                          '/Users/prang/Documents/DairyCattle/finaldairy/assets/images/avartar_staff.jpeg'),
                      backgroundColor: Colors.white,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Text("คุณลูกจ้าง1"),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 90, right: 20),
                      child: RaisedButton(
                        onPressed: () {},
                        color: Colors.blueGrey[50],
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(39))),
                        child: Text(
                          'ยกเลิก',
                          style: TextStyle(
                              color: Colors.brown,
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(right: 20),
                      child: RaisedButton(
                        onPressed: () {},
                        color: Colors.brown,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(39))),
                        child: Text(
                          'ยืนยัน',
                          style: TextStyle(
                              color: Colors.blueGrey[50],
                              fontWeight: FontWeight.w600,
                              fontSize: 14),
                        ),
                        padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
      //bottomNavigationBar: Nav(),
    );
  }
}
