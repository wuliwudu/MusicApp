import 'package:flutter/material.dart';

class TextFieldColor extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? Function(String?)? onChanged;

  const TextFieldColor({
    super.key,
    required this.controller,
    required this.hintText,
    this.suffixIcon,
    this.onTap,
    this.validator,
    this.focusNode,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      focusNode: focusNode,
      onTap: onTap,
      textInputAction: TextInputAction.next,
      onChanged: onChanged,
      maxLines: 1,
      decoration: InputDecoration(
        suffixIcon: suffixIcon,
        contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:  BorderSide.none
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        fillColor: Color(0xffE3F0ED),
        filled: true,
        hintText: hintText,
        alignLabelWithHint: true,
        hintStyle: TextStyle(
            color: Color(0xff6E6E6E),
            fontSize: 16
        ),
      ),
    );
  }

}