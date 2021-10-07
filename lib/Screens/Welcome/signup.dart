import '/models/CheckEmail.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'background.dart';
import 'rounded_input_field.dart';
import 'rounded_button.dart';
import 'rounded_password_field.dart';
import 'aleady_have_an_account_acheck.dart';
import 'login.dart';

class SignUpScreen extends StatefulWidget {
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = new GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  String? _email, _password;
  bool isLoading = false;
  var reg = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
                            return 'Invalid email';
                          }
                          return null;
                        },
                      ),
                      RoundedPasswordField(
                        onSaved: (value) => _password = value,
                        controller: passwordController,
                        onChanged: (value) {},
                      ),
                      RoundedButton(
                        text: "สมัครใช้งาน",
                        press: () {
                          if (isLoading) {
                            return;
                          }
                          if (!reg.hasMatch(emailController.text)) {
                            _scaffoldKey.currentState?.showSnackBar(
                                SnackBar(content: Text("Enter Valid Email")));
                            return;
                          }
                          if (passwordController.text.isEmpty ||
                              passwordController.text.length < 6) {
                            _scaffoldKey.currentState?.showSnackBar(SnackBar(
                                content: Text(
                                    "Password should be min 6 characters")));
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

  signup(email, password) async {
    setState(() {
      isLoading = true;
    });
    print("Calling");

    Map data = {
      'email': email,
      'password': password,
    };
    print(data.toString());
    final response = await http.post(Uri.http('127.0.0.1:3000', 'signup'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      setState(() {
        isLoading = false;
      });
      Map<String, dynamic> resposne = jsonDecode(response.body);
      if (response.statusCode == 200) {
        Map<String, dynamic> user = resposne['data'];
        print(" User id ${user['user_id']}");
        savePref(user['user_id'], email, password);
        // UserPreferences().getCheckEmail(user['user_id'], email, password);
        Navigator.pushReplacementNamed(context, "/register",
            arguments: CheckEmail(
                email: email, user_id: user['user_id'], password: password));
      } else {
        print(" ${resposne['message']}");
      }
    } else {
      _scaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please Try again")));
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
