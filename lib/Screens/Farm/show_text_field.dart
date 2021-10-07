import 'package:flutter/material.dart';
import 'rounded_show_field.dart';

class ShowTextField extends StatelessWidget {
  final Widget child;
  final String hintText;
  const ShowTextField({
    Key? key,
    required this.child,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
            alignment: Alignment.topLeft,
            child: Padding(
                padding: EdgeInsets.fromLTRB(23, 20, 0, 0), child: child)),
        Padding(
            padding: EdgeInsets.fromLTRB(20, 0, 20, 20),
            child: RoundedShowField(
              hintText: hintText,
            )),
      ],
    );
  }
}
