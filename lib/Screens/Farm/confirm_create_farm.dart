import 'package:dairycattle/models/UserDairys.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/ScreenArguments.dart';
import 'show_text_field.dart';
import 'success_create_farm.dart';
import '../../providers/user_provider.dart';

class ConfirmCreateFarm extends StatefulWidget {
  static const routeName = '/confirmCreateFarm';
  bool _isInit = true;
  @override
  _ConfirmCreateFarmState createState() => _ConfirmCreateFarmState();
}

class _ConfirmCreateFarmState extends State<ConfirmCreateFarm>
    with TickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  late ScreenArguments args;
  late String farm_no = '';
  late String farm_code = '';
  late String url = '';
  late String farm_name = '';
  late String address = '';
  late String moo = '';
  late String soi = '';
  late String road = '';
  late String sub_district = '';
  late String district = '';
  late String province = '';
  late String postcode = '';

  late User firebaseUser;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<bool> isAlreadyAuthenticated() async {
    firebaseUser = _auth.currentUser!;
    if (firebaseUser != null) {
      print(firebaseUser.uid);
      return true;
    } else {
      return false;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (widget._isInit) {
      args = ModalRoute.of(context)!.settings.arguments as ScreenArguments;
      farm_name = args.farm_name;
      farm_no = args.farm_no;
      farm_code = args.farm_code;
      address = args.address;
      moo = args.moo;
      soi = args.soi;
      road = args.road;
      sub_district = args.sub_district;
      district = args.district;
      province = args.province;
      postcode = args.postcode;
      url = args.url;
      widget._isInit = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    UserDairys? user = Provider.of<UserProvider>(context).userDairys;
    return Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            children: [
              Expanded(
                child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Icon(
                          Icons.arrow_back_ios_outlined,
                          color: Colors.white,
                        ))),
              ),
              const Center(
                child: Text('สร้างฟาร์ม'),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon: const Icon(Icons.account_circle,
                      color: Colors.brown, size: 30),
                  onPressed: () {},
                ),
              )),
            ],
          ),
          backgroundColor: Colors.brown,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 100),
              child: Column(
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    margin: const EdgeInsets.all(0),
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
                    child: CircleAvatar(
                        backgroundImage: NetworkImage(url), radius: 100.0),
                  ),
                  ShowTextField(
                      child: const Text(
                        'ชื่อฟาร์ม',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.farm_name),
                  ShowTextField(
                      child: const Text(
                        'เลขทะเบียนฟาร์ม',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.farm_no),
                  ShowTextField(
                      child: const Text(
                        'ไอดีฟาร์ม',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.farm_code),
                  ShowTextField(
                      child: const Text(
                        'บ้านเลขที่',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.address),
                  ShowTextField(
                      child: const Text(
                        'หมู่',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.moo),
                  ShowTextField(
                      child: const Text(
                        'ซอย',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.soi),
                  ShowTextField(
                      child: const Text(
                        'ถนน',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.road),
                  ShowTextField(
                      child: const Text(
                        'ตำบล',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.sub_district),
                  ShowTextField(
                      child: const Text(
                        'อำเภอ',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.district),
                  ShowTextField(
                      child: const Text(
                        'จังหวัด',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.province),
                  ShowTextField(
                      child: const Text(
                        'รหัสไปรษณีย์',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.postcode),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                color: Colors.blueGrey[50],
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(39))),
                                child: const Text(
                                  'ยกเลิก',
                                  style: TextStyle(
                                      color: Colors.brown,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                              )
                            ],
                          )),
                      Container(
                          margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Column(
                            children: [
                              RaisedButton(
                                onPressed: () {
                                  userCreateFarm(
                                      user?.user_id,
                                      args.farm_name,
                                      args.farm_no,
                                      args.farm_code,
                                      args.address,
                                      args.moo,
                                      args.soi,
                                      args.road,
                                      args.sub_district,
                                      args.district,
                                      args.province,
                                      args.postcode,
                                      args.url);
                                },
                                color: Colors.brown,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(39))),
                                child: const Text(
                                  'บันทึกข้อมูล',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 14),
                                ),
                                padding:
                                    const EdgeInsets.fromLTRB(20, 12, 20, 12),
                              )
                            ],
                          )),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }

  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'กรุณาตรวจสอบความถูกต้อง',
          style: TextStyle(fontSize: 17),
        ),
        content: Text(
          message,
          style: const TextStyle(fontSize: 15),
        ),
        actions: <Widget>[
          FlatButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  userCreateFarm(user_id, farm_name, farm_no, farm_code, address, moo, soi,
      road, sub_district, district, province, postcode, url) async {
    Map data = {
      'user_id': user_id.toString(),
      'farm_name': farm_name,
      'farm_no': farm_no,
      'farm_code': farm_code,
      'address': address,
      'moo': moo,
      'soi': soi,
      'road': road,
      'sub_district': sub_district,
      'district': district,
      'province': province,
      'postcode': postcode.toString(),
      'farm_image': url
    };

    print(data);

    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'farms/create'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      Map<String, dynamic> user = resposne['data'];
      print(user['message']);
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SuccessCreateFarm(),
        ),
      );
    }
    if (response.statusCode == 500) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      Map<String, dynamic> user = resposne['data'];
      String mess = user['message'];
      _showerrorDialog(mess);
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(const SnackBar(content: Text("Please Try again")));
    }
  }
}
