import 'package:flutter/material.dart';
import 'package:hive/hive.dart';                      // <-- required
import '../models/plan_model.dart';                  // <-- required
import '../models/exercise_model.dart';              // <-- required

class PlanProvider extends ChangeNotifier {
  late Box<PlanModel> _box;                          // <-- now recognized
  List<PlanModel> plans = [];

  PlanProvider() {
    _box = Hive.box<PlanModel>('plansBox');
    plans = _box.values.toList();
  }

  void createPlan(String name, List<ExerciseModel> exercises) {
    final plan = PlanModel(
      id: DateTime.now().microsecondsSinceEpoch.toString(),
      name: name,
      exercises: exercises,
    );

    plans.add(plan);
    _box.add(plan);
    notifyListeners();
  }

  List<PlanModel> get allPlans => plans;
}
