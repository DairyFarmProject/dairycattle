import 'package:flutter/material.dart';
import 'rounded_input_field.dart';

class TextFieldContainer extends StatelessWidget {
  final Widget child;
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final String hintText;
  final TextInputType? keyboardType;
  const TextFieldContainer({
    Key? key,
    required this.child,
    required this.hintText,
    required this.onChanged,
    required this.validator,
    required this.controller,
    required this.keyboardType,
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
            child: RoundedInputField(
              keyboardType: keyboardType,
              hintText: hintText,
              onChanged: onChanged,
              validator: validator,
              controller: controller,
            )),
      ],
    );
  }
}
