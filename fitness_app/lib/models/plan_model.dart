import 'package:hive/hive.dart';
import 'exercise_model.dart';

part 'plan_model.g.dart';

@HiveType(typeId: 2)
class PlanModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final List<ExerciseModel> exercises;

  PlanModel({
    required this.id,
    required this.name,
    required this.exercises,
  });
}
