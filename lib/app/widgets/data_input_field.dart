import 'package:flutter/material.dart';

class UserInputDataField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String? Function(String?)? validator; // Validator function

  UserInputDataField({
    required this.label,
    required this.controller,
    this.validator, // Validator parameter
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
          vertical: 8.0, horizontal: MediaQuery.of(context).size.width * 0.05),
      child: Row(
        children: [
          // Label
          Text(
            "${label} :",
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 15,
            ),
          ),
          SizedBox(width: 16), // Adjust the space between label and input field

          // Input Field with grey underline when unfocused and green when focused
          Expanded(
            child: TextFormField(
              controller: controller,
              validator: validator, // Set the provided validator function
              decoration: InputDecoration(
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
