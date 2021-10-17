import 'package:dairycattle/Screens/Profile/Editfarm.dart';
import 'package:dairycattle/Screens/Profile/Farm_data.dart';
import 'package:dairycattle/Screens/member/farm_data_member.dart';

import '/Screens/Farm/join_farm.dart';
import '/Screens/Profile/profile.dart';
import 'package:flutter/material.dart';

class JoinFarmWait extends StatefulWidget {
  const JoinFarmWait({Key? key}) : super(key: key);

  @override
  _JoinFarmWaitState createState() => _JoinFarmWaitState();
}

class _JoinFarmWaitState extends State<JoinFarmWait> {
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
                child: Text('เข้าร่วมฟาร์ม'),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
              )),
            ],
          ),
          backgroundColor: Colors.brown),
      body: Column(
        children: [
          Center(
            child: Container(
              margin: EdgeInsets.only(top: 40),
              width: 350,
              height: 150,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.blueGrey[50],
              ),
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(top: 20),
                    child: Text(
                      'ส่งคำขอเข้าร่วม”มีชัย”ฟาร์มเรียบร้อยแล้ว',
                      style: TextStyle(color: Colors.black),
                    ),
                  ),
                  Icon(
                    Icons.watch_later,
                    size: 62,
                    color: Colors.brown[700],
                  ),
                  Text('สถานะ : รอเจ้าของฟาร์มอนุมัติ')
                ],
              ),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 50, bottom: 30),
            child: Row(
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
                          return JoinFarm();
                        }));
                      },
                      color: Colors.blueGrey[50],
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(39))),
                      child: Text(
                        'ยกเลิกคำขอ',
                        style: TextStyle(
                            color: Colors.brown,
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                      padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                    )
                  ],
                )),
                Container(
                    child: Center(
                  child: Column(
                    children: [
                      // ignore: deprecated_member_use

                      RaisedButton(
                        onPressed: () => showDialog<String>(
                          context: context,
                          builder: (BuildContext context) => AlertDialog(
                            title: const Text('🎊🎊เข้าร่วมฟาร์มสำเร็จ🎊🎊'),
                            content: const Text(
                                'ขณะนี้เจ้าของฟาร์มได้อนุมัติคุณเป็นพนักงานในฟาร์มแล้ว'),
                            actions: <Widget>[
                              TextButton(
                                onPressed: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return FarmData_member();
                                  }));
                                },
                                child: const Text('เข้าสู่หน้าหลัก',
                                    style: TextStyle(
                                      color: Colors.green,
                                    )),
                              ),
                              TextButton(
                                onPressed: () => Navigator.pop(context, 'ปิด'),
                                child: const Text('ปิด',
                                    style: TextStyle(
                                      color: Colors.redAccent,
                                    )),
                              ),
                            ],
                          ),
                        ),

                        //() {

                        //   Navigator.push(context,
                        //       MaterialPageRoute(builder: (context) {
                        //     return JoinFarmWait();
                        //   }));
                        // },
                        color: Colors.brown,
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(39))),
                        child: Text(
                          'รีเฟรช',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16),
                        ),
                        padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
                      )
                    ],
                  ),
                )),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
