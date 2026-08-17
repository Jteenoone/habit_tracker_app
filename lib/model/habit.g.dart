// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'habit.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HabitAdapter extends TypeAdapter<Habit> {
  @override
  final int typeId = 0;

  @override
  Habit read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Habit(
      id: fields[0] as String,
      name: fields[1] as String,
      iconName: fields[2] as String,
      type: fields[3] as HabitType,
      weekDays: (fields[4] as List).cast<int>(),
      startDay: fields[5] as DateTime,
      endDay: fields[6] as DateTime?,
      targetMinutes: fields[7] as int?,
      maxCount: fields[8] as int?,
      unit: fields[9] as String?,
      clearStartDate: fields[10] as DateTime?,
      dailyProgress: (fields[11] as Map?)?.cast<DateTime, int>(),
      streakCount: fields[13] as int,
      createAt: fields[12] as DateTime,
    );
  }

  @override
  void write(BinaryWriter writer, Habit obj) {
    writer
      ..writeByte(14)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.iconName)
      ..writeByte(3)
      ..write(obj.type)
      ..writeByte(4)
      ..write(obj.weekDays)
      ..writeByte(5)
      ..write(obj.startDay)
      ..writeByte(6)
      ..write(obj.endDay)
      ..writeByte(7)
      ..write(obj.targetMinutes)
      ..writeByte(8)
      ..write(obj.maxCount)
      ..writeByte(9)
      ..write(obj.unit)
      ..writeByte(10)
      ..write(obj.clearStartDate)
      ..writeByte(11)
      ..write(obj.dailyProgress)
      ..writeByte(12)
      ..write(obj.createAt)
      ..writeByte(13)
      ..write(obj.streakCount);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class HabitTypeAdapter extends TypeAdapter<HabitType> {
  @override
  final int typeId = 1;

  @override
  HabitType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return HabitType.checkbox;
      case 1:
        return HabitType.count;
      case 2:
        return HabitType.duration;
      case 3:
        return HabitType.avoidance;
      default:
        return HabitType.checkbox;
    }
  }

  @override
  void write(BinaryWriter writer, HabitType obj) {
    switch (obj) {
      case HabitType.checkbox:
        writer.writeByte(0);
        break;
      case HabitType.count:
        writer.writeByte(1);
        break;
      case HabitType.duration:
        writer.writeByte(2);
        break;
      case HabitType.avoidance:
        writer.writeByte(3);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HabitTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
