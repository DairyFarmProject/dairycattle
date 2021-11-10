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
                'https://us.123rf.com/450wm/merggy/merggy1308/merggy130800017/21736152-vector-illustration-of-an-autumn-farm-landscape.jpg?ver=6',
              ),
            ),
          ),
          child,
        ],
      ),
    );
  }
}
