import 'package:hive/hive.dart';

part 'settings_model.g.dart';

@HiveType(typeId: 9)
class SettingsModel extends HiveObject {
  @HiveField(0)
  bool notificationsEnabled;

  @HiveField(1)
  bool darkMode;

  @HiveField(2)
  String language;

  SettingsModel({
    this.notificationsEnabled = true,
    this.darkMode = true,
    this.language = 'en',
  });

  Map<String, dynamic> toJson() => {
        'notificationsEnabled': notificationsEnabled,
        'darkMode': darkMode,
        'language': language,
      };

  factory SettingsModel.fromJson(Map<String, dynamic> json) => SettingsModel(
        notificationsEnabled: json['notificationsEnabled'] ?? true,
        darkMode: json['darkMode'] ?? true,
        language: json['language'] ?? 'en',
      );
}