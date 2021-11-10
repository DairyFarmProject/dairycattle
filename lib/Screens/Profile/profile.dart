import 'package:dairycattle/Screens/Profile/editprofile.dart';
import 'package:dairycattle/Screens/Welcome/welcome.dart';

import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    Uri url = Uri.parse('${user?.user_image}');
    return Scaffold(
      body: Column(
        children: [
          Container(
            child: Text(
              'โปรไฟล์',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            margin: EdgeInsets.only(top: 10),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(15, 10, 15, 20),
            width: 420,
            height: 160,
            padding: EdgeInsets.fromLTRB(30, 30, 30, 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.blueGrey[50],
            ),
            child: Column(
              children: [
                Text('ชื่อ : ${user?.firstname}'),
                Text('นามสกุล : ${user?.lastname}'),
                Text(
                    'วันเกิด : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(user!.user_birthday.toString()))}'),
                Text('เบอร์มือถือ : ${user.mobile}'),
              ],
            ),
          ),
          RaisedButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                return EditProfile();
              }));
            },
            color: Colors.blueGrey[50],
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(39))),
            child: Text(
              'แก้ไขข้อมูลส่วนตัว',
              style: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.w600,
                  fontSize: 14),
            ),
            padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
          ),
          Container(
            margin: EdgeInsets.only(top: 5),
            child: RaisedButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return Welcome();
                }));
              },
              color: Colors.brown,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(39))),
              child: Text(
                'ออกจากระบบ',
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 14),
              ),
              padding: const EdgeInsets.fromLTRB(45, 10, 45, 10),
            ),
          )
        ],
      ),
    );
    ;
  }
}
