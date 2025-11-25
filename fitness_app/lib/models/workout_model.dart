import 'package:hive/hive.dart';

part 'workout_model.g.dart';

@HiveType(typeId: 10)
class WorkoutModel extends HiveObject {
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

  WorkoutModel({
    required this.id,
    required this.name,
    required this.exerciseIds,
    required this.createdAt,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'exerciseIds': exerciseIds,
        'createdAt': createdAt.toIso8601String(),
        'notes': notes,
      };

  factory WorkoutModel.fromJson(Map<String, dynamic> json) => WorkoutModel(
        id: json['id'],
        name: json['name'],
        exerciseIds: List<String>.from(json['exerciseIds']),
        createdAt: DateTime.parse(json['createdAt']),
        notes: json['notes'],
      );
}