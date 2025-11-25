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

