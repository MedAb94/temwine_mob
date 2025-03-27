// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sales_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalesEntityAdapter extends TypeAdapter<SalesEntity> {
  @override
  final int typeId = 12;

  @override
  SalesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalesEntity(
      date: fields[0] as String?,
      nni: fields[1] as String?,
      benefFirstName: fields[2] as String?,
      benefLastName: fields[3] as String?,
      items: (fields[4] as List?)?.cast<ItemsEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, SalesEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.date)
      ..writeByte(1)
      ..write(obj.nni)
      ..writeByte(2)
      ..write(obj.benefFirstName)
      ..writeByte(3)
      ..write(obj.benefLastName)
      ..writeByte(4)
      ..write(obj.items);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
