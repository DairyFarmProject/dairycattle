import '/Screens/member/navigator_member.dart';
import '/Screens/Farm/home.dart';
import '/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/providers/user_provider.dart';
import 'join_farm_wait.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    Provider.of<UserProvider>(context, listen: false)
        .isAlreadyAuthenticated()
        .then((result) {
      print(result);
      if (result == 'A') {
        print('A: Go Dashboard');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Homepage();
        }));
      } else if (result == 'B') {
        print('B: Go Choose');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Home();
        }));
      } else if (result == 'C') {
        print('C: Wait Join');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return JoinFarmWait();
        }));
      } else if (result == 'D') {
        print('D: Go Worker');
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Homepage_Member();
        }));
      } else {
        print(result);
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Home();
        }));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
