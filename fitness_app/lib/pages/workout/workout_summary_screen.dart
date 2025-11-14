import 'package:fitness_app/pages/workout/workout_screen.dart';
import 'package:fitness_app/pages/workout/workout_summary_data.dart';
import 'package:flutter/material.dart';

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
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
      children: [
        const SizedBox(height: 24), // Space for real status bar
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back, color: Colors.white),
            ),
            const Text(
              "Workout summary",
              style: TextStyle(color: Color(0xFFA1A1AA), fontSize: 18),
            ),
            const SizedBox(width: 48), // Placeholder for alignment
          ],
        ),
        const SizedBox(height: 16),
        const Text(
          "Pushups",
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        const _SummaryProgressBar(progress: 0.7, label: "70%"), // Progress is hardcoded
        const SizedBox(height: 24),
        _SummaryStatRow(label: "Overall reps:", value: "${summaryData.totalReps} reps"),
        _SummaryStatRow(label: "Overall sets:", value: "${summaryData.totalSets} sets"),
        _SummaryStatRow(label: "Duration:", value: durationString),
        _SummaryStatRow(label: "Total calories count:", value: "${summaryData.totalCalories} kcal"),
        _SummaryStatRow(label: "TUT accuracy", value: "${summaryData.tutAccuracy}%"),
        const SizedBox(height: 32),
        const Text(
          "Exercises completed",
          style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        // This list is still hardcoded as per the design
        const _ExerciseSummaryCard(),
        const _ExerciseSummaryCard(),
        const _ExerciseSummaryCard(),
      ],
    );
  }
}

class _SummaryStatRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryStatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFFA1A1AA), fontSize: 16)),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

class _SummaryProgressBar extends StatelessWidget {
  final double progress;
  final String label;
  const _SummaryProgressBar({required this.progress, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Overall progress:", style: TextStyle(color: Color(0xFFD4D4D8), fontSize: 16)),
            Text(label, style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
          ],
        ),
        const SizedBox(height: 10),
        Stack(
          children: [
            Container(
              height: 15,
              decoration: BoxDecoration(
                color: const Color(0xFF434343),
                borderRadius: BorderRadius.circular(40),
              ),
            ),
            FractionallySizedBox(
              widthFactor: progress,
              child: Container(
                height: 15,
                decoration: BoxDecoration(
                  gradient: orangeGradient,
                  borderRadius: BorderRadius.circular(40),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _ExerciseSummaryCard extends StatelessWidget {
  const _ExerciseSummaryCard();
  // In a real app, this would take an 'exercise' object
  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF161512).withOpacity(0.8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      margin: const EdgeInsets.only(bottom: 8),
      child: Container(
        height: 86,
        padding: const EdgeInsets.all(16),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Push ups", style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                Spacer(),
                Row(
                  children: [
                    InfoItem(label: "Day:", value: "Monday"),
                    SizedBox(width: 8),
                    InfoItem(label: "Duration:", value: "115"),
                    SizedBox(width: 8),
                    InfoItem(label: "Exercise:", value: "5"),
                    SizedBox(width: 8),
                    InfoItem(label: "TUT:", value: "70%"),
                    SizedBox(width: 8),
                    InfoItem(label: "Calories:", value: "65 kcal"),
                  ],
                ),
              ],
            ),
            Icon(Icons.check_circle, color: Color(0xFFFFA05C), size: 20),
          ],
        ),
      ),
    );
  }
}