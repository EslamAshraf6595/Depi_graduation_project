import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fitness_app/utils/app_text_style.dart';

Widget BuildWorkoutCard({
  required String title,
  required String workoutName,
  required int duration,
  required int reps,
  required int sets,
  required int exercises,
  required String buttonText,
  required Color buttonColor,
  required BuildContext context,
  VoidCallback? onPressed, // ✅ Correct type
}) {
  return Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: const Color(0xFF121212),
      borderRadius: BorderRadius.circular(12),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(color: Colors.orange)),
        const SizedBox(height: 8),
        Text(workoutName,
            style: const TextStyle(color: Colors.white, fontSize: 18)),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _detail("Duration", "$duration min"),
            _detail("Reps", reps.toString()),
            _detail("Sets", sets.toString()),
            _detail("Ex", exercises.toString()),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: buttonColor),
              onPressed: onPressed, // ✅ Call the callback properly
              child: Text(buttonText),
            )
          ],
        )
      ],
    ),
  );
}

Widget _detail(String label, String value) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(label, style: const TextStyle(color: Colors.white70, fontSize: 12)),
      Text(value,
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold)),
    ],
  );
}
