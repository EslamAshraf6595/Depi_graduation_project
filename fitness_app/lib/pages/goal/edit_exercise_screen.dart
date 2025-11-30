import 'package:flutter/material.dart';

class EditExerciseScreen extends StatefulWidget {
  final String title;
  final String duration;
  final String reps;
  final String sets;
  final String exercise;

  const EditExerciseScreen({
    super.key,
    required this.title,
    required this.duration,
    required this.reps,
    required this.sets,
    required this.exercise,
  });

  @override
  State<EditExerciseScreen> createState() => _EditExerciseScreenState();
}

class _EditExerciseScreenState extends State<EditExerciseScreen> {
  late TextEditingController titleController;
  late TextEditingController durationController;
  late TextEditingController repsController;
  late TextEditingController setsController;
  late TextEditingController exerciseController;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController(text: widget.title);
    durationController = TextEditingController(text: widget.duration);
    repsController = TextEditingController(text: widget.reps);
    setsController = TextEditingController(text: widget.sets);
    exerciseController = TextEditingController(text: widget.exercise);
  }

  @override
  void dispose() {
    titleController.dispose();
    durationController.dispose();
    repsController.dispose();
    setsController.dispose();
    exerciseController.dispose();
    super.dispose();
  }

  void _saveChanges() {
    // For now, just pop and return data
    Navigator.pop(context, {
      'title': titleController.text,
      'duration': durationController.text,
      'reps': repsController.text,
      'sets': setsController.text,
      'exercise': exerciseController.text,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1C1C1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1C1C1E),
        title: const Text(
          "Edit Exercise",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.orange),
            onPressed: _saveChanges,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildField("Title", titleController),
            const SizedBox(height: 16),
            _buildField("Duration", durationController),
            const SizedBox(height: 16),
            _buildField("Reps", repsController),
            const SizedBox(height: 16),
            _buildField("Sets", setsController),
            const SizedBox(height: 16),
            _buildField("Exercise Count", exerciseController),
          ],
        ),
      ),
    );
  }

  Widget _buildField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange.withOpacity(0.5)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.orange),
        ),
      ),
    );
  }
}