import 'dart:convert';
import 'package:dairycattle/models/UserDairys.dart';
import 'package:http/http.dart' as http;
import '/models/User.dart';
import '/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '/Screens/Farm/join_farm_wait.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class JoinFarm extends StatefulWidget {
  const JoinFarm({Key? key}) : super(key: key);

  @override
  _JoinFarmState createState() => _JoinFarmState();
}

class _JoinFarmState extends State<JoinFarm> {
  String code = "";
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  // ..text = "123456";

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserDairys? user =
        Provider.of<UserProvider>(context, listen: false).userDairys;
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
                  child: IconButton(
                    icon: Icon(Icons.account_circle,
                        color: Colors.brown, size: 30),
                    onPressed: () {},
                  ),
                )),
              ],
            ),
            backgroundColor: Colors.brown),
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Container(
                  margin: EdgeInsets.only(top: 50, bottom: 50),
                  child: Text('กรอกรหัสเข้าร่วมฟาร์ม')),
              PinCodeTextField(
                length: 6,
                obscureText: false,
                animationType: AnimationType.fade,
                keyboardType: TextInputType.number,
                keyboardAppearance: Brightness.light,
                pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    selectedColor: Colors.brown,
                    inactiveFillColor: Colors.brown[50],
                    selectedFillColor: Colors.brown[50],
                    inactiveColor: Colors.brown,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.brown[50],
                    fieldOuterPadding: EdgeInsets.only(left: 5, right: 5)),
                mainAxisAlignment: MainAxisAlignment.center,
                animationDuration: Duration(milliseconds: 300),
                enableActiveFill: true,
                controller: textEditingController,
                onCompleted: (v) {
                  print("Completed");
                },
                onChanged: (value) {
                  code = value;
                  print(value);
                },
                beforeTextPaste: (text) {
                  print("Allowing to paste $text");
                  return true;
                },
                appContext: context,
                pastedTextStyle: TextStyle(
                  color: Colors.brown,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 30),
                child: RaisedButton(
                  onPressed: () async {
                    // () => showDialog<String>( // เป็นในกรณที่รหัสฟาร์มผิด
                    //   context: context,
                    //   builder: (BuildContext context) => AlertDialog(
                    //     title: const Text('รหัสฟาร์มไม่ถูกต้อง'),
                    //     content: const Text('โปรดตรวจสอบใหม่อีกครั้ง'),
                    //     actions: <Widget>[
                    //       TextButton(
                    //         onPressed: () => Navigator.pop(context, 'ลองใหม่'),
                    //         child: const Text('ลองใหม่'),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    userJoin(user?.user_id, code);
                  },
                  color: Colors.brown,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(39))),
                  child: Text(
                    'เข้าร่วม',
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16),
                  ),
                  padding: const EdgeInsets.fromLTRB(50, 15, 50, 15),
                ),
              ),
            ],
          ),
        ));
  }

  userJoin(user_id, farm_code) async {
    Map data = {'user_id': user_id.toString(), 'farm_code': farm_code};

    print(data);

    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'requests/add'),
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
          builder: (context) => new JoinFarmWait(),
        ),
      );
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please Try again")));
    }
  }
}
