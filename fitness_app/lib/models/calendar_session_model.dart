import 'package:hive/hive.dart';

part 'calendar_session_model.g.dart';

@HiveType(typeId: 12)
class CalendarSession extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  String workoutId;

  @HiveField(3)
  String workoutName;

  @HiveField(4)
  bool isCompleted;

  @HiveField(5)
  DateTime? completedAt;

  CalendarSession({
    required this.id,
    required this.date,
    required this.workoutId,
    required this.workoutName,
    this.isCompleted = false,
    this.completedAt,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date.toIso8601String(),
        'workoutId': workoutId,
        'workoutName': workoutName,
        'isCompleted': isCompleted,
        'completedAt': completedAt?.toIso8601String(),
      };

  factory CalendarSession.fromJson(Map<String, dynamic> json) =>
      CalendarSession(
        id: json['id'],
        date: DateTime.parse(json['date']),
        workoutId: json['workoutId'],
        workoutName: json['workoutName'],
        isCompleted: json['isCompleted'] ?? false,
        completedAt: json['completedAt'] != null
            ? DateTime.parse(json['completedAt'])
            : null,
      );
}