import 'package:flutter/material.dart';

class ExercisesScreen extends StatelessWidget {
  const ExercisesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Exercises",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _exerciseCard("Push ups", "30 minutes", "115", "15", "5"),
            const SizedBox(height: 16),
            _exerciseCard("Pull ups", "20 minutes", "90", "10", "4"),
            const SizedBox(height: 16),
            _exerciseCard("Squats", "15 minutes", "60", "12", "3"),
          ],
        ),
      ),
    );
  }

  // 🔸 نفس تصميم الكارت من GoalsScreen
  Widget _exerciseCard(
      String title, String duration, String reps, String sets, String exercise) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: const LinearGradient(
          colors: [Color(0xFF0E0E0E), Color(0xFF000000)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          gradient: RadialGradient(
            colors: [
              const Color(0xFFEA8945).withOpacity(0.3),
              const Color(0xFF0E0E0E),
            ],
            center: Alignment.topRight,
            radius: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Title + edit icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(title,
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold)),
                const Icon(Icons.edit, color: Colors.orange, size: 20),
              ],
            ),
            const SizedBox(height: 12),

            // Info row
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoItem("Duration:", duration),
                _infoItem("Reps:", reps),
                _infoItem("Sets:", sets),
                _infoItem("Exercise:", exercise),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white70, fontSize: 14)),
        const SizedBox(height: 4),
        Text(value,
            style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 14)),
      ],
    );
  }
}
