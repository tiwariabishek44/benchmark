// TO DISPLAY INFORMATION WHEN THER IS NOT DATA

import 'package:flutter/material.dart';

class NoDataWidget extends StatelessWidget {
  final String message;
  final IconData iconData;

  const NoDataWidget({Key? key, required this.message, required this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            iconData,
            size: 60,
            color: Color.fromARGB(255, 104, 102, 102),
          ),
          SizedBox(height: 20),
          Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromARGB(255, 79, 78, 78),
            ),
          ),
        ],
      ),
    );
  }
}
