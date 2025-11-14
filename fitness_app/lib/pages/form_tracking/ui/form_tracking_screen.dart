import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

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
          "Form tracking",
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
              "Track your form and technique.",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            SizedBox(height: 20.h),

            // Summary card
            _buildSummaryCard(),

            SizedBox(height: 20.h),

            // Exercise list
            Expanded(
              child: ListView(
                children: const [
                  _FormCard(
                    title: "Bench Press",
                    accuracy: 0.85,
                    feedback: "Great control, minor elbow flare.",
                    date: "Oct 10, 2025",
                  ),
                  _FormCard(
                    title: "Squats",
                    accuracy: 0.75,
                    feedback: "Keep back straight and depth consistent.",
                    date: "Oct 8, 2025",
                  ),
                  _FormCard(
                    title: "Deadlift",
                    accuracy: 0.9,
                    feedback: "Strong pull, excellent hip hinge.",
                    date: "Oct 5, 2025",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryCard() {
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
                  value: 0.83,
                  strokeWidth: 8,
                  backgroundColor: Colors.grey.shade800,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
              const Text(
                "83%",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 14),
              ),
            ],
          ),
          SizedBox(width: 20.w),

          // Summary info
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Overall Form Accuracy",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 6),
                Text(
                  "Based on your last 5 recorded workouts",
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
// FORM TRACKING CARD WIDGET
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

          // Edit icon
          IconButton(
            icon: const Icon(Icons.edit, color: Colors.orange),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
