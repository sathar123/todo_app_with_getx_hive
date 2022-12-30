// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'TaskType.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TaskTypeAdapter extends TypeAdapter<TaskType> {
  @override
  final int typeId = 1;

  @override
  TaskType read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TaskType(
      title: fields[0] as String,
      icon: fields[1] as int,
      select: fields[4] as bool,
      isdonetask: fields[2] as int,
      notdonetask: fields[3] as int,
    )
      ..todo = (fields[5] as List)
          .map((dynamic e) => (e as Map).cast<String, dynamic>())
          .toList()
      ..id = fields[6] as String?;
  }

  @override
  void write(BinaryWriter writer, TaskType obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.title)
      ..writeByte(1)
      ..write(obj.icon)
      ..writeByte(2)
      ..write(obj.isdonetask)
      ..writeByte(3)
      ..write(obj.notdonetask)
      ..writeByte(4)
      ..write(obj.select)
      ..writeByte(5)
      ..write(obj.todo)
      ..writeByte(6)
      ..write(obj.id);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TaskTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
