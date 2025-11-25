import 'package:hive/hive.dart';

part 'calorie_tracking_model.g.dart';

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
