import 'package:fitness_app/models/exercise_model.dart';

class PlanModel {
  final String id;
  final String name;
  final List<ExerciseModel> exercises;

  PlanModel({
    required this.id,
    required this.name,
    required this.exercises,
  });
}
