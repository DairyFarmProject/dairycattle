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
          // Container(
          //   width: 200,
          //   height: 200,
          //   decoration:
          //       BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          //   // child: CircleAvatar(
          //   //                 backgroundImage: NetworkImage('$url'),
          //   //                 radius: 100.0)
          // ),
          Container(
            child: Text(
              'โปรไฟล์',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            margin: EdgeInsets.only(top: 10),
          ),
          Container(
            margin: EdgeInsets.fromLTRB(5, 10, 5, 0),
            width: 420,
            height: 200,
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
        ],
      ),
    );
    ;
  }
}
