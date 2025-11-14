import 'package:fitness_app/pages/workout/workout_screen.dart';
import 'package:fitness_app/pages/workout/workout_summary_data.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutSummaryScreen extends StatelessWidget {
  final VoidCallback onBack;
  final WorkoutSummaryData summaryData;

  const WorkoutSummaryScreen({
    super.key,
    required this.onBack,
    required this.summaryData,
  });

  @override
  Widget build(BuildContext context) {
    final durationMinutes = summaryData.totalDurationSeconds ~/ 60;
    final durationSeconds = summaryData.totalDurationSeconds % 60;
    final durationString = "$durationMinutes min $durationSeconds sec";

    return ListView(
      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 100.h),
      children: [
        SizedBox(height: 24.h), // Space for real status bar

        // Header
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: onBack,
              icon: Icon(Icons.arrow_back, color: Colors.white, size: 22.sp),
            ),
            Text(
              "Workout summary",
              style: TextStyle(
                color: Color(0xFFA1A1AA),
                fontSize: 18.sp,
              ),
            ),
            SizedBox(width: 48.w),
          ],
        ),

        SizedBox(height: 16.h),

        Center(
          child: Text(
            "Pushups",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        SizedBox(height: 16.h),

        // Progress
        SummaryProgressBar(progress: 0.7, label: "70%"),

        SizedBox(height: 24.h),

        SummaryStatRow(
            label: "Overall reps:", value: "${summaryData.totalReps} reps"),
        SummaryStatRow(
            label: "Overall sets:", value: "${summaryData.totalSets} sets"),
        SummaryStatRow(label: "Duration:", value: durationString),
        SummaryStatRow(
            label: "Total calories count:",
            value: "${summaryData.totalCalories} kcal"),
        SummaryStatRow(
            label: "TUT accuracy", value: "${summaryData.tutAccuracy}%"),

        SizedBox(height: 32.h),

        Text(
          "Exercises completed",
          style: TextStyle(
            color: Colors.white,
            fontSize: 16.sp,
            fontWeight: FontWeight.bold,
          ),
        ),

        SizedBox(height: 12.h),

        ExerciseSummaryCard(),
        ExerciseSummaryCard(),
        ExerciseSummaryCard(),
      ],
    );
  }
}

class SummaryStatRow extends StatelessWidget {
  final String label;
  final String value;
  const SummaryStatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(color: Color(0xFFA1A1AA), fontSize: 16.sp),
          ),
          Text(
            value,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class SummaryProgressBar extends StatelessWidget {
  final double progress;
  final String label;
  const SummaryProgressBar({required this.progress, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Overall progress:",
              style: TextStyle(color: Color(0xFFD4D4D8), fontSize: 16.sp),
            ),
            Text(
              label,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold),
            ),
          ],
        ),
        SizedBox(height: 10.h),
        Stack(
          children: [
            Container(
              height: 15.h,
              decoration: BoxDecoration(
                color: Color(0xFF434343),
                borderRadius: BorderRadius.circular(40.r),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 15.h,
                decoration: BoxDecoration(
                  gradient: orangeGradient,
                  borderRadius: BorderRadius.circular(40.r),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ExerciseSummaryCard extends StatelessWidget {
  const ExerciseSummaryCard();

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color(0xFF161512).withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      margin: EdgeInsets.only(bottom: 8.h),
      child: Container(
        height: 105.h,
        width: double.infinity,
        padding: EdgeInsets.all(10.w),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Push ups",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Row(
                  children: [
                    InfoItem(label: "Day:", value: "Monday"),
                    SizedBox(width: 8.w),
                    InfoItem(label: "Duration:", value: "115"),
                    SizedBox(width: 8.w),
                    InfoItem(label: "Exercise:", value: "5"),
                    SizedBox(width: 8.w),
                    InfoItem(label: "TUT:", value: "70%"),
                    SizedBox(width: 8.w),
                    InfoItem(label: "Calories:", value: "65 kcal"),
                  ],
                ),
              ],
            ),
            Icon(Icons.check_circle, color: Color(0xFFFFA05C), size: 20.sp),
          ],
        ),
      ),
    );
  }
}
