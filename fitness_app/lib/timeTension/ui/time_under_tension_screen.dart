import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class TimeUnderTensionScreen extends StatelessWidget {
  const TimeUnderTensionScreen({super.key});

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
                  color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 4),
            const Text(
              "Completed: October 25th, 2023",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            SizedBox(height: 16.h),

            // Suggested Time under tension Card
            _buildSuggestedCard(),

            SizedBox(height: 20.h),

            // Overall Accuracy
            const Text(
              "Overall Accuracy:",
              style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 4.h),
            const Text(
              "78%",
              style: TextStyle(
                  color: Colors.orange,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),

            SizedBox(height: 16.h),

            // Exercises List
            const _ExerciseCard(title: "Bench", target: "00:0:0", average: "00:0:0"),
            const _ExerciseCard(title: "Squats", target: "00:0:0", average: "00:0:0"),
            const _ExerciseCard(title: "Lat Press", target: "00:0:0", average: "00:0:0"),
            const _ExerciseCard(title: "Deadlift", target: "00:0:0", average: "00:0:0"),
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
          Container(
            padding: EdgeInsets.all(12.w),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.orange.withOpacity(0.3), Colors.transparent],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "Beginner",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
                Text(
                  "0:0:0",
                  style: TextStyle(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
              ],
            ),
          ),
          SizedBox(height: 10.h),
          _buildTimeRow("Body building", "0:0:0"),
          _buildTimeRow("Explosives", "0:0:0"),
          _buildTimeRow("Sustained", "0:0:0"),
          _buildTimeRow("Powerlifting", "0:0:0"),
        ],
      ),
    );
  }

  Widget _buildTimeRow(String label, String time) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Colors.grey)),
          Text(time, style: const TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

// Exercise Time Row Card
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
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                ),
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
