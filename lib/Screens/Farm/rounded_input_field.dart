import 'package:flutter/material.dart';
class RoundedInputField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hintText;
  final TextInputType? keyboardType;
  const RoundedInputField({
    Key? key,
    required this.hintText,
    required this.onChanged,
    required this.validator,
    required this.keyboardType,
    required this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      width: size.width * 0.9,
      decoration: BoxDecoration(
        color: Colors.green[50],
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextFormField(
          validator: validator,
          keyboardType: keyboardType,
          controller: controller,
          onChanged: onChanged,
          cursorColor: Colors.green[900],
          decoration: InputDecoration(
            hintText: hintText,
            border: InputBorder.none,
          )),
    );
  }
}
