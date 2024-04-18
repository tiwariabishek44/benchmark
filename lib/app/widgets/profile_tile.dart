import 'package:benchmark/app/config/app_style.dart';
import 'package:benchmark/app/config/color.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProfileTile extends StatelessWidget {
  final String title;
  final Icon leadingIcon;
  final VoidCallback? onTap;

  const ProfileTile({
    Key? key,
    required this.title,
    required this.leadingIcon,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        leading: leadingIcon,
        tileColor: AppColors.backgroundColor,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        title: Text(
          title,
          style: AppStyles.listTileTitle,
        ),
        trailing: Icon(
          Icons.chevron_right,
          size: 22.sp,
          color: AppColors.iconColors,
        ),
        onTap: onTap,
      ),
    );
  }
}
