import 'package:hive/hive.dart';

part 'exercise_model.g.dart';

@HiveType(typeId: 1)
class ExerciseModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  int reps;

  @HiveField(3)
  int sets;

  @HiveField(4)
  int duration; // in seconds

  @HiveField(5)
  int restTime; // in seconds

  @HiveField(6)
  String? notes;

  ExerciseModel({
    required this.id,
    required this.name,
    required this.reps,
    required this.sets,
    required this.duration,
    this.restTime = 60,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'reps': reps,
        'sets': sets,
        'duration': duration,
        'restTime': restTime,
        'notes': notes,
      };

  factory ExerciseModel.fromJson(Map<String, dynamic> json) => ExerciseModel(
        id: json['id'],
        name: json['name'],
        reps: json['reps'],
        sets: json['sets'],
        duration: json['duration'],
        restTime: json['restTime'] ?? 60,
        notes: json['notes'],
      );
}

@HiveType(typeId: 2)
class WorkoutPlanModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String name;

  @HiveField(2)
  List<String> exerciseIds;

  @HiveField(3)
  DateTime createdAt;

  @HiveField(4)
  String? notes;

  @HiveField(5)
  List<DateTime> scheduledDates;

  WorkoutPlanModel({
    required this.id,
    required this.name,
    required this.exerciseIds,
    required this.createdAt,
    this.notes,
    this.scheduledDates = const [],
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'exerciseIds': exerciseIds,
        'createdAt': createdAt.toIso8601String(),
        'notes': notes,
        'scheduledDates':
            scheduledDates.map((d) => d.toIso8601String()).toList(),
      };

  factory WorkoutPlanModel.fromJson(Map<String, dynamic> json) =>
      WorkoutPlanModel(
        id: json['id'],
        name: json['name'],
        exerciseIds: List<String>.from(json['exerciseIds']),
        createdAt: DateTime.parse(json['createdAt']),
        notes: json['notes'],
        scheduledDates: (json['scheduledDates'] as List?)
                ?.map((d) => DateTime.parse(d))
                .toList() ??
            [],
      );
}

@HiveType(typeId: 3)
class CompletedWorkoutModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String workoutPlanId;

  @HiveField(2)
  String workoutName;

  @HiveField(3)
  DateTime completedAt;

  @HiveField(4)
  int totalCaloriesBurned;

  @HiveField(5)
  int totalDuration;

  @HiveField(6)
  List<CompletedExercise> exercises;

  CompletedWorkoutModel({
    required this.id,
    required this.workoutPlanId,
    required this.workoutName,
    required this.completedAt,
    required this.totalCaloriesBurned,
    required this.totalDuration,
    required this.exercises,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'workoutPlanId': workoutPlanId,
        'workoutName': workoutName,
        'completedAt': completedAt.toIso8601String(),
        'totalCaloriesBurned': totalCaloriesBurned,
        'totalDuration': totalDuration,
        'exercises': exercises.map((e) => e.toJson()).toList(),
      };

  factory CompletedWorkoutModel.fromJson(Map<String, dynamic> json) =>
      CompletedWorkoutModel(
        id: json['id'],
        workoutPlanId: json['workoutPlanId'],
        workoutName: json['workoutName'],
        completedAt: DateTime.parse(json['completedAt']),
        totalCaloriesBurned: json['totalCaloriesBurned'],
        totalDuration: json['totalDuration'],
        exercises: (json['exercises'] as List)
            .map((e) => CompletedExercise.fromJson(e))
            .toList(),
      );
}

@HiveType(typeId: 4)
class CompletedExercise extends HiveObject {
  @HiveField(0)
  String exerciseId;

  @HiveField(1)
  String exerciseName;

  @HiveField(2)
  int completedReps;

  @HiveField(3)
  int completedSets;

  @HiveField(4)
  int caloriesBurned;

  CompletedExercise({
    required this.exerciseId,
    required this.exerciseName,
    required this.completedReps,
    required this.completedSets,
    required this.caloriesBurned,
  });

  Map<String, dynamic> toJson() => {
        'exerciseId': exerciseId,
        'exerciseName': exerciseName,
        'completedReps': completedReps,
        'completedSets': completedSets,
        'caloriesBurned': caloriesBurned,
      };

  factory CompletedExercise.fromJson(Map<String, dynamic> json) =>
      CompletedExercise(
        exerciseId: json['exerciseId'],
        exerciseName: json['exerciseName'],
        completedReps: json['completedReps'],
        completedSets: json['completedSets'],
        caloriesBurned: json['caloriesBurned'],
      );
}