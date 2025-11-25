import 'package:hive/hive.dart';

part 'calories_log_model.g.dart';

@HiveType(typeId: 13)
class CaloriesLog extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  int calories;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String? source; // e.g., "Push ups", "Running", etc.

  @HiveField(4)
  String? notes;

  CaloriesLog({
    required this.id,
    required this.calories,
    required this.date,
    this.source,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'calories': calories,
        'date': date.toIso8601String(),
        'source': source,
        'notes': notes,
      };

  factory CaloriesLog.fromJson(Map<String, dynamic> json) => CaloriesLog(
        id: json['id'],
        calories: json['calories'],
        date: DateTime.parse(json['date']),
        source: json['source'],
        notes: json['notes'],
      );
}