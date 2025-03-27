// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pos_sales_lines_entity.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class PosSalesLinesEntityAdapter extends TypeAdapter<PosSalesLinesEntity> {
  @override
  final int typeId = 8;

  @override
  PosSalesLinesEntity read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return PosSalesLinesEntity(
      id: fields[0] as num?,
      saleId: fields[1] as num?,
      productId: fields[2] as num?,
      productQnty: fields[3] as num?,
      productPrice: fields[4] as num?,
      productPriceSub: fields[5] as String?,
      userId: fields[6] as num?,
      total: fields[7] as num?,
      product: fields[8] as ProductsEntity?,
    );
  }

  @override
  void write(BinaryWriter writer, PosSalesLinesEntity obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.saleId)
      ..writeByte(2)
      ..write(obj.productId)
      ..writeByte(3)
      ..write(obj.productQnty)
      ..writeByte(4)
      ..write(obj.productPrice)
      ..writeByte(5)
      ..write(obj.productPriceSub)
      ..writeByte(6)
      ..write(obj.userId)
      ..writeByte(7)
      ..write(obj.total)
      ..writeByte(8)
      ..write(obj.product);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PosSalesLinesEntityAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
