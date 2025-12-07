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
      title: fields[0] as String?,
      duration: fields[1] as String?,
      maxReps: fields[2] as int,
      maxSets: fields[3] as int,
      completedReps: fields[4] as int,
      numberOfExercises: fields[5] as int,
      weight: fields[7] as int,
      rest: fields[8] as int,
      reps: fields[9] as int,
      type: fields[10] as int,
      target: fields[11] as int?,
      isFavorite: fields[12] as bool,
      isCompleted: fields[13] as bool,
      isDone: fields[6] as bool,
      doneReps: fields[14] as int,
      doneSets: fields[15] as int,
      formAccuracy: fields[18] as double,
      formFeedback: fields[19] as String,
      completedDateStr: fields[20] as String,
      calories: fields[21] as int,
    )
      ..originalMaxReps = fields[16] as int
      ..originalMaxSets = fields[17] as int;
  }

  @override
  void write(BinaryWriter writer, ExerciseModel obj) {
    writer
      ..writeByte(22)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.duration)
      ..writeByte(2)
      ..write(obj.maxReps)
      ..writeByte(3)
      ..write(obj.maxSets)
      ..writeByte(4)
      ..write(obj.completedReps)
      ..writeByte(5)
      ..write(obj.numberOfExercises)
      ..writeByte(6)
      ..write(obj.isDone)
      ..writeByte(7)
      ..write(obj.weight)
      ..writeByte(8)
      ..write(obj.rest)
      ..writeByte(9)
      ..write(obj.reps)
      ..writeByte(10)
      ..write(obj.type)
      ..writeByte(11)
      ..write(obj.target)
      ..writeByte(12)
      ..write(obj.isFavorite)
      ..writeByte(13)
      ..write(obj.isCompleted)
      ..writeByte(14)
      ..write(obj.doneReps)
      ..writeByte(15)
      ..write(obj.doneSets)
      ..writeByte(16)
      ..write(obj.originalMaxReps)
      ..writeByte(17)
      ..write(obj.originalMaxSets)
      ..writeByte(18)
      ..write(obj.formAccuracy)
      ..writeByte(19)
      ..write(obj.formFeedback)
      ..writeByte(20)
      ..write(obj.completedDateStr)
      ..writeByte(21)
      ..write(obj.calories);
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
