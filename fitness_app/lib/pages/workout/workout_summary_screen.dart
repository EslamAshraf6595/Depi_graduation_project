import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WorkoutSummaryScreen extends StatelessWidget {
  final String title;
  final int reps;
  final int sets;
  final int durationSeconds;
  final VoidCallback onBack;
  final VoidCallback onSave;

  const WorkoutSummaryScreen({
    super.key,
    required this.title,
    required this.reps,
    required this.sets,
    required this.durationSeconds,
    required this.onBack,
    required this.onSave,
  });

  @override
  Widget build(BuildContext context) {
    final minutes = durationSeconds ~/ 60;
    final seconds = durationSeconds % 60;
    return Scaffold(
      appBar: AppBar(
        title: const Text("Workout Summary"),
        backgroundColor: const Color(0xFF1F1F1F),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      backgroundColor: const Color(0xFF121212),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 40.h),
            Text(title, style: TextStyle(color: Colors.white, fontSize: 28.sp)),
            SizedBox(height: 24.h),
            Text("Reps: $reps", style: TextStyle(color: Colors.white, fontSize: 22.sp)),
            Text("Sets: $sets", style: TextStyle(color: Colors.white, fontSize: 22.sp)),
            Text("Duration: $minutes min $seconds sec",
                style: TextStyle(color: Colors.white, fontSize: 22.sp)),
            SizedBox(height: 40.h),
            ElevatedButton(
              onPressed: onSave,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFFFA05C),
                minimumSize: Size(double.infinity, 50.h),
              ),
              child: const Text("Save Progress"),
            ),
          ],
        ),
      ),
    );
  }
}
