import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '.././Farm/join_farm_wait.dart';
import '../../models/UserDairys.dart';
import '../../util/register_store.dart';

class OTP extends StatefulWidget {
  static const routeName = '/otp';
  bool _isInit = true;

  OTP({Key? key}) : super(key: key);

  @override
  _OTPState createState() => _OTPState();
}

class _OTPState extends State<OTP> with TickerProviderStateMixin {
  String code = "";
  var onTapRecognizer;

  String user_id = '';
  String firstname = '';
  String lastname = '';
  String user_birthday = '';
  String user_image = '';
  String mobile = '';
  String email = '';
  String password = '';
  UserDairys? args;

  final SMSCodeController = TextEditingController();
  // ..text = "123456";

  FirebaseAuth auth = FirebaseAuth.instance;
  String? verificationId;
  bool hasError = false;
  String currentText = "";
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final formKey = GlobalKey<FormState>();
  String? result;
  int? enteredOtp;

  @override
  void initState() {
    super.initState();
    getRegister();
  }

  getRegister() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      user_id = (prefs.getString('user_id') ?? '');
      firstname = (prefs.getString('firstname') ?? '');
      lastname = (prefs.getString('lastname') ?? '');
      user_birthday = (prefs.getString('user_birthday') ?? '');
      mobile = (prefs.getString('mobile') ?? '');
      user_image = (prefs.getString('user_image') ?? '');
      email = (prefs.getString('email') ?? '');
      password = (prefs.getString('password') ?? '');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<RegisterStore>(builder: (_, loginStore, __) {
      return Observer(
          builder: (_) => (Scaffold(
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
                            icon: Icon(Icons.account_circle,
                                color: Colors.green[400], size: 30),
                            onPressed: () {},
                          ),
                        )),
                      ],
                    ),
                    backgroundColor: Colors.green[400],
                    key: loginStore.otpScaffoldKey),
                body: Column(
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
                          //activeColor: Colors.green[100],
                          selectedColor: Colors.green[100],
                          inactiveFillColor: Colors.green[100],
                          selectedFillColor: Colors.white,
                          inactiveColor: Colors.green[100],
                          borderRadius: BorderRadius.circular(5),
                          fieldHeight: 50,
                          fieldWidth: 30,
                          activeFillColor: Colors.white,
                          fieldOuterPadding:
                              EdgeInsets.only(left: 10, right: 10)),

                      mainAxisAlignment: MainAxisAlignment.center,

                      animationDuration: Duration(milliseconds: 300),
                      //backgroundColor: Colors.blue.shade50,
                      enableActiveFill: true,
                      //xerrorAnimationController: errorController,
                      controller: SMSCodeController,
                      onCompleted: (v) {
                        print("Completed");
                      },
                      onChanged: (value) {
                        enteredOtp = int.parse(value);
                        code = value;
                        print(enteredOtp);
                      },
                      beforeTextPaste: (text) {
                        print("Allowing to paste $text");
                        return true;
                      },
                      appContext: context,
                      pastedTextStyle: TextStyle(
                        color: Colors.green.shade600,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 30),
                      child: RaisedButton(
                        onPressed: () async {
                          loginStore.validateOtpAndLogin(
                              context,
                              code,
                              user_id,
                              email,
                              password,
                              firstname,
                              lastname,
                              user_birthday,
                              mobile,
                              user_image);
                        },
                        color: Color(0xff62b490),
                        shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(39))),
                        child: Text(
                          'ส่ง',
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
              )));
    });
  }
}
