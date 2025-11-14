import 'package:fitness_app/utils/widgets/custtom_add_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CaloriesScreen extends StatelessWidget {
  const CaloriesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Calories",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: [
            // Total Calories Circular Indicator
            _buildCaloriesIndicator(),

            SizedBox(height: 16.h),

            const Text(
              "🔥 Total Calories burned",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            const Text(
              "These numbers are based on distance and weight",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),

            SizedBox(height: 20.h),

            // Add Calories Input
            Custtom_add_feild(
              value: "Add Calories",
            ),

            SizedBox(height: 30.h),

            // Week Data
            Expanded(
              child: ListView(
                children: const [
                  _WorkoutCard(
                    day: "Today",
                    exercise: "Push ups",
                    calories: 150,
                    reps: "10/10",
                  ),
                  _WorkoutCard(
                    day: "Tuesday",
                    exercise: "Squats",
                    calories: 85,
                    reps: "7/10",
                  ),
                  _WorkoutCard(
                    day: "Monday",
                    exercise: "Deadlift",
                    calories: 165,
                    reps: "10/20",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCaloriesIndicator() {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          width: 150.w,
          height: 150.w,
          child: CircularProgressIndicator(
            value: 0.75, // 75% progress for demo
            strokeWidth: 12,
            backgroundColor: Colors.grey.shade800,
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Text(
              "3,600",
              style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
            Text(
              "cal",
              style: TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }
}

// Workout Card Widget
class _WorkoutCard extends StatelessWidget {
  final String day;
  final String exercise;
  final int calories;
  final String reps;

  const _WorkoutCard({
    required this.day,
    required this.exercise,
    required this.calories,
    required this.reps,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.h),
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Row(
        children: [
          // Circular Calorie Indicator
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 45.w,
                height: 45.w,
                child: CircularProgressIndicator(
                  value: 0.8,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey.shade800,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
              Text(
                "$calories",
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.w600),
                ),
                Text(
                  exercise,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          // Reps info
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Reps completed:",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                reps,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
