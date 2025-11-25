import 'package:hive/hive.dart';

part 'goal_model.g.dart';

@HiveType(typeId: 7)
class GoalModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  GoalType type;

  @HiveField(3)
  double targetValue;

  @HiveField(4)
  double currentValue;

  @HiveField(5)
  DateTime createdAt;

  @HiveField(6)
  DateTime? deadline;

  @HiveField(7)
  bool isCompleted;

  GoalModel({
    required this.id,
    required this.title,
    required this.type,
    required this.targetValue,
    this.currentValue = 0,
    required this.createdAt,
    this.deadline,
    this.isCompleted = false,
  });

  double get progress => (currentValue / targetValue * 100).clamp(0, 100);

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'type': type.index,
        'targetValue': targetValue,
        'currentValue': currentValue,
        'createdAt': createdAt.toIso8601String(),
        'deadline': deadline?.toIso8601String(),
        'isCompleted': isCompleted,
      };

  factory GoalModel.fromJson(Map<String, dynamic> json) => GoalModel(
        id: json['id'],
        title: json['title'],
        type: GoalType.values[json['type']],
        targetValue: json['targetValue'].toDouble(),
        currentValue: json['currentValue']?.toDouble() ?? 0,
        createdAt: DateTime.parse(json['createdAt']),
        deadline:
            json['deadline'] != null ? DateTime.parse(json['deadline']) : null,
        isCompleted: json['isCompleted'] ?? false,
      );
}

@HiveType(typeId: 8)
enum GoalType {
  @HiveField(0)
  overallProgress,

  @HiveField(1)
  exercise,
}

