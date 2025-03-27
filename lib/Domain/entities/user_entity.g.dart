// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserEntityAdapter extends TypeAdapter<UserEntity> {
  @override
  final int typeId = 3;

  @override
  UserEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserEntity(
      id: fields[0] as int?,
      name: fields[1] as String?,
      email: fields[2] as String?,
      createdAt: fields[3] as String?,
      updatedAt: fields[4] as String?,
      phone: fields[5] as String?,
      walletNumber: fields[6] as String?,
      roles: (fields[7] as List?)?.cast<RolesEntity>(),
      pos: fields[8] as PosEntity?,
      password: fields[9] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserEntity obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.email)
      ..writeByte(3)
      ..write(obj.createdAt)
      ..writeByte(4)
      ..write(obj.updatedAt)
      ..writeByte(5)
      ..write(obj.phone)
      ..writeByte(6)
      ..write(obj.walletNumber)
      ..writeByte(7)
      ..write(obj.roles)
      ..writeByte(8)
      ..write(obj.pos)
      ..writeByte(9)
      ..write(obj.password);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
