import '/Screens/Farm/home.dart';
import '/navigator.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/user_provider.dart';

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
      if (result) {
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return Homepage();
        }));
      } else {
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
