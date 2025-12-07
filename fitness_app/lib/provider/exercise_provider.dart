import 'package:flutter/material.dart';
import '../models/exercise_model.dart';
import 'package:hive/hive.dart';

class ExerciseProvider extends ChangeNotifier {
  final List<ExerciseModel> _exercises = [];
  late Box<ExerciseModel> _box;

  ExerciseProvider() {
    _initHive();
  }

  Future<void> _initHive() async {
    _box = await Hive.openBox<ExerciseModel>('exercisesBox');
    _exercises.addAll(_box.values);
    notifyListeners();
  }

  List<ExerciseModel> get exercises => _exercises;

  void addExercise(ExerciseModel exercise) {
    _exercises.add(exercise);
    _box.add(exercise); // Save to Hive
    notifyListeners();
  }

  void incrementRepsDone(ExerciseModel exercise) {
    if (exercise.doneReps < exercise.maxReps) {
      exercise.doneReps++;
      _updateFormAccuracy(exercise);
      exercise.save(); // Update Hive
      notifyListeners();
    }
  }

  void incrementSetsDone(ExerciseModel exercise) {
    if (exercise.doneSets < exercise.maxSets) {
      exercise.doneSets++;
      exercise.doneReps = 0;
      _updateFormAccuracy(exercise);
      exercise.save(); // Update Hive
      notifyListeners();
    }
  }

  void completeExercise(ExerciseModel exercise) {
    exercise.doneReps = exercise.maxReps;
    exercise.doneSets = exercise.maxSets;
    exercise.isCompleted = true;
    _updateFormAccuracy(exercise);
    exercise.save(); // Update Hive
    notifyListeners();
  }

  void _updateFormAccuracy(ExerciseModel exercise) {
    exercise.formAccuracy = exercise.calculatedAccuracy;
  }

  void updateExercise(ExerciseModel exercise) {
    int index = _exercises.indexOf(exercise);
    if (index != -1) {
      _exercises[index] = exercise;
      exercise.save(); // Update Hive
      notifyListeners();
    }
  }

  double get overallProgress {
    if (_exercises.isEmpty) return 0.0;
    double total = 0.0;
    for (var ex in _exercises) {
      total += ex.progress;
    }
    return total / _exercises.length;
  }
}
