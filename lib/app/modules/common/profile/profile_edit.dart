// import 'dart:ffi';
// import 'dart:io';
// import 'package:benchmark/app/modules/common/profile/profile_controller.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';  

// class ProfileEdit extends StatelessWidget {
//   final profileController = Get.put(ProfileController());
//   @override
//   Widget build(BuildContext context) {
//     // final userData = profileController.selectData.value;
//     // if (userData != null) {
//     //   profileController.firstNameController.text =
//     //       userData.firstName.toString();
//     //   profileController.lastNameController.text = userData.lastName.toString();
//     //   profileController.emailController.text = userData.email.toString();
//     //   profileController.phoneNumberController.text =
//     //       userData.mobileNumber.toString();
//     // }
//     // logger.d(image!.path);
//     return WillPopScope(
//       onWillPop: () async {
//         // Call the resetImage method when the back button is pressed
//         profileController.resetImage();
//         // Return true to allow the back navigation
//         return true;
//       },
//       child: Scaffold(
//           appBar: AppBar(
//             title: Text(
//               'Edit Profile',
//               style: TextStyles.headingStyle,
//             ),
//             centerTitle: true,
//             elevation: 0,
//           ),
//           body: Form(
//             key: profileController.formKey,
//             child: ListView(
//               padding: EdgeInsets.symmetric(vertical: 4.w, horizontal: 16.w),
//               children: [
//                 Obx(() => Stack(
//                       alignment: Alignment.center,
//                       children: [
//                         profileController.image.value.path.isEmpty
//                             ? CircleAvatar(
//                                 radius: 80.r,
//                                 backgroundImage: NetworkImage(profileController
//                                     .selectData.value!.profilePictureUrl))
//                             : CircleAvatar(
//                                 radius: 80.r,
//                                 backgroundImage: FileImage(
//                                     File(profileController.image.value.path)),
//                               ),
//                         Positioned(
//                           bottom: 0,
//                           right: 120.r,
//                           child: GestureDetector(
//                             onTap: () {
//                               profileController.pickImages();
//                             },
//                             child: Container(
//                               decoration: BoxDecoration(
//                                 shape: BoxShape.circle,
//                                 color: primaryColor.withOpacity(.9),
//                               ),
//                               padding: EdgeInsets.all(8.0),
//                               child: Icon(
//                                 Icons.edit,
//                                 color: Colors.white,
//                                 size: 20.r,
//                               ),
//                             ),
//                           ),
//                         ),
//                       ],
//                     )),
//                 SizedBox(
//                   height: 24.h,
//                 ),
//                 Row(
//                   children: [
//                     Flexible(
//                         child: CustomTextForm(
//                             controller: profileController.firstNameController,
//                             labelText: 'First Name',
//                             hintText: 'Your First Name',
//                             iconWidget: const Icon(Icons.person_2_outlined,
//                                 size: 22, color: textIconColor),
//                             keyboardType: TextInputType.text,
//                             validator: (val) {
//                               final validator = Validator(
//                                   validators: [const RequiredValidator()]);
//                               return validator.validate(
//                                 label: 'First Name',
//                                 value: val,
//                               );
//                             })),
//                     SizedBox(
//                       width: 12.w,
//                     ),
//                     Flexible(
//                         child: CustomTextForm(
//                             controller: profileController.lastNameController,
//                             labelText: 'Last Name',
//                             hintText: 'Your Last Name',
//                             iconWidget: const Icon(Icons.person_2_outlined,
//                                 size: 22, color: textIconColor),
//                             keyboardType: TextInputType.text,
//                             validator: (val) {
//                               final validator = Validator(
//                                   validators: [const RequiredValidator()]);
//                               return validator.validate(
//                                 label: 'Last Name',
//                                 value: val,
//                               );
//                             }))
//                   ],
//                 ),
//                 CustomTextForm(
//                     controller: profileController.phoneNumberController,
//                     labelText: 'Phone Number',
//                     hintText: '98********',
//                     keyboardType: TextInputType.number,
//                     enabled: false,
//                     iconWidget: const Icon(Icons.phone_outlined,
//                         size: 22, color: textIconColor),
//                     validator: (val) {
//                       final validator = Validator(validators: [
//                         const RequiredValidator(),
//                         const NumberValidator(),
//                         const MinLengthValidator(length: 10),
//                         const MaxLengthValidator(length: 10)
//                       ]);
//                       return validator.validate(
//                         label: 'Phone Number',
//                         value: val,
//                       );
//                     }),
//                 CustomTextForm(
//                     controller: profileController.emailController,
//                     labelText: 'Email',
//                     hintText: 'example@gmail.com',
//                     keyboardType: TextInputType.emailAddress,
//                     iconWidget: const Icon(Icons.email_outlined,
//                         size: 22, color: textIconColor),
//                     validator: (val) {
//                       final validator = Validator(validators: [
//                         const RequiredValidator(),
//                         const EmailValidator()
//                       ]);
//                       return validator.validate(
//                         label: 'Email',
//                         value: val,
//                       );
//                     }),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 CustomButton(
//                     isloaidng: false,
//                     onPressed: () async {
//                       profileController.editUserData();
//                     },
//                     text: 'Save Changes'),
//               ],
//             ),
//           )),
//     );
//   }
// }
