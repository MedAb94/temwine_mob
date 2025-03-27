import 'package:hive/hive.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';

part 'pos_sales_lines_entity.g.dart';

@HiveType(typeId: 8)
class PosSalesLinesEntity {
  @HiveField(0)
  final num? id;
  @HiveField(1)
  final num? saleId;
  @HiveField(2)
  final num? productId;
  @HiveField(3)
  final num? productQnty;
  @HiveField(4)
  final num? productPrice;
  @HiveField(5)
  final String? productPriceSub;
  @HiveField(6)
  final num? userId;
  @HiveField(7)
  final num? total;
  @HiveField(8)
  final ProductsEntity? product;

  PosSalesLinesEntity(
      {this.id,
      this.saleId,
      this.productId,
      this.productQnty,
      this.productPrice,
      this.productPriceSub,
      this.userId,
      this.total,
      this.product});
}
