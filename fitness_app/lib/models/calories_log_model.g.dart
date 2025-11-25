// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'calories_log_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CaloriesLogAdapter extends TypeAdapter<CaloriesLog> {
  @override
  final int typeId = 13;

  @override
  CaloriesLog read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CaloriesLog(
      id: fields[0] as String,
      calories: fields[1] as int,
      date: fields[2] as DateTime,
      source: fields[3] as String?,
      notes: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CaloriesLog obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.calories)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.source)
      ..writeByte(4)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CaloriesLogAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
