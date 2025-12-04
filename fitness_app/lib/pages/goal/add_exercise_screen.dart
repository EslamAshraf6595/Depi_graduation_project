import 'package:fitness_app/provider/exercise_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/exercise_model.dart';


class AddExerciseScreen extends StatefulWidget {
  const AddExerciseScreen({super.key});

  @override
  State<AddExerciseScreen> createState() => _AddExerciseScreenState();
}

class _AddExerciseScreenState extends State<AddExerciseScreen> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();
  final TextEditingController _repsController = TextEditingController();
  final TextEditingController _setsController = TextEditingController();
  final TextEditingController _exerciseController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Add Exercise",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _inputField("Exercise Title", _titleController, "Enter exercise name"),
            const SizedBox(height: 16),
            _inputField("Duration", _durationController, "e.g. 20 minutes"),
            const SizedBox(height: 16),
            _inputField("Reps", _repsController, "e.g. 15"),
            const SizedBox(height: 16),
            _inputField("Sets", _setsController, "e.g. 3"),
            const SizedBox(height: 16),
            _inputField("Number of Exercises", _exerciseController, "e.g. 5"),
            const SizedBox(height: 30),
            _gradientButton("Save Exercise", () {
              if (_titleController.text.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Please enter exercise details"), backgroundColor: Colors.red),
                );
                return;
              }

              final newExercise = ExerciseModel(
                title: _titleController.text,
                duration: _durationController.text,
                maxReps: int.tryParse(_repsController.text) ?? 0,
                maxSets: int.tryParse(_setsController.text) ?? 0,
                numberOfExercises: int.tryParse(_exerciseController.text) ?? 1,
                target: int.tryParse(_repsController.text) ?? 0,
              );

              Provider.of<ExerciseProvider>(context, listen: false).addExercise(newExercise);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Exercise added successfully!"), backgroundColor: Colors.orange),
              );

              Navigator.pop(context);
            }),
          ],
        ),
      ),
    );
  }

  Widget _inputField(String label, TextEditingController controller, String hint) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
        const SizedBox(height: 8),
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            gradient: const LinearGradient(colors: [Color(0xFF161512), Color(0xFF000000)], begin: Alignment.topLeft, end: Alignment.bottomRight),
            border: Border.all(color: Colors.orange, width: 1),
          ),
          child: TextField(
            controller: controller,
            style: const TextStyle(color: Colors.white),
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.white54),
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 14),
            ),
          ),
        ),
      ],
    );
  }

  Widget _gradientButton(String text, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: const LinearGradient(colors: [Color(0xFFFFA84C), Color(0xFFFF6B2C)]),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Center(
                child: Text(text, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
