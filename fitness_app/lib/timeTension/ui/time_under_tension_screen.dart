import 'package:fitness_app/provider/workout_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class TimeUnderTensionScreen extends StatelessWidget {
  const TimeUnderTensionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final workoutProvider = Provider.of<WorkoutProvider>(context);

    double overallAccuracy = workoutProvider.calculateOverallAccuracy() * 100;

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
          "Time under Tension (TuT)",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Bench exercise",
              style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
            ),
            const SizedBox(height: 4),
            Text(
              "Completed: ${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}",
              style: const TextStyle(color: Colors.grey, fontSize: 13),
            ),
            SizedBox(height: 16.h),
            _buildSuggestedCard(),
            SizedBox(height: 20.h),
            Text(
              "Overall Accuracy: ${overallAccuracy.toStringAsFixed(1)}%",
              style: const TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            SizedBox(height: 16.h),
            ...workoutProvider.completedExercises.map((ex) => _ExerciseCard(
                  title: ex.title ?? "",
                  target: "${ex.maxReps} reps",
                  average: "${(ex.formAccuracy * 100).toStringAsFixed(1)}%",
                )),
          ],
        ),
      ),
    );
  }

  Widget _buildSuggestedCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: const Color(0xFF2C2C2E),
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: Colors.orange.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Suggested Time under tension",
            style: TextStyle(color: Colors.grey, fontSize: 13),
          ),
          SizedBox(height: 10.h),
        ],
      ),
    );
  }
}

class _ExerciseCard extends StatelessWidget {
  final String title;
  final String target;
  final String average;

  const _ExerciseCard({
    required this.title,
    required this.target,
    required this.average,
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16)),
                SizedBox(height: 6.h),
                Text("Target: $target",
                    style: const TextStyle(color: Colors.grey, fontSize: 13)),
                Text("Average: $average",
                    style: const TextStyle(color: Colors.grey, fontSize: 13)),
              ],
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.edit, color: Colors.orange),
          ),
        ],
      ),
    );
  }
}
