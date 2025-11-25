import 'package:hive/hive.dart';

part 'body_weight_model.g.dart';

@HiveType(typeId: 5)
class BodyWeightModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  double weight; // in kg

  @HiveField(2)
  DateTime recordedAt;

  @HiveField(3)
  String? notes;

  BodyWeightModel({
    required this.id,
    required this.weight,
    required this.recordedAt,
    this.notes,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'weight': weight,
        'recordedAt': recordedAt.toIso8601String(),
        'notes': notes,
      };

  factory BodyWeightModel.fromJson(Map<String, dynamic> json) =>
      BodyWeightModel(
        id: json['id'],
        weight: json['weight'].toDouble(),
        recordedAt: DateTime.parse(json['recordedAt']),
        notes: json['notes'],
      );
}

// lib/models/calorie_tracking_model.dart
@HiveType(typeId: 6)
class CalorieTrackingModel extends HiveObject {
  @HiveField(0)
  String id;

  @HiveField(1)
  int caloriesBurned;

  @HiveField(2)
  DateTime date;

  @HiveField(3)
  String? source; // e.g., "Push ups", "Running", etc.

  CalorieTrackingModel({
    required this.id,
    required this.caloriesBurned,
    required this.date,
    this.source,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'caloriesBurned': caloriesBurned,
        'date': date.toIso8601String(),
        'source': source,
      };

  factory CalorieTrackingModel.fromJson(Map<String, dynamic> json) =>
      CalorieTrackingModel(
        id: json['id'],
        caloriesBurned: json['caloriesBurned'],
        date: DateTime.parse(json['date']),
        source: json['source'],
      );
}
