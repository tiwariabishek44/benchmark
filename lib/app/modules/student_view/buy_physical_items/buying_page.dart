import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/fonts.dart';
import 'package:benchmark/app/modules/common/login/login_controller.dart';
import 'package:benchmark/app/modules/common/register/register.dart';
import 'package:benchmark/app/widgets/customized_textfield.dart';
import 'package:benchmark/app/widgets/welcome_heading.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class BuyingPage extends StatefulWidget {
  @override
  State<BuyingPage> createState() => _BuyingPageState();
}

class _BuyingPageState extends State<BuyingPage> {
  final logincontroller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 55, 116, 92),
      appBar: AppBar(
        foregroundColor: whiteColor,
        title: Text(
          "Send Inquiry",
        ),
        backgroundColor:
            Color.fromARGB(255, 55, 116, 92), // Set your desired app bar color
      ),
      body: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.white, // Set your desired background color
        child: Form(
          key: logincontroller.loginFromkey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 16),
              Text(
                "To place an order for our books/notes in hardcopy, kindly complete this form. Our team member will reach out to you shortly.",
                style: TextStyle(
                  fontSize: 16.sp,
                  color: Colors.grey[600],
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16),
              CustomizedTextfield(
                validator: logincontroller.emailValidator,
                icon: Icons.person_outline,
                myController: logincontroller.emailcontroller,
                hintText: "Name",
              ),
              CustomizedTextfield(
                validator: logincontroller.emailValidator,
                icon: Icons.phone_android,
                myController: logincontroller.emailcontroller,
                hintText: "Phone No.",
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  logincontroller.signin();
                },
                style: ElevatedButton.styleFrom(
                  primary: Color.fromARGB(
                      255, 55, 116, 92), // Set your desired button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: logincontroller.isloading.value!
                      ? CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        )
                      : Text(
                          'Send Inquiry',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
