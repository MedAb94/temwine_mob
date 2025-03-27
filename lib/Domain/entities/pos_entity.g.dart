// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pos_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PosEntityAdapter extends TypeAdapter<PosEntity> {
  @override
  final int typeId = 1;

  @override
  PosEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PosEntity(
      id: fields[0] as int?,
      name: fields[1] as String?,
      responsileId: fields[2] as int?,
      vendeurId: fields[3] as int?,
      wilayaId: fields[4] as String?,
      moughataaId: fields[5] as String?,
      communeId: fields[6] as String?,
      localiteId: fields[7] as String?,
      type: fields[8] as int?,
      isActive: fields[9] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, PosEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.responsileId)
      ..writeByte(3)
      ..write(obj.vendeurId)
      ..writeByte(4)
      ..write(obj.wilayaId)
      ..writeByte(5)
      ..write(obj.moughataaId)
      ..writeByte(6)
      ..write(obj.communeId)
      ..writeByte(7)
      ..write(obj.localiteId)
      ..writeByte(8)
      ..write(obj.type)
      ..writeByte(9)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PosEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
