// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'body_weight_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BodyWeightModelAdapter extends TypeAdapter<BodyWeightModel> {
  @override
  final int typeId = 5;

  @override
  BodyWeightModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BodyWeightModel(
      id: fields[0] as String,
      weight: fields[1] as double,
      recordedAt: fields[2] as DateTime,
      notes: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BodyWeightModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.weight)
      ..writeByte(2)
      ..write(obj.recordedAt)
      ..writeByte(3)
      ..write(obj.notes);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BodyWeightModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class CalorieTrackingModelAdapter extends TypeAdapter<CalorieTrackingModel> {
  @override
  final int typeId = 6;

  @override
  CalorieTrackingModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CalorieTrackingModel(
      id: fields[0] as String,
      caloriesBurned: fields[1] as int,
      date: fields[2] as DateTime,
      source: fields[3] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, CalorieTrackingModel obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.caloriesBurned)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.source);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CalorieTrackingModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
