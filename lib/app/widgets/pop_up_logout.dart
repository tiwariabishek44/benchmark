// LOGOUT POP UP

import 'dart:ui';

import 'package:benchmark/app/modules/common/login/login_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LogoutPopup extends StatelessWidget {
  final loginContorller = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: contentBox(context),
    );
  }

  contentBox(context) {
    return Container(
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Text(
            "BenchMark",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 20),
          Text(
            "Are you sure you want to logout?",
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              TextButton(
                onPressed: () {
                  // Handle Cancel action
                  Navigator.of(context).pop();
                },
                child: Text("Cancel"),
              ),
              SizedBox(width: 20),
              TextButton(
                onPressed: () {
                  // Handle Logout action
                  // Implement your logout logic here
                  Navigator.of(context).pop();
                  loginContorller.logout();
                },
                child: Text("Logout"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void showLogoutPopup(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Stack(
        children: [
          // Blurred background
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: Color.fromARGB(255, 202, 199, 199)
                  .withOpacity(0.02), // Adjust the opacity as needed
            ),
          ),

          // Your logout popup
          Center(
            child: LogoutPopup(),
          ),
        ],
      );
    },
  );
}
