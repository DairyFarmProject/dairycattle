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
          Container(
            height: double.infinity,
            width: double.infinity,
            child: FittedBox(
              fit: BoxFit.cover,
              child: Image.network(
                'https://1.bp.blogspot.com/-LuIPepS4J1Q/X1DzycHljEI/AAAAAAAAaew/5k5f6Z9h0KwRFyDVqyVCZuK5kqqkL8hSwCLcBGAsYHQ/s16000/farm-landscape-illustration-wallpaper-hd.png',
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
