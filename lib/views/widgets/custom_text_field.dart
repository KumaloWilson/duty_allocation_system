import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../utils/colors/pallete.dart';

class CustomTextField extends StatelessWidget {
  Color? fillColor;
  Color? boarderColor;
  TextEditingController? controller;
  final String? labelText;
  final bool? obscureText;
  final TextStyle? labelStyle;
  final TextStyle? inputTextStyle;
  final TextInputType? keyBoardType;
  final Icon prefixIcon;
  Widget? suffixIconButton;
  bool? enabled;

  CustomTextField({super.key, this.controller, this.fillColor, this.boarderColor, required this.labelText, this.labelStyle, this.inputTextStyle, this.keyBoardType, required this.prefixIcon, this.obscureText, this.suffixIconButton, this.enabled});

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: keyBoardType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      controller: controller,

      enabled: enabled ?? true,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIconButton,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(color: boarderColor ?? Pallete.primaryColor),
        ),

        labelText: labelText ?? '',
        labelStyle: labelStyle ?? GoogleFonts.poppins(
          color: Colors.grey,
          fontSize: 12
        ),
      ),
      style: inputTextStyle ??  TextStyle(
          color: Pallete.primaryColor,
          fontSize: 12
      ),

    );
  }
}
