import 'package:fitness_app/models/body_weight_model.dart';
import 'package:fitness_app/models/goal_model.dart';
import 'package:hive/hive.dart';
import '../services/hive_service.dart';

class TrackingRepository {
  late Box<BodyWeightModel> _bodyWeightBox;
  late Box<CalorieTrackingModel> _calorieBox;
  late Box<GoalModel> _goalBox;

  TrackingRepository() {
    _bodyWeightBox = HiveService.getBox<BodyWeightModel>(HiveService.bodyWeightBoxName);
    _calorieBox = HiveService.getBox<CalorieTrackingModel>(HiveService.caloriesBoxName);
    _goalBox = HiveService.getBox<GoalModel>(HiveService.goalBoxName);
  }

  // Body Weight operations
  Future<void> addBodyWeight(BodyWeightModel weight) async {
    await _bodyWeightBox.put(weight.id, weight);
  }

  BodyWeightModel? getBodyWeight(String id) {
    return _bodyWeightBox.get(id);
  }

  List<BodyWeightModel> getAllBodyWeights() {
    final weights = _bodyWeightBox.values.toList();
    weights.sort((a, b) => b.recordedAt.compareTo(a.recordedAt));
    return weights;
  }

  // Get body weights within a date range
  List<BodyWeightModel> getBodyWeightsInRange(
      DateTime startDate, DateTime endDate) {
    return _bodyWeightBox.values.where((weight) {
      return weight.recordedAt.isAfter(startDate) &&
          weight.recordedAt.isBefore(endDate);
    }).toList()
      ..sort((a, b) => a.recordedAt.compareTo(b.recordedAt));
  }

  // Get latest body weight
  BodyWeightModel? getLatestBodyWeight() {
    final weights = getAllBodyWeights();
    return weights.isEmpty ? null : weights.first;
  }

  Future<void> updateBodyWeight(BodyWeightModel weight) async {
    await _bodyWeightBox.put(weight.id, weight);
  }

  Future<void> deleteBodyWeight(String id) async {
    await _bodyWeightBox.delete(id);
  }

  // Calorie Tracking operations
  Future<void> addCalorieTracking(CalorieTrackingModel calorie) async {
    await _calorieBox.put(calorie.id, calorie);
  }

  CalorieTrackingModel? getCalorieTracking(String id) {
    return _calorieBox.get(id);
  }

  List<CalorieTrackingModel> getAllCalorieTracking() {
    return _calorieBox.values.toList();
  }

  // Get calories for a specific date
  int getCaloriesForDate(DateTime date) {
    final calories = _calorieBox.values.where((calorie) {
      return calorie.date.year == date.year &&
          calorie.date.month == date.month &&
          calorie.date.day == date.day;
    });

    return calories.fold(0, (sum, calorie) => sum + calorie.caloriesBurned);
  }

  // Get calories within a date range
  List<CalorieTrackingModel> getCaloriesInRange(
      DateTime startDate, DateTime endDate) {
    return _calorieBox.values.where((calorie) {
      return calorie.date.isAfter(startDate) &&
          calorie.date.isBefore(endDate);
    }).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
  }

  // Get total calories burned in a date range
  int getTotalCaloriesInRange(DateTime startDate, DateTime endDate) {
    final calories = getCaloriesInRange(startDate, endDate);
    return calories.fold(0, (sum, calorie) => sum + calorie.caloriesBurned);
  }

  Future<void> deleteCalorieTracking(String id) async {
    await _calorieBox.delete(id);
  }

  // Goal operations
  Future<void> addGoal(GoalModel goal) async {
    await _goalBox.put(goal.id, goal);
  }

  GoalModel? getGoal(String id) {
    return _goalBox.get(id);
  }

  List<GoalModel> getAllGoals() {
    return _goalBox.values.toList();
  }

  List<GoalModel> getActiveGoals() {
    return _goalBox.values.where((goal) => !goal.isCompleted).toList();
  }

  List<GoalModel> getCompletedGoals() {
    return _goalBox.values.where((goal) => goal.isCompleted).toList();
  }

  Future<void> updateGoal(GoalModel goal) async {
    await _goalBox.put(goal.id, goal);
  }

  Future<void> updateGoalProgress(String id, double progress) async {
    final goal = getGoal(id);
    if (goal != null) {
      goal.currentValue = progress;
      if (goal.currentValue >= goal.targetValue) {
        goal.isCompleted = true;
      }
      await updateGoal(goal);
    }
  }

  Future<void> deleteGoal(String id) async {
    await _goalBox.delete(id);
  }

  // Get overall progress percentage
  double getOverallProgress() {
    final goals = getActiveGoals();
    if (goals.isEmpty) return 0;

    final totalProgress = goals.fold(0.0, (sum, goal) => sum + goal.progress);
    return totalProgress / goals.length;
  }

  // Stream for changes
  Stream<BoxEvent> watchBodyWeights() {
    return _bodyWeightBox.watch();
  }

  Stream<BoxEvent> watchCalories() {
    return _calorieBox.watch();
  }

  Stream<BoxEvent> watchGoals() {
    return _goalBox.watch();
  }
}