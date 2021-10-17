import '/Screens/Farm/join_farm_wait.dart';
import '/Screens/Profile/profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class JoinFarm extends StatelessWidget {
  String code = "";
  var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
  // ..text = "123456";

  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();

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
                child: IconButton(
                  icon:
                      Icon(Icons.account_circle, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return Profile();
                    }));
                  },
                ),
              )),
            ],
          ),
          backgroundColor: Colors.brown),
      body: Column(
        children: <Widget>[
          Container(
              margin: EdgeInsets.only(top: 50, bottom: 50),
              child: Text('กรอกรหัสเข้าร่วมฟาร์ม')),
          PinCodeTextField(
            length: 5,
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
                fieldHeight: 70,
                fieldWidth: 50,
                activeFillColor: Colors.brown[50],
                fieldOuterPadding: EdgeInsets.only(left: 10, right: 10)),
            mainAxisAlignment: MainAxisAlignment.center,
            animationDuration: Duration(milliseconds: 300),
            enableActiveFill: true,
            controller: textEditingController,
            onCompleted: (v) {
              print("Completed");
            },
            onChanged: (value) {
              print(value);
            },
            beforeTextPaste: (text) {
              print("Allowing to paste $text");
              //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
              //but you can show anything you want here, like your pop up saying wrong paste format or etc
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
              onPressed: () {
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

                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return JoinFarmWait();
                }));
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
    );
  }
}
