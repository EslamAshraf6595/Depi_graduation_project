import 'package:flutter/material.dart';
import '../models/plan_model.dart';
import '../models/exercise_model.dart';

class PlanProvider extends ChangeNotifier {
  List<PlanModel> plans = [];

  void createPlan(String planName, List<ExerciseModel> exercises) {
    plans.add(
      PlanModel(
        id: DateTime.now().microsecondsSinceEpoch.toString(),
        name: planName,
        exercises: List.from(exercises),
      ),
    );
    notifyListeners();
  }

  List<PlanModel> get allPlans => plans;
}
