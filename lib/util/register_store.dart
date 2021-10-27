import '/Screens/Welcome/success_otp.dart';
import '/Screens/Welcome/welcome.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../Screens/Welcome/otp.dart';

part 'register_store.g.dart';

class RegisterStore = RegisterStoreBase with _$RegisterStore;

abstract class RegisterStoreBase with Store {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late String actualCode;

  @observable
  bool isLoginLoading = false;
  @observable
  bool isOtpLoading = false;

  @observable
  GlobalKey<ScaffoldState> loginScaffoldKey = GlobalKey<ScaffoldState>();
  @observable
  GlobalKey<ScaffoldState> otpScaffoldKey = GlobalKey<ScaffoldState>();

  @observable
  late User firebaseUser;

  @action
  Future<bool> isAlreadyAuthenticated() async {
    firebaseUser = _auth.currentUser!;
    if (firebaseUser != null) {
      print(firebaseUser.uid);
      return true;
    } else {
      return false;
    }
  }

  @action
  Future<void> getCodeWithPhoneNumber(
      BuildContext context, String phoneNumber) async {
    isLoginLoading = true;
    print(phoneNumber);

    await _auth.verifyPhoneNumber(
        phoneNumber: "+66" + phoneNumber,
        timeout: const Duration(seconds: 60),
        verificationCompleted: (AuthCredential auth) async {
          await _auth.signInWithCredential(auth).then((value) {
            if (value != null && value.user != null) {
              print('Authentication successful');
              onAuthenticationSuccessful(context, value);
            } else {
              loginScaffoldKey.currentState?.showSnackBar(SnackBar(
                behavior: SnackBarBehavior.floating,
                backgroundColor: Colors.red,
                content: Text(
                  'Invalid code/invalid authentication',
                  style: TextStyle(color: Colors.white),
                ),
              ));
            }
          }).catchError((error) {
            loginScaffoldKey.currentState?.showSnackBar(SnackBar(
              behavior: SnackBarBehavior.floating,
              backgroundColor: Colors.red,
              content: Text(
                'Something has gone wrong, please try later',
                style: TextStyle(color: Colors.white),
              ),
            ));
          });
        },
        verificationFailed: (authException) {
          print(
              'Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}');
          loginScaffoldKey.currentState?.showSnackBar(SnackBar(
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.red,
            content: Text(
              'The phone number format is incorrect. Please enter your number in E.164 format. [+][country code][number]',
              style: TextStyle(color: Colors.white),
            ),
          ));
          isLoginLoading = false;
        },
        codeSent: (verificationId, forceResendingToken) async {
          actualCode = verificationId;
          isLoginLoading = false;
          await Navigator.of(context)
              .push(MaterialPageRoute(builder: (_) => OTP()));
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          actualCode = verificationId;
        });
  }

  @action
  Future<void> validateOtpAndLogin(
      BuildContext context,
      String smsCode,
      String user_id,
      String email,
      String password,
      String firstname,
      String lastname,
      String user_birthday,
      String mobile,
      String user_image) async {
    isOtpLoading = true;
    final AuthCredential _authCredential = PhoneAuthProvider.credential(
        verificationId: actualCode, smsCode: smsCode);

    await _auth.signInWithCredential(_authCredential).catchError((error) {
      isOtpLoading = false;
      otpScaffoldKey.currentState?.showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.red,
        content: Text(
          'Wrong code ! Please enter the last code received.',
          style: TextStyle(color: Colors.white),
        ),
      ));
    }).then((authResult) {
      if (authResult != null && authResult.user != null) {
        print('Authentication successful');
        onAuthenticationSuccessful(context, authResult);
        register(user_id, email, password, firstname, lastname, user_birthday,
            mobile, user_image);
      }
    });
  }

  Future<void> onAuthenticationSuccessful(BuildContext context, result) async {
    isLoginLoading = true;
    isOtpLoading = true;

    firebaseUser = result.user;

    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => SuccessOTP()),
        (Route<dynamic> route) => false);

    isLoginLoading = false;
    isOtpLoading = false;
  }

  @action
  Future<void> register(
      String user_id,
      String email,
      String password,
      String firstname,
      String lastname,
      String user_birthday,
      String mobile,
      String user_image) async {
    print("Calling");

    Map data = {
      'user_id': user_id,
      'firstname': firstname,
      'lastname': lastname,
      'user_birthday': user_birthday,
      'mobile': mobile,
      'user_image': user_image,
      'email': email,
      'password': password,
    };
    print(data.toString());
    final response = await http.post(
        Uri.https('heroku-diarycattle.herokuapp.com', 'register'),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/x-www-form-urlencoded"
        },
        body: data,
        encoding: Encoding.getByName("utf-8"));

    if (response.statusCode == 200) {
      Map<String, dynamic> resposne = jsonDecode(response.body);
      if (response.statusCode == 200) {
        print("Register Success");
      } else {
        print(" ${resposne['message']}");
      }
      otpScaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("${resposne['message']}")));
    } else {
      otpScaffoldKey.currentState
          ?.showSnackBar(SnackBar(content: Text("Please Try again")));
    }
  }

  @action
  Future<void> signOut(BuildContext context) async {
    await _auth.signOut();
    await Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => Welcome()),
        (Route<dynamic> route) => false);
    //firebaseUser = null;
  }
}
