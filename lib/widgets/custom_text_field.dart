// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:trackizer/common/App_Colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final IconData? prefixIcon;
  final IconButton? suffixIcon;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final Color? textColor;
  final bool? obscureText;
  final Color? color;
  const CustomTextField({
    super.key,
    required this.label,
    this.prefixIcon,
    this.controller,
    this.textColor,
    this.obscureText = false,
    this.color,
    this.textInputType = TextInputType.text,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: AppColors.white,
      obscureText: obscureText!,
      controller: controller,
      keyboardType: textInputType,
      style: TextStyle(
        color: textColor ?? AppColors.white.withOpacity(0.8),
        fontSize: 16,
      ),
      decoration: InputDecoration(
        labelText: label,
        contentPadding: EdgeInsets.symmetric(vertical: 25),
        labelStyle: TextStyle(color: color ?? AppColors.white.withOpacity(0.8)),
        filled: true,
        fillColor: Colors.transparent,
        prefixIcon:
            prefixIcon != null
                ? Icon(
                  prefixIcon,
                  color: color ?? AppColors.white.withOpacity(0.8),
                )
                : null,
        suffixIcon: suffixIcon,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: color ?? AppColors.white.withOpacity(0.8),
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: AppColors.secondary0),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: color ?? AppColors.white.withOpacity(0.8),
          ),
        ),
      ),
    );
  }
}
