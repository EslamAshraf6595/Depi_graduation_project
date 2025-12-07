import 'package:fitness_app/provider/user_provider.dart';
import 'package:fitness_app/roots/app_roots.dart';
import 'package:fitness_app/utils/app_assets.dart';
import 'package:fitness_app/utils/app_color.dart';
import 'package:fitness_app/utils/app_text_style.dart';
import 'package:fitness_app/pages/homePage/build_workout_card.dart';
import 'package:fitness_app/pages/workOut/workout_page.dart';
import 'package:fitness_app/provider/exercise_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:fitness_app/models/exercise_model.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ExerciseProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    // Calculate overall progress based on done reps and sets of all exercises
    double progressValue = 0.0;
    if (provider.exercises.isNotEmpty) {
      double totalProgress = 0;
      for (var ex in provider.exercises) {
        final target = ex.maxReps * ex.maxSets;
        if (target > 0) {
          totalProgress +=
              ex.doneReps / target; // doneReps reflects actual work done
        }
      }
      progressValue =
          (totalProgress / provider.exercises.length).clamp(0.0, 1.0);
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // --- HEADER ---
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
                            "${userProvider.username!.split("@").first ?? ''}!",
                            style: AppTextStyle.bold20white,
                          ),
                          SizedBox(height: 8.h),
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 1.h),
                            alignment: Alignment.center,
                            width: 98.w,
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

              /// OVERALL PROGRESS
              Row(
                children: [
                  Text(
                    "Overall progress:",
                    style: AppTextStyle.meduim16grey,
                  ),
                  const Spacer(),
                  Text(
                    "${(progressValue * 100).toInt()}%",
                    style: AppTextStyle.meduim16grey,
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              LinearProgressIndicator(
                value: progressValue,
                backgroundColor: AppColors.grey,
                valueColor: AlwaysStoppedAnimation(AppColors.primeYellow),
                minHeight: 8.h,
                borderRadius: BorderRadius.circular(12.r),
              ),
              SizedBox(height: 24.h),

              /// --- DYNAMIC WORKOUT CARDS ---
              provider.exercises.isEmpty
                  ? Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 80.h),
                        child: Text(
                          "No workouts yet.\nAdd your first exercise!",
                          textAlign: TextAlign.center,
                          style: AppTextStyle.meduim16grey,
                        ),
                      ),
                    )
                  : Column(
                      children: provider.exercises.map((exercise) {
                        return Padding(
                          padding: EdgeInsets.only(bottom: 16.h),
                          child: BuildWorkoutCard(
                            title: "Your next workout:",
                            workoutName: exercise.title ?? "",
                            duration: int.parse(exercise.duration ?? "0"),
                            reps: exercise.maxReps,
                            sets: exercise.maxSets,
                            exercises: provider.exercises.length,
                            buttonText: "Start workout",
                            buttonColor: AppColors.primeYellow,
                            context: context,
                            onPressed: () async {
                              final finished = await Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) =>
                                      WorkoutPage(exercise: exercise),
                                ),
                              );
                              if (finished == true) {
                                setState(() {
                                  // Updates progress dynamically using doneReps
                                  provider.completeExercise(exercise);
                                });
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ),

              SizedBox(height: 20.h),

              /// Create new plan button
              GestureDetector(
                onTap: () => Navigator.pushNamed(context, AppRoots.createPlan),
                child: Container(
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
