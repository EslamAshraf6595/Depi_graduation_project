import 'package:fitness_app/roots/app_roots.dart';
import 'package:fitness_app/utils/app_assets.dart';
import 'package:fitness_app/utils/app_color.dart';
import 'package:fitness_app/utils/app_text_style.dart';
import 'package:fitness_app/pages/homePage/build_workout_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomePage extends StatelessWidget {
  static double progress = 70;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                margin: EdgeInsets.symmetric(vertical: 16.h),
                width: double.infinity,
                height: 112.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.r),
                  color: AppColors.darkColor,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              ImageIcon(
                                AssetImage(AppAssets.logo),
                                color: AppColors.white,
                                size: 32.sp,
                              ),
                              SizedBox(width: 8.w),
                              Text(
                                "Hello",
                                style: AppTextStyle.meduim16grey,
                              ),
                            ],
                          ),
                          SizedBox(height: 4.h),
                          Text(
                            "Welcome Back,",
                            style: AppTextStyle.bold20white,
                          ),
                          Text(
                            "Nick!",
                            style: AppTextStyle.bold20white,
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.w,vertical: 4.h),
                            alignment: Alignment.center,
                            width: 85.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: AppColors.primeYellow,
                            ),
                            child: Text(
                              "Get Premium",
                              style: TextStyle(
                                color: AppColors.white,
                              ),
                            ),
                          )
                        ]),
                    Image.asset(
                      AppAssets.treaner,
                      height: 87.h,
                      width: 74.w,
                    )
                  ],
                ),
              ),

              /// Progress
              Row(
                children: [
                  Text(
                    "Overall progress:",
                    style: AppTextStyle.meduim16grey,
                  ),
                  const Spacer(),
                  Text(
                    "${progress.toInt()}%",
                    style: AppTextStyle.meduim16grey,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              LinearProgressIndicator(
                value: progress / 100,
                backgroundColor: AppColors.grey,
                valueColor: AlwaysStoppedAnimation(AppColors.primeYellow),
                minHeight: 8.h,
                borderRadius: BorderRadius.circular(12.r),
              ),
              SizedBox(height: 24.h),

              /// Workout Cards
              BuildWorkoutCard(
                title: "Your next workout:",
                workoutName: "Push ups",
                duration: "30 minutes",
                reps: "115",
                sets: "15",
                exercises: "5",
                buttonText: "Start workout",
                buttonColor: AppColors.primeYellow,
              ),
              SizedBox(height: 16.h),
              BuildWorkoutCard(
                title: "Your last workout:",
                workoutName: "Pull ups",
                duration: "30 minutes",
                reps: "115",
                sets: "15",
                exercises: "5",
                buttonText: "Redo workout",
                buttonColor: AppColors.primeYellow,
              ),
              SizedBox(height: 20.h),

              /// Create new plan button
              Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 16.h),
                decoration: BoxDecoration(
                  color: AppColors.primeOrange,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Center(
                  child: Text(
                    "+ Create new plan",
                    style: AppTextStyle.bold16white,
                  ),
                ),
              ),

              SizedBox(height: 12.h),

              /// See metrics button
              GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, AppRoots.metricsScreen);
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.primeOrange, width: 1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset(AppAssets.metrics,
                            height: 20.h, width: 20.w),
                        SizedBox(width: 8.w),
                        Text(
                          "See metrics",
                          style: AppTextStyle.bold16white,
                        ),
                      ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
