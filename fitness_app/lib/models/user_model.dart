import 'package:hive/hive.dart';

part 'user_model.g.dart';

@HiveType(typeId: 13)
class UserModel {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String email;

  @HiveField(2)
  final String name;

  @HiveField(3)
  final double weight;

  @HiveField(4)
  final double height;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.weight,
    required this.height,
  });
}
