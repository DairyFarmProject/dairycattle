import 'dart:convert';

import '/Screens/Cow/deletecow.dart';
import '/Screens/Cow/editcow.dart';
import '/Screens/Cow/historycow.dart';
import 'package:http/http.dart' as http;
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../models/Cows.dart';

class OneCow extends StatefulWidget {
  final Cows cow;
  OneCow({required this.cow});
  @override
  _OneCowState createState() => _OneCowState();
}

class _OneCowState extends State<OneCow> {
  Future<List<Cows>> getCow() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    late List<Cows> cows;
    Map data = {'farm_id': user?.farm_id.toString()};
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'farms/cow'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      final List list = db['data']['cows'];
      cows = list.map((e) => Cows.fromMap(e)).toList();
    }
    return cows;
  }

  @override
  Widget OneCow() {
    return IconButton(
      icon: Icon(Icons.more_vert),
      onPressed: () {
        print("you want to edit or delete");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.cow.cow_name}, ${widget.cow.cow_no}'),
        actions: [
          PopupMenuButton(
            itemBuilder: (content) => [
              PopupMenuItem(
                value: 1,
                child: Text('แก้ไขข้อมูลวัว'),
              ),
              PopupMenuItem(
                value: 2,
                child: Text('ลบวัว'),
              ),
            ],
            onSelected: (int menu) {
              print(menu);
              if (menu == 1) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => EditCow(cow: widget.cow)));
              } else if (menu == 2) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DeleteCow(cow: widget.cow)));
              }
            },
          )
        ],
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.brown[500],
      ),
      body: Container(
        child: SingleChildScrollView(
            child: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(widget.cow.cow_image),
                      fit: BoxFit.cover)),
              width: size.width,
              height: size.height * 0.3,
            ),
            Container(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Center(
                  child: Text('ข้อมูลวัว',
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 18)),
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: Container(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                      child: Text(
                        'ชื่อวัว : ${widget.cow.cow_name}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    )),
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 30, 0, 10),
                              child: Text(
                                  'วันเกิด : ${DateFormat('dd-MM-yyyy').format(DateTime.parse(widget.cow.cow_birthday))}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500))))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Container(
                alignment: FractionalOffset.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    'รหัสประจำตัว : ${widget.cow.cow_no}',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: Container(
                        child: Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child: Text(
                        'พ่อพันธ์ : ${widget.cow.semen_id}',
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    )),
                  ),
                  Expanded(
                      flex: 4,
                      child: Container(
                          alignment: FractionalOffset.bottomLeft,
                          child: Padding(
                              padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                              child: Text('แม่พันธ์ : ${widget.cow.mom_id}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500))))),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 0, 0),
              child: Container(
                alignment: FractionalOffset.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    'สายพันธุ์ : ${widget.cow.specie_name_th}',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 0, 20),
              child: Container(
                alignment: FractionalOffset.bottomLeft,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                  child: Text(
                    'รายละเอียดอื่นๆ : ${widget.cow.note}',
                    style: TextStyle(fontWeight: FontWeight.w500),
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.fromLTRB(0, 15, 0, 20),
                child: Column(
                  children: [
                    // ignore: deprecated_member_use
                    RaisedButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    HistoryCow(cow: widget.cow)));
                      },
                      color: Color(0xff6d78e1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(39))),
                      child: Text(
                        'ดูประวัติ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 14),
                      ),
                      padding: const EdgeInsets.fromLTRB(40, 12, 40, 12),
                    )
                  ],
                )),
          ],
        )),
      ),
    );
  }
}
