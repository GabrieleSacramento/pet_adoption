import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String appBarTitle;
  final bool isBackButtonVisible;
  final Color? backgroundColor;
  final Color? appBarTitleColor;
  final Color? appBarIconColor;
  final Function()? onBackButtonPressed;
  const CustomAppBar({
    super.key,
    required this.appBarTitle,
    required this.isBackButtonVisible,
    this.backgroundColor,
    this.appBarTitleColor,
    this.appBarIconColor,
    this.onBackButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backgroundColor ?? const Color.fromRGBO(241, 152, 69, 1),
      leadingWidth: 32.h,
      leading: Padding(
        padding: EdgeInsets.only(left: 16.w),
        child: GestureDetector(
          onTap: onBackButtonPressed,
          child: Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Icon(
              isBackButtonVisible ? Icons.arrow_back_outlined : null,
              color: appBarIconColor ?? const Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
        ),
      ),
      title: Padding(
        padding: EdgeInsets.only(top: 16.h),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            appBarTitle,
            style: TextStyle(
              fontSize: 16.h,
              color: appBarTitleColor ?? const Color.fromRGBO(255, 255, 255, 1),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(60.h);
}
