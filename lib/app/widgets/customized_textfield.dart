import 'package:benchmark/app/config/color.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomizedTextfield extends StatelessWidget {
  final TextEditingController? myController;
  final String? hintText;
  final IconData icon;
  final String? Function(String?) validator; // Validator function

  const CustomizedTextfield({
    Key? key,
    required this.icon,
    required this.validator,
    this.myController,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        style: TextStyle(color: AppColors.mainColor),
        validator: validator,
        controller: myController,
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

          prefixIcon: Icon(
            icon,
            color: AppColors.mainColor,
            size: 21.5.sp,
          ),

          contentPadding: EdgeInsets.symmetric(
              vertical: 15, horizontal: 15), // Adjust the vertical padding
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.mainColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.mainColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Color.fromARGB(255, 255, 255, 255),
          filled: true,
          labelText: hintText,
          labelStyle: TextStyle(color: AppColors.mainColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
