import 'package:dairycattle/Screens/Welcome/text_field_container.dart';

import '/Screens/Farm/splash.dart';
import '/models/UserDairys.dart';
import '/util/shared_preference.dart';
import '../../models/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '/Screens/Welcome/constants.dart';
import '/Screens/Welcome/background.dart';
import '/Screens/Welcome/rounded_input_field.dart';
import '/Screens/Welcome/aleady_have_an_account_acheck.dart';
import '/Screens/Welcome/signup.dart';
import '/providers/auth.dart';
import '../../providers/user_provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  GlobalKey<ScaffoldState> _scaffoldKey =
      GlobalKey<ScaffoldState>(debugLabel: '_Loginkey');
  GlobalKey<FormState> _formKey = GlobalKey<FormState>(debugLabel: '_Loginkey');
  TextEditingController passwordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  String? _email, _password;
  bool isLoading = false;
  bool obscureText = true;
  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      key: _scaffoldKey,
      body: Container(
          child: Background(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "เข้าสู่ระบบ",
                  style: TextStyle(fontWeight: FontWeight.w500, fontSize: 25),
                ),
                SizedBox(height: size.height * 0.03),
                Image.asset(
                  "assets/images/Logo.png",
                  height: size.height * 0.2,
                ),
                SizedBox(height: size.height * 0.03),
                RoundedInputField(
                  controller: emailController,
                  hintText: "อีเมล",
                  onSaved: (value) => _email = value,
                  onChanged: (String email) {
                    _email = email;
                  },
                  validator: (value) {
                    if (value == null || !value.contains('@'))
                      return 'รูปแบบอีเมลไม่ถูกต้อง';
                    if (!reg.hasMatch(emailController.text))
                      return 'รูปแบบอีเมลไม่ถูกต้อง';
                    return null;
                  },
                ),
                TextFieldContainer(
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) {
                      if (value!.isEmpty) return 'กรุณากรอกรหัสผ่าน';
                      if (value.length < 6)
                        return 'รหัสผ่านควรมีอย่าง 6 ตัวอักษร';
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
                          // Based on passwordVisible state choose the icon
                          obscureText ? Icons.visibility_off : Icons.visibility,
                          color: kPrimaryColor,
                        ),
                        onPressed: () {
                          // Update the state i.e. toogle the state of passwordVisible variable
                          setState(() {
                            obscureText = !obscureText;
                          });
                        },
                      ),
                      border: InputBorder.none,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: size.width * 0.8,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(29),
                    child: FlatButton(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                      color: kPrimaryColor,
                      onPressed: () {
                        if (isLoading) {
                          return;
                        }
                        if (!reg.hasMatch(emailController.text)) {
                          _scaffoldKey.currentState?.showSnackBar(
                              SnackBar(content: Text("รูปแบบอีเมลไม่ถูกต้อง")));
                          return;
                        }
                        if (passwordController.text.isEmpty ||
                            passwordController.text.length < 6) {
                          _scaffoldKey.currentState?.showSnackBar(SnackBar(
                              content: Text("รหัสผ่านควรมีอย่าง 6 ตัวอักษร")));
                          return;
                        }
                        login(emailController.text, passwordController.text);
                        setState(() {
                          isLoading = true;
                        });
                      },
                      child: Text(
                        'เข้าสู่ระบบ',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.03),
                AlreadyHaveAnAccountCheck(
                  press: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return SignUpScreen();
                        },
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      )),
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

  login(email, password) async {
    Map data = {'email': email, 'password': password};
    print(data.toString());
    final response =
        await http.post(Uri.https('heroku-diarycattle.herokuapp.com', 'signin'),
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
      Map<String, dynamic> resposne = jsonDecode(response.body);
      Map<String, dynamic> user = resposne['data'];
      savePref(user['token']);
      UserPreferences().getToken(user['token']);
      doLogin(user['token']);
    }
    if (response.statusCode == 500) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      Map<String, dynamic> user = resposne['data'];
      String mess = user['message'];
      _showerrorDialog(mess);
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please try again!")));
    }
  }

  savePref(String token) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.setString("token", token.toString());
    preferences.commit();
  }

  doLogin(String token) async {
    AuthProvider auth = Provider.of<AuthProvider>(context, listen: false);
    final Future<Map<String, dynamic>> successfulMessage = auth.login(token);

    successfulMessage.then((response) {
      if (response["user"] != null) {
        if (response['ans'] == 'A' || response['ans'] == 'D') {
          User user = response["user"];
          print(user);
          Provider.of<UserProvider>(context, listen: false).setUser(user);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SplashPage();
          }));
        } else {
          UserDairys user = response["user"];
          print(user);
          Provider.of<UserProvider>(context, listen: false).setUserDairy(user);
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return SplashPage();
          }));
        }
      } else {
        _scaffoldKey.currentState
            ?.showSnackBar(SnackBar(content: Text("Failed Login!")));
      }
    });
  }
}
