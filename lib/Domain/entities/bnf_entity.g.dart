// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'bnf_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class BnfEntityAdapter extends TypeAdapter<BnfEntity> {
  @override
  final int typeId = 6;

  @override
  BnfEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return BnfEntity(
      id: fields[0] as int?,
      nom: fields[1] as String?,
      prenom: fields[2] as String?,
      nni: fields[3] as String?,
      phone: fields[4] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, BnfEntity obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.nom)
      ..writeByte(2)
      ..write(obj.prenom)
      ..writeByte(3)
      ..write(obj.nni)
      ..writeByte(4)
      ..write(obj.phone);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is BnfEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
