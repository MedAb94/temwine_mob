// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_data_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserDataEntityAdapter extends TypeAdapter<UserDataEntity> {
  @override
  final int typeId = 4;

  @override
  UserDataEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserDataEntity(
      user: fields[0] as UserEntity?,
      accessToken: fields[1] as String?,
      tokenType: fields[2] as String?,
      products: (fields[3] as List?)?.cast<ProductsEntity>(),
    );
  }

  @override
  void write(BinaryWriter writer, UserDataEntity obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.user)
      ..writeByte(1)
      ..write(obj.accessToken)
      ..writeByte(2)
      ..write(obj.tokenType)
      ..writeByte(3)
      ..write(obj.products);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserDataEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
