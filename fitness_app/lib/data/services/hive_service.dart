import 'package:hive_flutter/hive_flutter.dart';
import 'package:fitness_app/models/user_model.dart';
import 'package:fitness_app/models/workout_model.dart';
import 'package:fitness_app/models/plan_model.dart';
import 'package:fitness_app/models/calories_log_model.dart';
import 'package:fitness_app/models/calendar_session_model.dart';
import 'package:fitness_app/models/goal_model.dart';
import 'package:fitness_app/models/body_weight_model.dart';
import 'package:fitness_app/models/settings_model.dart';

class HiveService {
  // Box names
  static const String userBoxName = 'users_box';
  static const String workoutBoxName = 'workouts_box';
  static const String planBoxName = 'plans_box';
  static const String caloriesBoxName = 'calories_box';
  static const String calendarBoxName = 'calendar_box';
  static const String goalBoxName = 'goals_box';
  static const String bodyWeightBoxName = 'body_weight_box';
  static const String settingsBoxName = 'settings_box';

  // Initialize Hive
  static Future<void> init() async {
    await Hive.initFlutter();

    // Register all adapters
    Hive.registerAdapter(UserModelAdapter());
    Hive.registerAdapter(WorkoutModelAdapter());
    Hive.registerAdapter(PlanModelAdapter());
    Hive.registerAdapter(CaloriesLogAdapter());
    Hive.registerAdapter(CalendarSessionAdapter());
    Hive.registerAdapter(GoalModelAdapter());
    Hive.registerAdapter(GoalTypeAdapter());
    Hive.registerAdapter(BodyWeightModelAdapter());
    Hive.registerAdapter(SettingsModelAdapter());

    // Open all boxes
    await Future.wait([
      Hive.openBox<UserModel>(userBoxName),
      Hive.openBox<WorkoutModel>(workoutBoxName),
      Hive.openBox<PlanModel>(planBoxName),
      Hive.openBox<CaloriesLog>(caloriesBoxName),
      Hive.openBox<CalendarSession>(calendarBoxName),
      Hive.openBox<GoalModel>(goalBoxName),
      Hive.openBox<BodyWeightModel>(bodyWeightBoxName),
      Hive.openBox<SettingsModel>(settingsBoxName),
    ]);
  }

  // Get box helper
  static Box<T> getBox<T>(String boxName) {
    return Hive.box<T>(boxName);
  }

  // Close all boxes
  static Future<void> closeAll() async {
    await Hive.close();
  }

  // Clear all data (useful for logout)
  static Future<void> clearAllData() async {
    await Future.wait([
      Hive.box<UserModel>(userBoxName).clear(),
      Hive.box<WorkoutModel>(workoutBoxName).clear(),
      Hive.box<PlanModel>(planBoxName).clear(),
      Hive.box<CaloriesLog>(caloriesBoxName).clear(),
      Hive.box<CalendarSession>(calendarBoxName).clear(),
      Hive.box<GoalModel>(goalBoxName).clear(),
      Hive.box<BodyWeightModel>(bodyWeightBoxName).clear(),
      // Don't clear settings box on logout
    ]);
  }
}