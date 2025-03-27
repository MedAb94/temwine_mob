// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pos_sales_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PosSalesEntityAdapter extends TypeAdapter<PosSalesEntity> {
  @override
  final int typeId = 9;

  @override
  PosSalesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PosSalesEntity(
      id: fields[0] as num?,
      code: fields[1] as String?,
      posId: fields[2] as num?,
      userId: fields[3] as num?,
      beneficiareId: fields[4] as num?,
      total: fields[5] as num?,
      totalSub: fields[6] as num?,
      beneficaire: fields[7] as BnfEntity?,
      lines: (fields[8] as List?)?.cast<PosSalesLinesEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, PosSalesEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.posId)
      ..writeByte(3)
      ..write(obj.userId)
      ..writeByte(4)
      ..write(obj.beneficiareId)
      ..writeByte(5)
      ..write(obj.total)
      ..writeByte(6)
      ..write(obj.totalSub)
      ..writeByte(7)
      ..write(obj.beneficaire)
      ..writeByte(8)
      ..write(obj.lines);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PosSalesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
