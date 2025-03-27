// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'items_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ItemsEntityAdapter extends TypeAdapter<ItemsEntity> {
  @override
  final int typeId = 11;

  @override
  ItemsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ItemsEntity(
      id: fields[0] as num?,
      qte: fields[1] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, ItemsEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.qte);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ItemsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
