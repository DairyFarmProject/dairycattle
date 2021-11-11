import 'package:flutter/material.dart';
import '/Screens/Welcome/constants.dart';

class AlreadyHaveAnAccountCheck extends StatelessWidget {
  final bool login;
  final VoidCallback press;
  const AlreadyHaveAnAccountCheck({
    Key? key,
    this.login = true,
    required this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          login
              ? "ยังไม่มีบัญชีผู้ใช้ใช่หรือไม่ ? "
              : "มีบัญชีผู้ใช้ใช่หรือไม่ ? ",
          style: const TextStyle(color: Colors.white),
        ),
        GestureDetector(
          onTap: press,
          child: Text(
            login ? "สมัครใช้งาน" : "เข้าสู่ระบบ",
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.underline,
            ),
          ),
        )
      ],
    );
  }
}
