import 'package:flutter/material.dart';
import '/Screens/Welcome/constants.dart';
import '/Screens/Welcome/text_field_container.dart';
import 'package:form_field_validator/form_field_validator.dart';

class RoundedPasswordField extends StatelessWidget {
  final ValueChanged<String> onChanged;
  final TextEditingController? controller;
  final String? Function(String?)? onSaved;
  const RoundedPasswordField({
    Key? key,
    required this.onChanged,
    required this.controller,
    required this.onSaved,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFieldContainer(
      child: TextFormField(
        validator: RequiredValidator(errorText: "กรุณาป้อนรหัสผ่าน"),
        obscureText: true,
        onChanged: onChanged,
        controller: controller,
        onSaved: onSaved,
        cursorColor: kPrimaryColor,
        decoration: InputDecoration(
          hintText: "รหัสผ่าน",
          icon: Icon(
            Icons.lock,
            color: kPrimaryColor,
          ),
          suffixIcon: Icon(
            Icons.visibility,
            color: kPrimaryColor,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}
