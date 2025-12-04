import 'package:flutter/foundation.dart';

class WorkoutProgressService extends ChangeNotifier {
  static final WorkoutProgressService _instance =
      WorkoutProgressService._internal();

  factory WorkoutProgressService() => _instance;

  WorkoutProgressService._internal();

  int completedWorkouts = 0;
  double totalProgress = 0.0;

  void saveWorkoutProgress(double progress) {
    completedWorkouts += 1;
    totalProgress += progress;
    notifyListeners();
  }
}
