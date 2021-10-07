import 'package:flutter/material.dart';

class Background extends StatelessWidget {
  final Widget child;
  const Background({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.height,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Positioned(
            bottom: -100,
            left: -50,
            child: Image.asset(
              "assets/images/welcome1.png",
              width: size.width * 0.5,
            ),
          ),
          Positioned(
            bottom: 0,
            child: Image.asset(
              "assets/images/welcome2.png",
              width: size.width * 0.2,
            ),
          ),
          Positioned(
            bottom: -100,
            right: -50,
            child: Image.asset(
              "assets/images/welcome.png",
              width: size.width * 0.5,
            ),
          ),
          child,
        ],
      ),
    );
  }
}
