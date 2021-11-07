import 'package:dairycattle/models/UserDairys.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../models/ScreenArguments.dart';
import 'show_text_field.dart';
import 'success_create_farm.dart';
import '../../models/User.dart';
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
                child: Text('DairyCattle'),
              ),
              Expanded(
                  child: Align(
                alignment: Alignment.centerRight,
                child: IconButton(
                  icon:
                      Icon(Icons.account_circle, color: Colors.white, size: 30),
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
                    padding: EdgeInsets.all(20),
                    margin: EdgeInsets.fromLTRB(0, 15, 0, 0),
                    child: Text('สร้างฟาร์ม',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 25)),
                  ),
                  ShowTextField(
                      child: Text(
                        'ชื่อฟาร์ม',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.farm_name),
                  ShowTextField(
                      child: Text(
                        'เลขทะเบียนฟาร์ม',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.farm_no),
                  ShowTextField(
                      child: Text(
                        'ไอดีฟาร์ม',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.farm_code),
                  Column(
                    children: [
                      Container(
                        alignment: Alignment.topLeft,
                        margin: EdgeInsets.all(0),
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 10),
                        child: Text(
                          'เพิ่มรูปภาพฟาร์ม',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                      Container(
                          alignment: Alignment.topLeft,
                          margin: EdgeInsets.all(0),
                          padding: const EdgeInsets.fromLTRB(30, 10, 0, 10),
                          child: Icon(
                            Icons.add_a_photo_outlined,
                            size: 30,
                            color: Colors.blueGrey,
                          )),
                    ],
                  ),
                  ShowTextField(
                      child: Text(
                        'บ้านเลขที่',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.address),
                  ShowTextField(
                      child: Text(
                        'หมู่',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.moo),
                  ShowTextField(
                      child: Text(
                        'ซอย',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.soi),
                  ShowTextField(
                      child: Text(
                        'ถนน',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.road),
                  ShowTextField(
                      child: Text(
                        'ตำบล',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.sub_district),
                  ShowTextField(
                      child: Text(
                        'อำเภอ',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.district),
                  ShowTextField(
                      child: Text(
                        'จังหวัด',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.province),
                  ShowTextField(
                      child: Text(
                        'รหัสไปรษณีย์',
                        style: TextStyle(fontSize: 15),
                      ),
                      hintText: args.postcode),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              // ignore: deprecated_member_use
                              RaisedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
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
                                padding:
                                    const EdgeInsets.fromLTRB(30, 10, 30, 10),
                              )
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 20, 0, 20),
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
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(39))),
                                child: Text(
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
        new MaterialPageRoute(
          builder: (context) => new SuccessCreateFarm(),
        ),
      );
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please Try again")));
    }
  }
}
