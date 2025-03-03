import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoadingButton extends StatelessWidget {
  final bool? isLarge;
  final Color? buttonColor;

  const LoadingButton({
    super.key,
    this.isLarge = false,
    this.buttonColor,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: null,
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(
            buttonColor ?? const Color.fromRGBO(241, 152, 69, 1),
          ),
          fixedSize: MaterialStateProperty.all<Size>(
            isLarge == true ? Size(double.maxFinite, 40.h) : Size(150.w, 40.h),
          ),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.r),
            ),
          ),
        ),
        child: const CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ));
  }
}
