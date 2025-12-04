import 'package:flutter/material.dart';
import '../models/exercise_model.dart';
import 'exercise_provider.dart';

class WorkoutProvider extends ChangeNotifier {
  List<ExerciseModel> exercises = [];
  List<ExerciseModel> completedExercises = [];

  void addExercise(ExerciseModel exercise) {
    exercises.add(exercise);
    notifyListeners();
  }

  /// Increment/decrement logic
  void decrementReps(ExerciseModel ex) {
    if (ex.reps > 0) {
      ex.reps--;
      _updateExerciseAccuracy(ex);
      notifyListeners();
    }
  }

  void decrementRest(ExerciseModel ex) {
    if (ex.rest > 0) {
      ex.rest--;
      _updateExerciseAccuracy(ex);
      notifyListeners();
    }
  }

  void incrementWeight(ExerciseModel ex) {
    ex.weight++;
    notifyListeners();
  }

  void decrementWeight(ExerciseModel ex) {
    if (ex.weight > 0) {
      ex.weight--;
      notifyListeners();
    }
  }

  /// Core: update accuracy dynamically
  void _updateExerciseAccuracy(ExerciseModel ex) {
    // Calculate done reps and sets
    ex.doneReps = ex.maxReps - ex.reps;
    ex.doneSets = ex.maxSets - ex.rest;

    // Accuracy depends on the fraction of reps/rest done correctly
    double repsAccuracy =
        ex.maxReps == 0 ? 0 : (ex.doneReps / ex.maxReps).clamp(0.0, 1.0);
    double setsAccuracy =
        ex.maxSets == 0 ? 0 : (ex.doneSets / ex.maxSets).clamp(0.0, 1.0);

    // Weighted average (you can adjust weight for sets vs reps)
    ex.formAccuracy = ((repsAccuracy * 0.7) + (setsAccuracy * 0.3)).clamp(0.0, 1.0);

    // Add to completedExercises only once
    if (!completedExercises.contains(ex) && (ex.doneReps > 0 || ex.doneSets > 0)) {
      ex.completedDateStr =
          "${DateTime.now().day}-${DateTime.now().month}-${DateTime.now().year}";
      completedExercises.add(ex);
    }
  }

  /// Get overall accuracy dynamically
  double calculateOverallAccuracy() {
    if (completedExercises.isEmpty) return 0.0;

    double total = 0.0;
    for (var ex in completedExercises) {
      total += ex.formAccuracy;
    }
    return (total / completedExercises.length).clamp(0.0, 1.0);
  }

  /// Call this if exercise is fully completed manually
  void completeExercise(ExerciseModel ex) {
    ex.doneReps = ex.maxReps;
    ex.doneSets = ex.maxSets;
    ex.isCompleted = true;
    _updateExerciseAccuracy(ex);
    notifyListeners();
  }

  /// Reset all exercises if needed
  void resetExercises() {
    for (var ex in exercises) {
      ex.doneReps = 0;
      ex.doneSets = 0;
      ex.reps = ex.maxReps;
      ex.rest = ex.maxSets;
      ex.formAccuracy = 0.0;
    }
    completedExercises.clear();
    notifyListeners();
  }
}
