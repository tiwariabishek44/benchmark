import 'package:benchmark/app/modules/common/mcq/all_mcq_page.dart';
import 'package:benchmark/app/modules/common/recent_viewes/recent_viewes.dart';
import 'package:benchmark/app/widgets/subject_List.dart';
import 'package:flutter/material.dart';

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
        return RecentViewsScreen();
    }
  }
}
