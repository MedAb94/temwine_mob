// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_token_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserTokenEntityAdapter extends TypeAdapter<UserTokenEntity> {
  @override
  final int typeId = 0;

  @override
  UserTokenEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserTokenEntity(
      accessToken: fields[0] as String?,
      tokenType: fields[1] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, UserTokenEntity obj) {
    writer
      ..writeByte(2)
      ..writeByte(0)
      ..write(obj.accessToken)
      ..writeByte(1)
      ..write(obj.tokenType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserTokenEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
