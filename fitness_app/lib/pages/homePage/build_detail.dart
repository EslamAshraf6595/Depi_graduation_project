import 'package:fitness_app/utils/app_color.dart';
import 'package:fitness_app/utils/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget BuildDetail(
  String label,
  String value,
) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label,
          style: AppTextStyle.meduim16grey.copyWith(
            fontSize: 11.sp,
            color: AppColors.grey,
          )),
      SizedBox(height: 2.h),
      Text(value,
          style: AppTextStyle.bold16white
              .copyWith(fontSize: 14.sp, color: AppColors.grey)),
    ],
  );
}
