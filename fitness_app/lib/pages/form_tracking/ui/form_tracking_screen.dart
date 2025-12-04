import 'package:fitness_app/provider/exercise_provider.dart';
import 'package:fitness_app/provider/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class FormTrackingScreen extends StatelessWidget {
  const FormTrackingScreen({super.key});

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
          "Form Tracking",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Track your exercise form and technique.",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            SizedBox(height: 20.h),

            // SUMMARY CARD (Real-time)
            Consumer<WorkoutProvider>(
              builder: (context, workoutProvider, _) {
                double overallAccuracy =
                    workoutProvider.calculateOverallAccuracy();
                return _buildSummaryCard(overallAccuracy);
              },
            ),

            SizedBox(height: 20.h),

            // EXERCISE HISTORY LIST (Real-time)
            Expanded(
              child: Consumer2<WorkoutProvider, ExerciseProvider>(
                builder: (context, workoutProvider, exerciseProvider, _) {
                  final history = workoutProvider.completedExercises;

                  if (history.isEmpty) {
                    return const Center(
                      child: Text(
                        "No form data tracked yet.",
                        style: TextStyle(color: Colors.white70),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: history.length,
                    itemBuilder: (context, index) {
                      final ex = history[index];
                      return _FormCard(
                        title: ex.title ?? "",
                        accuracy: ex.formAccuracy,
                        feedback: ex.formFeedback.isEmpty
                            ? "Keep practicing!"
                            : ex.formFeedback,
                        date: ex.completedDateStr,
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =======================
  // SUMMARY CARD WIDGET
  // =======================
  Widget _buildSummaryCard(double accuracy) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.15),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        children: [
          // Circular accuracy indicator
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 70.w,
                height: 70.w,
                child: CircularProgressIndicator(
                  value: accuracy,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey.shade800,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
              Text(
                "${(accuracy * 100).toInt()}%",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ],
          ),
          SizedBox(width: 20.w),

          // Summary info
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Overall Form Accuracy",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  "Based on your completed exercises",
                  style: TextStyle(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

// ============================
// FORM HISTORY CARD
// ============================
class _FormCard extends StatelessWidget {
  final String title;
  final double accuracy;
  final String feedback;
  final String date;

  const _FormCard({
    required this.title,
    required this.accuracy,
    required this.feedback,
    required this.date,
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
          // Circular Accuracy Display
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 50.w,
                height: 50.w,
                child: CircularProgressIndicator(
                  value: accuracy,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey.shade800,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
              Text(
                "${(accuracy * 100).toInt()}%",
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12),
              ),
            ],
          ),
          SizedBox(width: 16.w),

          // Info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                SizedBox(height: 6.h),
                Text(
                  feedback,
                  style: const TextStyle(color: Colors.grey, fontSize: 13),
                ),
                SizedBox(height: 6.h),
                Text(
                  date,
                  style: const TextStyle(color: Colors.grey, fontSize: 12),
                ),
              ],
            ),
          ),

          // Edit icon (optional)
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.orange),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
