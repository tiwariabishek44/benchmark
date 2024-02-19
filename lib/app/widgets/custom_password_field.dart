import 'package:benchmark/app/config/color.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomPasswordField extends StatelessWidget {
  final TextEditingController controller;
  final String labelText;
  final bool isPasswordVisible;
  final void Function() togglePasswordVisibility;

  const CustomPasswordField({
    Key? key,
    required this.controller,
    required this.labelText,
    required this.isPasswordVisible,
    required this.togglePasswordVisibility,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h),
      child: TextFormField(
        controller: controller,
        obscureText: !isPasswordVisible,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.lock_outline),
          labelText: labelText,
          labelStyle: TextStyle(color: mainColor),
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: mainColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: mainColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Color.fromARGB(255, 255, 255, 255),
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: IconButton(
            icon: Icon(
              isPasswordVisible
                  ? Icons.visibility
                  : Icons.visibility_off_outlined,
              color: mainColor,
            ),
            onPressed: togglePasswordVisibility,
          ),
        ),
      ),
    );
  }
}
