// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CustomForm extends StatelessWidget {
  ValueNotifier<bool> activeBorder = ValueNotifier<bool>(true);
  final TextEditingController? controller;
  final void Function(String text)? onChanged;
  final String? Function(String? text)? validator;
  final String? hintText;
  final Widget? suffixIcon;
  final String label;
  bool? obscurePassword;

  CustomForm({
    super.key,
    this.controller,
    this.onChanged,
    this.validator,
    this.hintText,
    this.suffixIcon,
    this.obscurePassword,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: 8.h),
          child: Row(
            children: [
              Text(
                label,
                style: TextStyle(
                  color: const Color.fromRGBO(241, 152, 69, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 14.h,
                  fontStyle: FontStyle.normal,
                ),
              ),
              Text(
                ' *',
                style: TextStyle(
                  color: const Color.fromRGBO(241, 152, 69, 1),
                  fontWeight: FontWeight.w400,
                  fontSize: 14.h,
                  fontStyle: FontStyle.normal,
                ),
              ),
            ],
          ),
        ),
        TextFormField(
          keyboardType: TextInputType.text,
          obscureText: obscurePassword ?? false,
          controller: controller,
          validator: validator,
          onChanged: onChanged,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: hintText,
            contentPadding: EdgeInsets.symmetric(horizontal: 15.h),
            suffixIcon: suffixIcon,
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                width: 1.w,
                color: const Color.fromRGBO(241, 152, 69, 1),
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                width: 1,
                color: Colors.redAccent,
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                width: 1.w,
                color: Colors.redAccent,
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1.w,
                color: const Color.fromRGBO(37, 41, 84, 0.15),
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            labelStyle: TextStyle(
              fontSize: 16.h,
              fontWeight: FontWeight.w400,
              color: Colors.black,
            ),
          ),
          style: const TextStyle(
            color: const Color.fromRGBO(37, 41, 84, 1),
          ),
        ),
      ],
    );
  }
}
