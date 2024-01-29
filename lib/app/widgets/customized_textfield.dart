import 'package:benchmark/app/config/color.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomizedTextfield extends StatelessWidget {
  final TextEditingController myController;
  final String? hintText;
  final IconData icon;
  final String? Function(String?) validator; // Validator function

  const CustomizedTextfield({
    Key? key,
    required this.icon,
    required this.validator,
    required this.myController,
    this.hintText,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        validator: validator,
        controller: myController,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: secondaryColor,
            size: 30,
          ),

          contentPadding: EdgeInsets.symmetric(
              vertical: 15, horizontal: 15), // Adjust the vertical padding
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: secondaryColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: secondaryColor, width: 1),
            borderRadius: BorderRadius.circular(10),
          ),
          fillColor: Color.fromARGB(255, 255, 255, 255),
          filled: true,
          labelText: hintText,
          labelStyle: TextStyle(color: secondaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
