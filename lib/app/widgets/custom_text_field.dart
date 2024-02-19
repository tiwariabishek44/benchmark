import 'package:benchmark/app/config/color.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomizedTextfield extends StatelessWidget {
  final TextEditingController myController;
  final String? hintText;
  final IconData icon;
  final String? Function(String?) validator; // Validator function

  const CustomizedTextfield(
      {Key? key,
      required this.icon,
      required this.validator,
      required this.myController,
      this.hintText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 1.5.h),
      child: TextFormField(
        validator: validator,
        controller: myController,
        decoration: InputDecoration(
          prefixIcon: IconButton(
            icon: Icon(
              icon,
              color: mainColor,
              size: 30,
            ),
            onPressed: () {},
          ),
          enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: mainColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: mainColor, width: 1),
              borderRadius: BorderRadius.circular(10)),
          fillColor: Color.fromARGB(255, 255, 255, 255),
          filled: true,
          labelText: hintText,
          labelStyle: TextStyle(color: mainColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
