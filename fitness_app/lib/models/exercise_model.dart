import 'package:hive/hive.dart';

part 'exercise_model.g.dart';

@HiveType(typeId: 1)
class ExerciseModel extends HiveObject { // ✅ Extend HiveObject
  @HiveField(0)
  String? title;

  @HiveField(1)
  String? duration;

  @HiveField(2)
  int maxReps;

  @HiveField(3)
  int maxSets;

  @HiveField(4)
  int completedReps;

  @HiveField(5)
  int numberOfExercises;

  @HiveField(6)
  bool isDone;

  @HiveField(7)
  int weight;

  @HiveField(8)
  int rest;

  @HiveField(9)
  int reps;

  @HiveField(10)
  int type;

  @HiveField(11)
  int target;

  @HiveField(12)
  bool isFavorite;

  @HiveField(13)
  bool isCompleted;

  @HiveField(14)
  int doneReps;

  @HiveField(15)
  int doneSets;

  @HiveField(16)
  int originalMaxReps;

  @HiveField(17)
  int originalMaxSets;

  @HiveField(18)
  double formAccuracy;

  @HiveField(19)
  String formFeedback;

  @HiveField(20)
  String completedDateStr;

  @HiveField(21)
  int calories;

  ExerciseModel({
    this.title,
    this.duration,
    this.maxReps = 10,
    this.maxSets = 3,
    this.completedReps = 0,
    this.numberOfExercises = 1,
    this.weight = 0,
    this.rest = 30,
    this.reps = 0,
    this.type = 1,
    int? target,
    this.isFavorite = false,
    this.isCompleted = false,
    this.isDone = false,
    this.doneReps = 0,
    this.doneSets = 0,
    this.formAccuracy = 0.0,
    this.formFeedback = '',
    this.completedDateStr = '',
    this.calories = 0,
  })  : originalMaxReps = maxReps,
        originalMaxSets = maxSets,
        target = target ?? maxReps;

  double get progress {
    final total = maxReps * maxSets;
    if (total == 0) return 0;
    final completed = (doneSets * maxReps) + doneReps;
    return (completed / total).clamp(0.0, 1.0);
  }

  double get calculatedAccuracy => progress;
}
