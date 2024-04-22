import 'package:flutter/material.dart';

import '../../../themeUI/ui.dart';

class PrimaryTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController? controller;
  final bool obscureText;
  final String? Function(String?)? validator;
  final String? initialValue;
  final Function(String)?onChange;
  const PrimaryTextField(
      {super.key,
      required this.labelText,
         this.onChange,
      required this.controller,
      this.obscureText = false,
        this.initialValue,
      this.validator});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
        controller: controller,
        obscureText: obscureText,
        validator: validator,
        initialValue: initialValue,
        onChanged: onChange,
        decoration: InputDecoration(
            labelText: labelText,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(width: 1, color: Colors.black)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(width: 1, color: AppColors.primary))),
        keyboardType: TextInputType.text,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: Colors.black,
        ),
        cursorColor: Colors.black);
  }
}
