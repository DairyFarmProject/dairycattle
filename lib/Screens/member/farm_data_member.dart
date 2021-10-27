import 'dart:convert';

import 'package:dairycattle/Screens/Farm/home.dart';
import 'package:dairycattle/Screens/Farm/join_farm.dart';
import 'package:dairycattle/Screens/Profile/editfarm.dart';

import '/Screens/Profile/accept_member.dart';
import '/Screens/Profile/profile.dart';
import '/models/Farms.dart';
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

class FarmData_member extends StatefulWidget {
  const FarmData_member({Key? key}) : super(key: key);
  @override
  _FarmData_memberState createState() => _FarmData_memberState();
}

final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
void showInSnackBar(String value) {
  _scaffoldKey.currentState!.showSnackBar(SnackBar(content: Text(value)));
}

class _FarmData_memberState extends State<FarmData_member> {
  int? farm_id;
  String? farm_no;
  String? farm_code;
  String? farm_name;
  String farm_image = '';
  String? address;
  int? moo;
  String? soi;
  String? road;
  String? sub_district;
  String? district;
  String? province;
  int? postcode;
  String? countCow;
  Uri? url;

  Future<List<Farms>> getFarm() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    late List<Farms> cows;
    Map data = {'farm_id': user?.farm_id.toString()};
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'farms/id'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);

      List list = db['data']['rows'];
      cows = list.map((e) => Farms.fromMap(e)).toList();

      print(list[0]['farm_id']);
      setState(() {
        farm_id = list[0]['farm_id'];
        farm_no = list[0]['farm_no'];
        farm_code = list[0]['farm_code'];
        farm_name = list[0]['farm_name'];
        farm_image = list[0]['farm_image'];
        address = list[0]['address'];
        moo = list[0]['moo'];
        soi = list[0]['soi'];
        road = list[0]['road'];
        sub_district = list[0]['sub_district'];
        district = list[0]['district'];
        province = list[0]['province'];
        postcode = list[0]['postcode'];
        url = Uri.parse(farm_image);
      });

      print(farm_id);
    }
    return cows;
  }

  Future getCow() async {
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    Map data = {'farm_id': user?.farm_id.toString()};
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'farms/id'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> db = jsonDecode(response.body);
      List cows = db['data']['cow'];

      setState(() {
        countCow = cows[0]['count'];
        ;
      });
      return cows;
    }
  }

  @override
  void initState() {
    super.initState();
    getFarm();
    getCow();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    User? user = Provider.of<UserProvider>(context, listen: false).user;
    return Scaffold(
        body: Container(
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Container(
                height: size.height * 0.2,
                width: size.width,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(farm_image), fit: BoxFit.cover)),
                child: Stack(
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.fromLTRB(145, 20, 0, 0),
                      height: 100,
                      width: 100,
                      child: CircleAvatar(
                        radius: 120,
                        backgroundImage: NetworkImage('${user?.user_image}'),
                      ),
                    )
                  ],
                )),
            DefaultTabController(
                length: 2,
                initialIndex: 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: TabBar(
                          indicatorColor: Colors.brown,
                          tabs: [
                            Tab(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                  Align(
                                      alignment: Alignment.center,
                                      child: Image.asset(
                                        "assets/images/icon_farm.png",
                                        color: Colors.brown,
                                        height: 20,
                                      )),
                                  Padding(padding: EdgeInsets.only(left: 5)),
                                  Text(
                                    'ฟาร์ม',
                                    style: TextStyle(color: Colors.brown),
                                  )
                                ])),
                            Tab(
                                child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                  Align(
                                      alignment: Alignment.center,
                                      child: Icon(
                                        Icons.person_outline_sharp,
                                        color: Colors.brown,
                                        size: 20,
                                      )),
                                  Padding(padding: EdgeInsets.only(left: 5)),
                                  Text(
                                    'โปรไฟล์',
                                    style: TextStyle(color: Colors.brown),
                                  )
                                ])),
                          ],
                        )),

                    Container(
                        height: 600, //height of TabBarView
                        decoration: BoxDecoration(
                            border: Border(
                                top: BorderSide(
                                    color: Colors.grey, width: 0.5))),
                        child: TabBarView(children: <Widget>[
                          Container(
                            child: Container(
                                margin: EdgeInsets.fromLTRB(20, 5, 20, 5),
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      Container(
                                        child: Text(
                                          'ข้อมูลฟาร์ม',
                                          style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.w500),
                                        ),
                                        margin: EdgeInsets.only(top: 10),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: 10, bottom: 10),
                                        width: 420,
                                        height: 160,
                                        padding:
                                            EdgeInsets.fromLTRB(30, 10, 30, 10),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15),
                                          color: Colors.blueGrey[50],
                                        ),
                                        child: Column(
                                          children: [
                                            Text(
                                                'ชื่อฟาร์ม : ${user?.farm_name}'),
                                            Text('ตำแหน่ง : เจ้าของฟาร์ม'),
                                            Text('เลขทะเบียนฟาร์ม'),
                                            Text('${user?.farm_no}'),
                                            Text(
                                                'ที่อยู่ฟาร์ม : ${address} ${sub_district} ${district} ${province} ${postcode}'),
                                            Text(
                                                'จำนวนวัวทั้งหมด : ${countCow} ตัว')
                                          ],
                                        ),
                                      ),
                                      RaisedButton(
                                        onPressed: () async {
                                          userExitFarm(
                                              user?.user_id, user?.farm_id);
                                        },
                                        color: Colors.blueGrey[50],
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(39))),
                                        child: Text(
                                          'ออกจากฟาร์ม',
                                          style: TextStyle(
                                              color: Colors.brown,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14),
                                        ),
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 10, 30, 10),
                                      )
                                    ],
                                  ),
                                )),
                          ),
                          Profile(),
                        ]))
                    // Container(
                  ],
                ))
          ],
        ),
      ),
    ));
  }

  userExitFarm(user_id, farm_id) async {
    Map data = {'user_id': user_id.toString(), 'farm_id': farm_id.toString()};
    print(data.toString());

    final response = await http.delete(
        Uri.https('heroku-diarycattle.herokuapp.com', 'worker/delete'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("Delete Success");
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Home();
        }));
      } else {
        _scaffoldKey.currentState
            ?.showSnackBar(SnackBar(content: Text("${resposne['message']}")));
      }
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("${resposne['message']}")));
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please Try again")));
    }
  }
}
