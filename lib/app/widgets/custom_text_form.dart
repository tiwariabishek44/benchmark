import 'package:benchmark/app/config/color.dart';
import 'package:flutter/material.dart';

extension ResponsiveSize on int {
  double get r => this * 1.0; // Replace this with your responsive calculation
}

class CustomTextForm extends StatelessWidget {
  String labelText;
  String hintText;
  Widget? iconWidget;
  TextEditingController? controller;
  bool obscureText;
  TextInputType? keyboardType;
  void Function(String)? onChanged;
  Widget? suffixIcon;
  String? Function(String?)? validator;
  bool enabled;
  void Function()? onTap;
  int? maxLines;

  CustomTextForm(
      {required this.labelText,
      required this.hintText,
      this.iconWidget,
      this.controller,
      this.obscureText = false,
      this.keyboardType,
      this.onChanged,
      this.suffixIcon,
      this.validator,
      this.onTap,
      this.maxLines = 1,
      this.enabled = true});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.r),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(10.0)),
          child: TextFormField(
            enabled: enabled,
            maxLines: maxLines,
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            onChanged: onChanged,
            textInputAction: TextInputAction.next,
            cursorColor: primaryColor,
            validator: validator,
            decoration: InputDecoration(
              suffixIcon: suffixIcon,
              labelText: labelText,
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 12.r, vertical: 14.r),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.grey.shade500)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: primaryColor)),
            ),
          ),
        ),
      ),
    );
  }
}
