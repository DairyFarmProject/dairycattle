import '/providers/auth.dart';
import '/models/UserDairys.dart';
import '/util/shared_preference.dart';
import 'package:flutter/foundation.dart';
import '/models/User.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '/models/Cows.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

class UserProvider with ChangeNotifier {
  //late UserDairys _user;
  late Cows _cow;
  UserDairys? _userDairys;
  User? _user;

  Cows get cow => _cow;
  UserDairys? get userDairys => _userDairys;
  User? get user => _user;

  void setCow(Cows cow) {
    _cow = cow;
  }

  void setUser(User user) {
    print('set provider User');
    _user = user;
    notifyListeners();
  }

  void setUserDairy(UserDairys user) {
    print('set provider UserDairy');
    _userDairys = user;
    notifyListeners();
  }

  Future<String> isAlreadyAuthenticated() async {
    String ans = '';

    if (userDairys is UserDairys) {
      Map data = {'user_id': userDairys?.user_id.toString()};

      final response =
          await http.post(Uri.http('127.0.0.1:3000', 'farms/check'),
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded"
              },
              body: data,
              encoding: Encoding.getByName("utf-8"));

      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = json.decode(response.body);
        var user = resposne['data']['message'];
        print(user);

        if (user == 'B') {
          ans = 'B';
        } else if (user == 'C') {
          ans = 'C';
        } else {
          ans = user;
        }
      }
    } else {
      Map data = {'user_id': user?.user_id.toString()};

      final response =
          await http.post(Uri.http('127.0.0.1:3000', 'farms/check'),
              headers: {
                "Accept": "application/json",
                "Content-Type": "application/x-www-form-urlencoded"
              },
              body: data,
              encoding: Encoding.getByName("utf-8"));

      if (response.statusCode == 200) {
        Map<String, dynamic> resposne = json.decode(response.body);
        var user = resposne['data']['message'];
        print(user);

        if (user == 'A') {
          ans = 'A';
        } else {
          ans = 'D';
        }
      }
    }

    print('${user}' + '${ans}');
    print('------');

    return ans;
  }
}
