// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pos_bnf_data_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PosBnfDataEntityAdapter extends TypeAdapter<PosBnfDataEntity> {
  @override
  final int typeId = 7;

  @override
  PosBnfDataEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PosBnfDataEntity(
      status: fields[0] as int?,
      bnf: fields[1] as BnfEntity?,
      products: (fields[2] as List?)?.cast<ProductsEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, PosBnfDataEntity obj) {
    writer
      ..writeByte(3)
      ..writeByte(0)
      ..write(obj.status)
      ..writeByte(1)
      ..write(obj.bnf)
      ..writeByte(2)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PosBnfDataEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
