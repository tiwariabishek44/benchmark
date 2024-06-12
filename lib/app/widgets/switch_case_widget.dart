// SWITCH CONDITION  FOR THE STREAM AND MCQS

import 'package:benchmark/app/modules/common/course/course_controller.dart';
import 'package:benchmark/app/modules/common/manual/mannual_subject_list.dart';
import 'package:benchmark/app/modules/common/mcq/all_mcq_page.dart';
import 'package:benchmark/app/widgets/subject_List.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SwitchCaseWidget extends StatelessWidget {
  final int selectedTopic;

  SwitchCaseWidget({required this.selectedTopic});

  @override
  Widget build(BuildContext context) {
    
    switch (selectedTopic) {
      case 0:
        return SubjectList();
      case 1:
        return AllMcqs();

      default:
        return MannualSubjectList();
    }
  }
}
