// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductsEntityAdapter extends TypeAdapter<ProductsEntity> {
  @override
  final int typeId = 5;

  @override
  ProductsEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ProductsEntity(
      id: fields[0] as int?,
      code: fields[1] as String?,
      title: fields[2] as String?,
      titleAr: fields[3] as String?,
      fabricationDate: fields[4] as String?,
      expirationDate: fields[5] as String?,
      quantity: fields[6] as num?,
      categoryId: fields[7] as num?,
      price: fields[8] as num?,
      priceSub: fields[9] as num?,
      smallestUnit: fields[10] as num?,
      quotaMonth: fields[11] as num?,
      quotaDay: fields[12] as num?,
      image: fields[13] as String?,
      uom: fields[14] as String?,
      usedQuota: fields[15] as num?,
      qte: fields[16] as num?,
    );
  }

  @override
  void write(BinaryWriter writer, ProductsEntity obj) {
    writer
      ..writeByte(17)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.code)
      ..writeByte(2)
      ..write(obj.title)
      ..writeByte(3)
      ..write(obj.titleAr)
      ..writeByte(4)
      ..write(obj.fabricationDate)
      ..writeByte(5)
      ..write(obj.expirationDate)
      ..writeByte(6)
      ..write(obj.quantity)
      ..writeByte(7)
      ..write(obj.categoryId)
      ..writeByte(8)
      ..write(obj.price)
      ..writeByte(9)
      ..write(obj.priceSub)
      ..writeByte(10)
      ..write(obj.smallestUnit)
      ..writeByte(11)
      ..write(obj.quotaMonth)
      ..writeByte(12)
      ..write(obj.quotaDay)
      ..writeByte(13)
      ..write(obj.image)
      ..writeByte(14)
      ..write(obj.uom)
      ..writeByte(15)
      ..write(obj.usedQuota)
      ..writeByte(16)
      ..write(obj.qte);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductsEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
