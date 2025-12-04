class ExerciseModel {
  String? title;
  String? duration;
  int maxReps;
  int maxSets;
  int completedReps;
  int numberOfExercises;
  bool isDone = false;
  int weight;
  int rest;
  int reps;
  int type; // 0 = Warm up, 1 = Main, 2 = Cool down
  int target;
  bool isFavorite;
  bool isCompleted;
  int doneReps; // track reps done
  int doneSets; // track sets done

  final int originalMaxReps;
  final int originalMaxSets;

  double formAccuracy; // 0.0 – 1.0
  String formFeedback;
  String completedDateStr;

  int calories = 0;

  ExerciseModel({
    this.doneReps = 0,
    this.doneSets = 0,
    this.title,
    this.duration,
    this.maxReps = 10,
    this.maxSets = 3,
    this.completedReps = 0,
    this.numberOfExercises = 1,
    this.weight = 0,
    this.rest = 30,
    this.reps = 0,
    this.type = 1,
    int? target,
    this.isFavorite = false,
    this.isCompleted = false,
    this.isDone = false,
    this.formAccuracy = 0.0,
    this.formFeedback = '',
    this.completedDateStr = '',
    this.calories = 0,
  })  : originalMaxReps = maxReps,
        originalMaxSets = maxSets,
        target = target ?? maxReps;

  // --------------------------
  // Reactive progress
  // --------------------------
  double get progress {
    final total = maxReps * maxSets;
    if (total == 0) return 0;
    final completed = (doneSets * maxReps) + doneReps;
    return (completed / total).clamp(0.0, 1.0);
  }

  // Accuracy getter
  double get calculatedAccuracy => progress;
}
