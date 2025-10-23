import 'package:fitness_app/utils/app_color.dart';
import 'package:fitness_app/utils/app_text_style.dart';
import 'package:fitness_app/pages/homePage/build_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget BuildWorkoutCard({
  required String title,
  required String workoutName,
  required String duration,
  required String reps,
  required String sets,
  required String exercises,
  required String buttonText,
  required Color buttonColor,
}) {
  return Container(
    width: 343.w,
    height: 123.h,
    padding: EdgeInsets.all(12.w),
    decoration: BoxDecoration(
      color: AppColors.darkColor,
      borderRadius: BorderRadius.circular(16.r),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title,
            style: AppTextStyle.meduim16Yellow.copyWith(fontSize: 14.sp)),
        SizedBox(height: 8.h),
        Text(
          workoutName,
          style: AppTextStyle.bold20white,
        ),
        SizedBox(height: 12.h),
        Expanded(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              BuildDetail(
                "Duration",
                duration,
              ),
              BuildDetail("Reps", reps),
              BuildDetail("Sets", sets),
              BuildDetail("Exercise", exercises),
              Container(
                width: 90.w,
                height: 30.h,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
                decoration: BoxDecoration(
                  color: buttonColor,
                  borderRadius: BorderRadius.circular(8.r),
                ),
                child: Text(
                  buttonText,
                  textAlign: TextAlign.center,
                  style: AppTextStyle.meduim14white.copyWith(
                    fontSize: 10.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
