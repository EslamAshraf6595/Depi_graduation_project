// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class GoalModelAdapter extends TypeAdapter<GoalModel> {
  @override
  final int typeId = 7;

  @override
  GoalModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return GoalModel(
      id: fields[0] as String,
      title: fields[1] as String,
      type: fields[2] as GoalType,
      targetValue: fields[3] as double,
      currentValue: fields[4] as double,
      createdAt: fields[5] as DateTime,
      deadline: fields[6] as DateTime?,
      isCompleted: fields[7] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, GoalModel obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.title)
      ..writeByte(2)
      ..write(obj.type)
      ..writeByte(3)
      ..write(obj.targetValue)
      ..writeByte(4)
      ..write(obj.currentValue)
      ..writeByte(5)
      ..write(obj.createdAt)
      ..writeByte(6)
      ..write(obj.deadline)
      ..writeByte(7)
      ..write(obj.isCompleted);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class GoalTypeAdapter extends TypeAdapter<GoalType> {
  @override
  final int typeId = 8;

  @override
  GoalType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return GoalType.overallProgress;
      case 1:
        return GoalType.exercise;
      default:
        return GoalType.overallProgress;
    }
  }

  @override
  void write(BinaryWriter writer, GoalType obj) {
    switch (obj) {
      case GoalType.overallProgress:
        writer.writeByte(0);
        break;
      case GoalType.exercise:
        writer.writeByte(1);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GoalTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
