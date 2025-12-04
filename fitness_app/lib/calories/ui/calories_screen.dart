import 'package:fitness_app/models/exercise_model.dart';
import 'package:fitness_app/provider/workout_provider.dart';
import 'package:fitness_app/utils/widgets/custtom_add_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class CaloriesScreen extends StatefulWidget {
  const CaloriesScreen({super.key});

  @override
  State<CaloriesScreen> createState() => _CaloriesScreenState();
}

class _CaloriesScreenState extends State<CaloriesScreen> {
  final TextEditingController caloriesController = TextEditingController();
  static const int maxCalories = 3000;

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
          "Calories",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
        child: Column(
          children: [
            Consumer<WorkoutProvider>(
              builder: (context, workoutProvider, _) {
                int totalCalories = workoutProvider.exercises
                    .fold(0, (sum, ex) => sum + ex.calories);
                totalCalories =
                    totalCalories > maxCalories ? maxCalories : totalCalories;
                return _buildCaloriesIndicator(totalCalories);
              },
            ),
            SizedBox(height: 16.h),
            const Text(
              "🔥 Total Calories burned",
              style:
                  TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
            ),
            const Text(
              "These numbers are based on distance and weight",
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
            SizedBox(height: 20.h),
            Custtom_add_feild(
              value: "Add Calories",
              controller: caloriesController,
              onAdd: () {
                if (caloriesController.text.isNotEmpty) {
                  int cal = int.tryParse(caloriesController.text) ?? 0;
                  if (cal > 0) {
                    Provider.of<WorkoutProvider>(context, listen: false)
                        .addExercise(
                      ExerciseModel(
                        title: "Custom Entry",
                        calories: cal,
                        reps: 0,
                        maxReps: 0,
                        rest: 0,
                        weight: 0,
                        maxSets: 0,
                        doneReps: 0,
                        formAccuracy: 0.0,
                        completedDateStr: "",
                      ),
                    );
                    caloriesController.clear();
                  }
                }
              },
            ),
            SizedBox(height: 30.h),
            Expanded(
              child: Consumer<WorkoutProvider>(
                builder: (context, workoutProvider, _) {
                  final exercises = workoutProvider.exercises;

                  if (exercises.isEmpty) {
                    return const Center(
                      child: Text(
                        "No exercises added yet",
                        style: TextStyle(color: Colors.grey),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: exercises.length,
                    itemBuilder: (context, index) {
                      final ex = exercises[index];
                      return _WorkoutCard(
                        day: "Today",
                        exercise: ex.title!,
                        calories: ex.calories,
                        reps: "${ex.reps}/${ex.maxReps}",
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

  Widget _buildCaloriesIndicator(int totalCalories) {
    double progress = totalCalories / maxCalories;
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: totalCalories.toDouble()),
      duration: const Duration(seconds: 1),
      builder: (context, value, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 150.w,
              height: 150.w,
              child: CircularProgressIndicator(
                value: progress,
                strokeWidth: 12,
                backgroundColor: Colors.grey.shade800,
                valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  value.toInt().toString(),
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const Text(
                  "cal",
                  style: TextStyle(color: Colors.grey),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final String day;
  final String exercise;
  final int calories;
  final String reps;

  const _WorkoutCard({
    required this.day,
    required this.exercise,
    required this.calories,
    required this.reps,
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
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 45.w,
                height: 45.w,
                child: CircularProgressIndicator(
                  value: 0.8,
                  strokeWidth: 6,
                  backgroundColor: Colors.grey.shade800,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Colors.orange),
                ),
              ),
              Text(
                "$calories",
                style: const TextStyle(color: Colors.white, fontSize: 10),
              ),
            ],
          ),
          SizedBox(width: 16.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                      color: Colors.orange, fontWeight: FontWeight.w600),
                ),
                Text(
                  exercise,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                "Reps completed:",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              Text(
                reps,
                style: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
              ),
            ],
          )
        ],
      ),
    );
  }
}
