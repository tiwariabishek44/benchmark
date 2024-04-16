import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/modules/common/profile/edit_profile.dart/profile_controller.dart';
import 'package:benchmark/app/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class EditProfilePage extends StatelessWidget {
  EditProfilePage({super.key});

  final profileController = Get.put(ProfileController());
  @override
  Widget build(BuildContext context) {
    final userData = profileController.selectData.value;
    if (userData != null) {
      profileController.nameController.text = userData.name.toString();
      profileController.emailController.text = userData.email.toString();
      profileController.phoneNumberController.text =
          userData.mobileNumber.toString();
      profileController.phoneNumberController.text =
          userData.mobileNumber.toString();
    }
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          "Edit Profile",
          style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: AppPadding.screenHorizontalPadding,
        child: Form(
          key: profileController.formKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: Center(
                  child: Container(
                    height: 25.w,
                    width: 25.w,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          fit: BoxFit.fill,
                          image: AssetImage(
                            'assets/person.png',
                          ),
                        )),
                  ),
                ),
              ),
              // UserInputDataField(
              //   controller: profileController.nameController,
              //   label: 'Name',
              // ),
              // UserInputDataField(
              //   controller: profileController.emailController,
              //   label: 'Email',
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Please enter some text';
              //     }
              //     return null; // Return null if the input is valid
              //   },
              // ),
              // UserInputDataField(
              //   controller: profileController.phoneNumberController,
              //   label: 'Phone',
              //   validator: (value) {
              //     if (value == null || value.isEmpty) {
              //       return 'Phone number is required';
              //     }
              //     // Define a regular expression pattern for phone numbers
              //     final phoneRegex = r'^\+?\d{10,12}$';
              //     // Create a regular expression object
              //     final RegExp regex = RegExp(phoneRegex);
              //     // Check if the phone number matches the pattern
              //     if (!regex.hasMatch(value)) {
              //       return 'Invalid phone number';
              //     }
              //     // Return null if the phone number is valid
              //     return null;
              //   },
              // ),
              CustomButton(
                isLoading: false,
                onPressed: () {
                  FocusScope.of(context).unfocus();
                  profileController.updateUserData();
                },
                text: "Edit profile",
              ),
            ],
          ),
        ),
      )),
    );
  }
}
