// CUSTOM PASSWORD FIELD

import 'package:benchmark/app/config/color.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomPasswordField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final IconData icon;
  final bool isVisible;
  final FormFieldValidator<String>? validator; // Validator function
  final VoidCallback? onPressed; // Callback function for visibility toggle

  CustomPasswordField({
    required this.controller,
    required this.labelText,
    required this.icon,
    required this.isVisible,
    this.validator, // Nullable validator parameter
    this.onPressed, // Nullable callback function
  });

  @override
  _CustomPasswordFieldState createState() => _CustomPasswordFieldState();
}

class _CustomPasswordFieldState extends State<CustomPasswordField> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: TextStyle(
            color: AppColors.mainColor), // Set your preferred text color here
        controller: widget.controller,
        obscureText: !widget.isVisible,
        validator: widget.validator, // Use the provided validator
        decoration: InputDecoration(
          errorStyle: TextStyle(color: const Color.fromARGB(255, 4, 92, 7)),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 3, 175,
                  92), // Use errorBorderColor if provided, otherwise fallback to default error color
              width: 2.0,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 15),
          prefixIcon: Icon(
            widget.icon,
            color: AppColors.mainColor,
            size: 21.5.sp,
          ),
          labelText: widget.labelText,
          labelStyle: TextStyle(color: AppColors.mainColor),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: AppColors.mainColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.mainColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          suffixIcon: IconButton(
            color: AppColors.mainColor,
            icon: Icon(
                widget.isVisible ? Icons.visibility : Icons.visibility_off),
            onPressed: () {
              if (widget.onPressed != null) {
                widget
                    .onPressed!(); // Execute the onPressed function if provided
              }
            },
          ),
        ),
      ),
    );
  }
}
