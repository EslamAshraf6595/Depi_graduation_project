import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GoalsScreen extends StatelessWidget {
  const GoalsScreen({super.key});

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
          "Goals",
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
              "List of all goals created.",
              style: TextStyle(color: Colors.grey, fontSize: 13),
            ),
            SizedBox(height: 20.h),

            // Add Goal Button
            _buildAddGoalButton(context),

            SizedBox(height: 20.h),

            // Goals List
            Expanded(
              child: ListView(
                children: const [
                  _GoalCard(
                    title: "Lose 5 kg",
                    description: "Target weight loss in 2 months",
                    progress: 0.65,
                    date: "Due: Dec 10, 2025",
                  ),
                  _GoalCard(
                    title: "Run 10 km",
                    description: "Weekly running distance target",
                    progress: 0.4,
                    date: "Due: Nov 20, 2025",
                  ),
                  _GoalCard(
                    title: "Bench 100 kg",
                    description: "Increase bench press max",
                    progress: 0.8,
                    date: "Due: Jan 5, 2026",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAddGoalButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // TODO: Navigate to "Add Goal" page
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 14.h),
        decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(12.r),
          boxShadow: [
            BoxShadow(
              color: Colors.orange.withOpacity(0.4),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        alignment: Alignment.center,
        child: const Text(
          "+ Add New Goal",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
    );
  }
}

// =======================
// GOAL CARD WIDGET
// =======================
class _GoalCard extends StatelessWidget {
  final String title;
  final String description;
  final double progress;
  final String date;

  const _GoalCard({
    required this.title,
    required this.description,
    required this.progress,
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
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title and edit icon
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16),
              ),
              IconButton(
                icon: const Icon(Icons.edit, color: Colors.orange),
                onPressed: () {},
              ),
            ],
          ),
          SizedBox(height: 4.h),

          // Description
          Text(
            description,
            style: const TextStyle(color: Colors.grey, fontSize: 13),
          ),
          SizedBox(height: 8.h),

          // Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(12.r),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey.shade800,
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
              minHeight: 8.h,
            ),
          ),
          SizedBox(height: 8.h),

          // Progress Info
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${(progress * 100).toInt()}% completed",
                style: const TextStyle(color: Colors.orange, fontSize: 12),
              ),
              Text(
                date,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
