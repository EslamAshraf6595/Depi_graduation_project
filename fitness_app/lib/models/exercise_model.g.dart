// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ExerciseModelAdapter extends TypeAdapter<ExerciseModel> {
  @override
  final int typeId = 1;

  @override
  ExerciseModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ExerciseModel(
      id: fields[0] as String,
      name: fields[1] as String,
      reps: fields[2] as int,
      sets: fields[3] as int,
      duration: fields[4] as int,
      restTime: fields[5] as int,
      notes: fields[6] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, ExerciseModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.reps)
      ..writeByte(3)
      ..write(obj.sets)
      ..writeByte(4)
      ..write(obj.duration)
      ..writeByte(5)
      ..write(obj.restTime)
      ..writeByte(6)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExerciseModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class WorkoutPlanModelAdapter extends TypeAdapter<WorkoutPlanModel> {
  @override
  final int typeId = 2;

  @override
  WorkoutPlanModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return WorkoutPlanModel(
      id: fields[0] as String,
      name: fields[1] as String,
      exerciseIds: (fields[2] as List).cast<String>(),
      createdAt: fields[3] as DateTime,
      notes: fields[4] as String?,
      scheduledDates: (fields[5] as List).cast<DateTime>(),
    );
  }

  @override
  void write(BinaryWriter writer, WorkoutPlanModel obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.exerciseIds)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.notes)
      ..writeByte(5)
      ..write(obj.scheduledDates);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is WorkoutPlanModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CompletedWorkoutModelAdapter extends TypeAdapter<CompletedWorkoutModel> {
  @override
  final int typeId = 3;

  @override
  CompletedWorkoutModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompletedWorkoutModel(
      id: fields[0] as String,
      workoutPlanId: fields[1] as String,
      workoutName: fields[2] as String,
      completedAt: fields[3] as DateTime,
      totalCaloriesBurned: fields[4] as int,
      totalDuration: fields[5] as int,
      exercises: (fields[6] as List).cast<CompletedExercise>(),
    );
  }

  @override
  void write(BinaryWriter writer, CompletedWorkoutModel obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.workoutPlanId)
      ..writeByte(2)
      ..write(obj.workoutName)
      ..writeByte(3)
      ..write(obj.completedAt)
      ..writeByte(4)
      ..write(obj.totalCaloriesBurned)
      ..writeByte(5)
      ..write(obj.totalDuration)
      ..writeByte(6)
      ..write(obj.exercises);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompletedWorkoutModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CompletedExerciseAdapter extends TypeAdapter<CompletedExercise> {
  @override
  final int typeId = 4;

  @override
  CompletedExercise read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CompletedExercise(
      exerciseId: fields[0] as String,
      exerciseName: fields[1] as String,
      completedReps: fields[2] as int,
      completedSets: fields[3] as int,
      caloriesBurned: fields[4] as int,
    );
  }

  @override
  void write(BinaryWriter writer, CompletedExercise obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.exerciseId)
      ..writeByte(1)
      ..write(obj.exerciseName)
      ..writeByte(2)
      ..write(obj.completedReps)
      ..writeByte(3)
      ..write(obj.completedSets)
      ..writeByte(4)
      ..write(obj.caloriesBurned);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CompletedExerciseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
