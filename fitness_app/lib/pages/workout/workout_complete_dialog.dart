import 'package:flutter/material.dart';

class WorkoutCompleteDialog extends StatelessWidget {
  final VoidCallback onSeeSummary;
  const WorkoutCompleteDialog({super.key, required this.onSeeSummary});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xFF27272A),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 82,
              height: 82,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                gradient: LinearGradient(
                  colors: [Color(0xFFFFC69E), Color(0xFFFF8A01)],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: const Icon(Icons.star, color: Colors.white, size: 40),
            ),
            const SizedBox(height: 16),
            const Text(
              "Workout Complete",
              style: TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            const Text(
              "Streak: 10 days",
              style: TextStyle(color: Color(0xFFFFA05C), fontSize: 16),
            ),
            const SizedBox(height: 24),
            // This is still hardcoded from the design
            const _StatRow(label: "Exercise Completed:", value: "6"),
            const _StatRow(label: "Duration:", value: "45 minutes"),
            const _StatRow(label: "Calories burned:", value: "356 kcal"),
            const _StatRow(label: "Weight lifted:", value: "1000 lbs"),
            const _StatRow(label: "TUT accuracy", value: "68%"),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 40,
              child: ElevatedButton(
                onPressed: onSeeSummary,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFA05C),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                ),
                child: const Text(
                  "See full Summary",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _StatRow extends StatelessWidget {
  final String label;
  final String value;
  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: Color(0xFFA1A1AA), fontSize: 14)),
          Text(value, style: const TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}