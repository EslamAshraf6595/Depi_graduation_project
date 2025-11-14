class WorkoutSummaryData {
  final int totalReps;
  final int totalSets;
  final int totalDurationSeconds;
  final int totalCalories;
  final int tutAccuracy;

  WorkoutSummaryData({
    required this.totalReps,
    required this.totalSets,
    required this.totalDurationSeconds,
    this.totalCalories = 356, // Default value from design
    this.tutAccuracy = 68,   // Default value from design
  });
}