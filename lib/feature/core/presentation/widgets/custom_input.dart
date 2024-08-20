import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:myresto/utils/styles.dart';

class CustomInput extends StatelessWidget {
  // final String label;
  final String hintText;
  final TextEditingController? controller;
  final bool isObscure;
  final VoidCallback? onTap;
  final int? maxLines;
  final TextInputType keyboardType;
  final IconData? prefixIcon;
  final Decoration? decoration;

  const CustomInput({
    super.key,
    required this.hintText,
    this.controller,
    this.isObscure = false,
    this.onTap,
    // required this.label,
    this.maxLines = 1,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.decoration,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Text(
          //   label,
          //   style: blackTextStyle,
          // ),
          Container(
            margin: EdgeInsets.only(top: 4.h),
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: decoration ??
                BoxDecoration(
                  border: Border.all(
                    color: darkGreyColor,
                  ),
                  borderRadius: BorderRadius.circular(16.r),
                ),
            child: Row(
              children: [
                if (prefixIcon != null) _buildPrefix(),
                Expanded(child: _buildTextFormField()),
                if (onTap != null) _buildObscureCanceler(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrefix() {
    return Container(
      margin: EdgeInsets.only(right: 12.w),
      child: Icon(
        prefixIcon,
        color: darkGreyColor,
      ),
    );
  }

  Widget _buildTextFormField() {
    return TextFormField(
      controller: controller,
      obscureText: isObscure,
      style: blackTextStyle.copyWith(
        fontWeight: medium,
      ),
      maxLines: maxLines,
      decoration: InputDecoration.collapsed(
        hintText: hintText,
      ),
      keyboardType: keyboardType,
      inputFormatters: const [],
    );
  }

  Widget _buildObscureCanceler() {
    return Container(
      margin: EdgeInsets.only(left: 12.w),
      child: InkWell(
        onTap: onTap,
        child: Icon(
          isObscure
              ? Icons.visibility_off_rounded
              : Icons.remove_red_eye_rounded,
          color: const Color(0xff8A8A8A),
          size: 24.w,
        ),
      ),
    );
  }
}
