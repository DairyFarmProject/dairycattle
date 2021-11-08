import '/Screens/Welcome/constants.dart';
import '/Screens/Welcome/text_field_container.dart';
import '/models/CheckEmail.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'background.dart';
import 'rounded_input_field.dart';
import 'rounded_button.dart';
import 'aleady_have_an_account_acheck.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>(debugLabel: '_SignUPkey');
  GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: '_SignUPkey');
  String? _email, _password, _cfpassword;
  bool isLoading = false;
  bool obscureText = true;
  bool obscureText2 = true;
  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPass = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        child: Background(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "ลงทะเบียน",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                ),
                SizedBox(height: size.height * 0.03),
                Image.asset(
                  "assets/images/DairyCattle1.png",
                  height: size.height * 0.25,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    children: <Widget>[
                      RoundedInputField(
                        hintText: "อีเมล",
                        controller: emailController,
                        onSaved: (value) => _email = value,
                        onChanged: (value) {},
                        validator: (value) {
                          if (value == null || !value.contains('@')) {
                            return 'รูปแบบอีเมลไม่ถูกต้อง';
                          }
                          if (!reg.hasMatch(emailController.text)) {
                            return 'รูปแบบอีเมลไม่ถูกต้อง';
                          }
                          return null;
                        },
                      ),
                      TextFieldContainer(
                        child: TextFormField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'กรุณากรอกรหัสผ่าน';
                            }
                            if (value.length < 6) {
                              return 'รหัสผ่านควรมีอย่าง 6 ตัวอักษร';
                            }
                            return null;
                          },
                          obscureText: obscureText,
                          onChanged: (String password) {
                            _password = password;
                          },
                          controller: passwordController,
                          onSaved: (value) => _password = value,
                          cursorColor: kPrimaryColor,
                          decoration: InputDecoration(
                            hintText: "รหัสผ่าน",
                            icon: Icon(
                              Icons.lock,
                              color: kPrimaryColor,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off,
                                color: kPrimaryColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  obscureText = !obscureText;
                                });
                              },
                            ),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      TextFieldContainer(
                          child: TextFormField(
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              controller: confirmPass,
                              obscureText: obscureText2,
                              onChanged: (String password) {
                                _cfpassword = password;
                              },
                              onSaved: (value) => _cfpassword = value,
                              decoration: InputDecoration(
                                hintText: "ยืนยันรหัสผ่าน",
                                icon: Icon(
                                  Icons.lock,
                                  color: kPrimaryColor,
                                ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    obscureText2
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: kPrimaryColor,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      obscureText2 = !obscureText2;
                                    });
                                  },
                                ),
                                border: InputBorder.none,
                              ),
                              validator: (val) {
                                if (val!.isEmpty) return 'กรุณากรอกรหัสผ่าน';
                                if (val != passwordController.text)
                                  return 'ยืนยันรหัสผ่านไม่ถูกต้อง';
                                return null;
                              })),
                      RoundedButton(
                        text: "สมัครใช้งาน",
                        press: () {
                          if (isLoading) {
                            return;
                          }
                          if (!reg.hasMatch(emailController.text)) {
                            _scaffoldKey.currentState?.showSnackBar(
                                SnackBar(content: Text("กรุณากรอกรหัสผ่าน")));
                            return;
                          }
                          if (passwordController.text.isEmpty ||
                              passwordController.text.length < 6) {
                            _scaffoldKey.currentState?.showSnackBar(SnackBar(
                                content:
                                    Text("รหัสผ่านควรมีอย่าง 6 ตัวอักษร")));
                            return;
                          }
                          if (confirmPass.text != passwordController.text) {
                            _scaffoldKey.currentState?.showSnackBar(SnackBar(
                                content: Text('ยืนยันรหัสผ่านไม่ถูกต้อง')));
                            return;
                          }
                          signup(emailController.text, passwordController.text);
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  login: false,
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return LoginScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showerrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          'กรุณาตรวจสอบความถูกต้อง',
          style: TextStyle(fontSize: 17),
        ),
        content: Text(
          message,
          style: TextStyle(fontSize: 15),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('OK'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          )
        ],
      ),
    );
  }

  signup(email, password) async {
    setState(() {
      isLoading = true;
    });

    Map data = {
      'email': email,
      'password': password,
    };
    print(data.toString());
    final response =
        await http.post(Uri.https('heroku-diarycattle.herokuapp.com', 'signup'),
            headers: {
              "Accept": "application/json",
              "Content-Type": "application/x-www-form-urlencoded"
            },
            body: data,
            encoding: Encoding.getByName("utf-8"));

    setState(() {
      isLoading = false;
    });
    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = json.decode(response.body);
      Map<String, dynamic> user = resposne['data'];
      print(" User id ${user['user_id']}");
      savePref(user['user_id'], email, password);
      // UserPreferences().getCheckEmail(user['user_id'], email, password);
      Navigator.pushReplacementNamed(context, "/register",
          arguments: CheckEmail(
              email: email, user_id: user['user_id'], password: password));
    }
    if (response.statusCode == 500) {
      Map<String, dynamic> resposne = json.decode(response.body);
      String user = resposne['message'];
      // String mess = user['message'];
      _showerrorDialog(user);
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please Try again!")));
    }
  }

  savePref(String user_id, String email, String password) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();

    preferences.setString("user_id", user_id);
    preferences.setString("email", email);
    preferences.setString("password", password);
    preferences.commit();
  }
}
