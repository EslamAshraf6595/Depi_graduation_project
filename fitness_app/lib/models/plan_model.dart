import 'package:hive/hive.dart';

part 'plan_model.g.dart';

@HiveType(typeId: 11)
class PlanModel extends HiveObject {
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

  PlanModel({
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

  factory PlanModel.fromJson(Map<String, dynamic> json) => PlanModel(
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