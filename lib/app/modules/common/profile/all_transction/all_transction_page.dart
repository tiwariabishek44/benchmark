import 'package:benchmark/app/config/color.dart';
import 'package:benchmark/app/config/constants.dart';
import 'package:benchmark/app/modules/common/profile/change_password/change_password_page.dart';
import 'package:benchmark/app/modules/common/profile/edit_profile.dart/edit_profile_page.dart';
import 'package:benchmark/app/widgets/custom_app_bar.dart';
import 'package:benchmark/app/widgets/pop_up_logout.dart';
import 'package:benchmark/app/widgets/profile_tile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllTransctionPage extends StatelessWidget {
  const AllTransctionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: CustomAppBar(title: 'Transction History'),
      body: const Column(
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Column(children: [
                  Text(
                    "Record not Found!",
                    style: TextStyle(fontSize: 15),
                  )
                ]),
              ),
            ),
          )
        ],
      ),
    );
  }
}
