import 'dart:async';
import 'dart:convert';

import '/models/UserDairys.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/User.dart';
import '../util/shared_preference.dart';

enum Status {
  NotLoggedIn,
  NotRegistered,
  LoggedIn,
  Registered,
  Authenticating,
  Registering,
  LoggedOut
}

class AuthProvider with ChangeNotifier {
  Status _loggedInStatus = Status.NotLoggedIn;
  Status _registeredInStatus = Status.NotRegistered;

  Status get loggedInStatus => _loggedInStatus;
  Status get registeredInStatus => _registeredInStatus;

  Future<Map<String, dynamic>> login(String token) async {
    var result;

    _loggedInStatus = Status.Authenticating;
    notifyListeners();

    print('Token : ${token}');

    Response response = await get(
      Uri.http('127.0.0.1:3000', 'me'),
      headers: {
        "Accept": "application/json",
        "Content-Type": "application/x-www-form-urlencoded",
        'x-access-token': '$token'
      },
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);

      List userData = responseData['data']['rows'];

      print(responseData['data']['message']);

      if (responseData['data']['message'] == 'A') {
        List<User> authUser = userData.map((e) => User.fromMap(e)).toList();

        UserPreferences().saveUser(
          userData[0]['user_id'],
          userData[0]['firstname'],
          userData[0]['lastname'],
          userData[0]['user_birthday'],
          userData[0]['mobile'],
          userData[0]['user_image'],
          userData[0]['email'],
          userData[0]['password'],
          userData[0]['worker_id'],
          userData[0]['role_id'],
          userData[0]['farm_id'],
          userData[0]['startwork'],
          userData[0]['role_name'],
          userData[0]['farm_no'],
          userData[0]['farm_name'],
          userData[0]['farm_image'],
          userData[0]['address'],
          userData[0]['moo'],
          userData[0]['soi'],
          userData[0]['road'],
          userData[0]['sub_district'],
          userData[0]['district'],
          userData[0]['province'],
          userData[0]['postcode'],
        );

        _loggedInStatus = Status.LoggedIn;
        notifyListeners();
        print("hi login ath");

        result = {"ans": 'A',"user": authUser[0]};
        print(result);
      } else if (responseData['data']['message'] == 'B') {
        List<UserDairys> authUser =
            userData.map((e) => UserDairys.fromMap(e)).toList();

        UserPreferences().saveUserDairy(
          userData[0]['user_id'],
          userData[0]['firstname'],
          userData[0]['lastname'],
          userData[0]['user_birthday'],
          userData[0]['mobile'],
          userData[0]['user_image'],
          userData[0]['email'],
          userData[0]['password'],
        );

        _loggedInStatus = Status.LoggedIn;
        notifyListeners();
        print("hi login ath");

        result = {"ans": 'B',"user": authUser[0]};
      } else {
        _loggedInStatus = Status.NotLoggedIn;
        notifyListeners();
        result = {
          'status': false,
          'message': json.decode(response.body)['error']
        };
      }
    }

    return result;
  }

  // Future<Map<String, dynamic>> register(String email, String password, String passwordConfirmation) async {

  //   final Map<String, dynamic> registrationData = {
  //     'user': {
  //       'email': email,
  //       'password': password,
  //       'password_confirmation': passwordConfirmation
  //     }
  //   };
  //   return await post(Uri.http('127.0.0.1:3000', 'login'),
  //       body: json.encode(registrationData),
  //       headers: {'Content-Type': 'application/json'})
  //       .then(onValue)
  //       .catchError(onError);
  // }

//   static Future<FutureOr> onValue(Response response) async {
//     var result;
//     final Map<String, dynamic> responseData = json.decode(response.body);

//     print(response.statusCode);
//     if (response.statusCode == 200) {
//       var userData = responseData['data'];

//       User authUser = User.fromJson(userData);

//       UserPreferences().saveUser(authUser);
//       result = {
//         'status': true,
//         'message': 'Successfully registered',
//         'data': authUser
//       };
//     } else {
// //      if (response.statusCode == 401) Get.toNamed("/login");
//       result = {
//         'status': false,
//         'message': 'Registration failed',
//         'data': responseData
//       };
//     }

//     return result;
//   }

  static onError(error) {
    print("the error is $error.detail");
    return {'status': false, 'message': 'Unsuccessful Request', 'data': error};
  }
}
