// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offline_task_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class OfflineTaskEntityAdapter extends TypeAdapter<OfflineTaskEntity> {
  @override
  final int typeId = 10;

  @override
  OfflineTaskEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return OfflineTaskEntity(
      type: fields[0] as String,
      body: fields[1] as String?,
      url: fields[2] as String?,
      subTasks: (fields[3] as List?)?.cast<OfflineTaskEntity>(),
      queryParams: (fields[5] as Map?)?.cast<String, dynamic>(),
      id: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, OfflineTaskEntity obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.type)
      ..writeByte(1)
      ..write(obj.body)
      ..writeByte(2)
      ..write(obj.url)
      ..writeByte(3)
      ..write(obj.subTasks)
      ..writeByte(4)
      ..write(obj.id)
      ..writeByte(5)
      ..write(obj.queryParams);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is OfflineTaskEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
