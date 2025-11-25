import 'package:fitness_app/models/body_weight_model.dart';
import 'package:fitness_app/models/calorie_tracking_model.dart';
import 'package:fitness_app/models/goal_model.dart';
import 'package:hive/hive.dart';
import '../services/hive_service.dart';


class TrackingRepository {
  final Box<GoalModel> _goalBox;
  final Box<BodyWeightModel> _bodyWeightBox;
  final Box<CalorieTrackingModel> _calorieBox;

  TrackingRepository({
    required Box<GoalModel> goalBox,
    required Box<BodyWeightModel> bodyWeightBox,
    required Box<CalorieTrackingModel> calorieBox,
  })  : _goalBox = goalBox,
        _bodyWeightBox = bodyWeightBox,
        _calorieBox = calorieBox;

  /** ========================= GOALS ============================== **/

  Future<void> addGoal(GoalModel goal) async {
    await _goalBox.put(goal.id, goal);
  }

  Future<void> updateGoal(GoalModel goal) async {
    await _goalBox.put(goal.id, goal);
  }

  Future<void> deleteGoal(String id) async {
    await _goalBox.delete(id);
  }

  GoalModel? getGoal(String id) {
    return _goalBox.get(id);
  }

  List<GoalModel> getActiveGoals() {
    return _goalBox.values.where((goal) => !goal.isCompleted).toList();
  }

  /** Safely updating progress */
  Future<void> updateGoalProgress(String id, double progress) async {
    final goal = getGoal(id);
    if (goal != null) {
      goal.currentValue = progress;
      goal.isCompleted = progress >= goal.targetValue;

      // Save only if GoalModel extends HiveObject
      await goal.save();
    }
  }

  double getOverallProgress() {
    final goals = getActiveGoals();
    if (goals.isEmpty) return 0;

    final totalProgress = goals.fold(0.0, (sum, goal) => sum + goal.progress);
    return totalProgress / goals.length;
  }

  /** ========================= BODY WEIGHT =============================== **/

  Future<void> addBodyWeight(BodyWeightModel bodyWeight) async {
    await _bodyWeightBox.put(bodyWeight.id, bodyWeight);
  }

  Future<void> updateBodyWeight(BodyWeightModel bodyWeight) async {
    await _bodyWeightBox.put(bodyWeight.id, bodyWeight);
  }

  Future<void> deleteBodyWeight(String id) async {
    await _bodyWeightBox.delete(id);
  }

  BodyWeightModel? getBodyWeight(String id) {
    return _bodyWeightBox.get(id);
  }

  List<BodyWeightModel> getAllBodyWeights() {
    final bodyWeights = _bodyWeightBox.values.toList();
    bodyWeights.sort((a, b) => b.recordedAt.compareTo(a.recordedAt));
    return bodyWeights;
  }

  /** FIXED: includes edges + sorted */
  List<BodyWeightModel> getBodyWeightsInRange(
      DateTime startDate, DateTime endDate) {
    return _bodyWeightBox.values.where((weight) {
      return !weight.recordedAt.isBefore(startDate) &&
             !weight.recordedAt.isAfter(endDate);
    }).toList()
      ..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));
  }

  /** ========================= CALORIES =============================== **/

  Future<void> addCalorieTracking(CalorieTrackingModel calorie) async {
    await _calorieBox.put(calorie.id, calorie);
  }

  Future<void> updateCalorieTracking(CalorieTrackingModel calorie) async {
    await _calorieBox.put(calorie.id, calorie);
  }

  Future<void> deleteCalorieTracking(String id) async {
    await _calorieBox.delete(id);
  }

  CalorieTrackingModel? getCalorieTracking(String id) {
    return _calorieBox.get(id);
  }

  /** FIXED: sorted */
  List<CalorieTrackingModel> getAllCalorieTracking() {
    final calories = _calorieBox.values.toList();
    calories.sort((a, b) => b.date.compareTo(a.date));
    return calories;
  }

  /** FIXED: includes edges + sorted */
  List<CalorieTrackingModel> getCaloriesInRange(
      DateTime startDate, DateTime endDate) {
    return _calorieBox.values.where((calorie) {
      return !calorie.date.isBefore(startDate) &&
             !calorie.date.isAfter(endDate);
    }).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }
}
