import 'package:fitness_app/pages/goal/add_exercise_screen.dart';
import 'package:fitness_app/provider/exercise_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GoalScreen extends StatefulWidget {
  const GoalScreen({super.key});

  @override
  State<GoalScreen> createState() => _GoalScreenState();
}

class _GoalScreenState extends State<GoalScreen> {
  bool isPlansTabSelected = true;

  @override
  Widget build(BuildContext context) {
    final exercises = Provider.of<ExerciseProvider>(context).exercises;
    final progressPercent = Provider.of<ExerciseProvider>(context).overallProgress;

    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Goals",
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Overall progress: ${progressPercent.toStringAsFixed(0)}%",
              style: const TextStyle(color: Colors.white70),
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: (progressPercent / 100).clamp(0.0, 1.0),
                minHeight: 10,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF7F32)),
                backgroundColor: Colors.white24,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isPlansTabSelected = true),
                    child: _tabButton("Plans", isPlansTabSelected),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => isPlansTabSelected = false),
                    child: _tabButton("Exercises", !isPlansTabSelected),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            if (isPlansTabSelected)
              _plansTab(exercises)
            else
              _exercisesTab(exercises),
          ],
        ),
      ),
    );
  }

  Widget _tabButton(String text, bool isSelected) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        color: isSelected ? Colors.orange : Colors.black,
        borderRadius: BorderRadius.circular(6),
        border: isSelected ? null : Border.all(color: Colors.orange.withOpacity(0.5)),
        boxShadow: isSelected
            ? [BoxShadow(color: Colors.orange.withOpacity(0.4), blurRadius: 8, offset: const Offset(0, 3))]
            : [],
      ),
      child: Center(
        child: Text(
          text,
          style: TextStyle(
              color: isSelected ? Colors.white : Colors.white70,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _plansTab(List exercises) {
    return Expanded(
      child: Column(
        children: [
          GestureDetector(
            onTap: () async {
              final result = await Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const AddExerciseScreen()),
              );
              if (result != null && mounted) setState(() {});
            },
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                gradient: const LinearGradient(
                  colors: [Color(0xFFFFA84C), Color(0xFFFF6B2C)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(Icons.add, color: Colors.white, size: 22),
                  SizedBox(width: 8),
                  Text(
                    "Create new plan",
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: exercises.length,
              itemBuilder: (context, index) {
                final ex = exercises[index];
                return Column(
                  children: [
                    _exerciseCard(ex, index),
                    const SizedBox(height: 16),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _exercisesTab(List exercises) {
    return Expanded(
      child: ListView.builder(
        itemCount: exercises.length,
        itemBuilder: (context, index) {
          final ex = exercises[index];
          return Column(
            children: [
              _exerciseCard(ex, index),
              const SizedBox(height: 16),
            ],
          );
        },
      ),
    );
  }

  Widget _exerciseCard(ex, int index) {
    final double progress = ex.progress;

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
            colors: [const Color(0xFFEA8945).withOpacity(0.3), const Color(0xFF0E0E0E)],
            center: Alignment.topRight,
            radius: 1.5,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(ex.title ?? "", style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
                GestureDetector(
                  onTap: () async {
                    // Edit logic can be added here
                  },
                  child: const Icon(Icons.edit, color: Colors.orange, size: 20),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _infoItem("Duration:", ex.duration ?? ""),
                _infoItem("Reps:", ex.maxReps.toString()),
                _infoItem("Sets:", ex.maxSets.toString()),
                _infoItem("Exercise:", ex.numberOfExercises.toString()),
              ],
            ),
            const SizedBox(height: 12),
            const Text("Progress", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 4),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFFFF7F32)),
                backgroundColor: Colors.white24,
              ),
            ),
            const SizedBox(height: 4),
            Text("${(progress * 100).toStringAsFixed(0)}%", style: const TextStyle(color: Colors.white54, fontSize: 12)),
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
        Text(value, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 14)),
      ],
    );
  }
}
