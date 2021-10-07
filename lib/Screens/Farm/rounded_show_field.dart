import 'package:flutter/material.dart';

class RoundedShowField extends StatelessWidget {
  final String hintText;
  const RoundedShowField({
    Key? key,
    required this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
          readOnly: true,
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          )),
    );
  }
}
