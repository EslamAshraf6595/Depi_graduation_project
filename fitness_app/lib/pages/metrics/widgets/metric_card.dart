import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app/utils/app_color.dart';
import 'package:fitness_app/utils/app_text_style.dart';

class MetricCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String iconPath;
  // final bool comingSoon;
  final VoidCallback? onTap; // ✅ added

  const MetricCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.iconPath,
    // this.comingSoon = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 164.w,
        height: 141.h,
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: AppColors.darkColor,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// Top row with icon + "coming soon" badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Image.asset(
                  iconPath,
                  height: 48.h,
                  width: 48.w,
                ),
                // if (comingSoon)
                //   Container(
                //     padding:
                //         EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                //     decoration: BoxDecoration(
                //       color: AppColors.primeOrange,
                //       borderRadius: BorderRadius.circular(6.r),
                //     ),
                //     child: Text(
                //       "coming soon",
                //       style: AppTextStyle.meduim14white.copyWith(fontSize: 10.sp),
                //     ),
                //   ),
              ],
            ),
            SizedBox(height: 4.h),

            /// Title
            Text(
              title,
              style: AppTextStyle.bold16white,
            ),
            SizedBox(height: 4.h),

            /// Subtitle
            Text(
              subtitle,
              style: AppTextStyle.meduim12grey.copyWith(
                fontSize: 10.sp,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
