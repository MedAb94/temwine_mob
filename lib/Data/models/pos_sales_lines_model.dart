import 'package:temwin_front_app/Data/models/product_model.dart';
import 'package:temwin_front_app/Domain/entities/pos_sales_lines_entity.dart';

class PosSalesLinesModel extends PosSalesLinesEntity {
  PosSalesLinesModel(
      {super.id,
      super.saleId,
      super.productId,
      super.productQnty,
      super.productPrice,
      super.productPriceSub,
      super.userId,
      super.total,
      super.product});

  factory PosSalesLinesModel.fromJson(Map<String, dynamic> map) {
    return PosSalesLinesModel(
      id: map['id'] as num?,
      saleId: map['sale_id'] as num?,
      productId: map['product_id'] as num?,
      userId: map['user_id'] as num?,
      productQnty: map['product_qnty'] as num?,
      total: map['total'] as num?,
      productPrice: map['product_price'] as num?,
      product: map['product'] != null
          ? ProductsModel.fromJson(map['product'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "sale_id": saleId,
      "product_id": productId,
      "user_id": userId,
      "product_qnty": productQnty,
      "total": total,
      "product_price": productPrice,
      "product": product,
    };
  }

  factory PosSalesLinesModel.fromEntity(
      {required PosSalesLinesEntity posSalesLinesEntity}) {
    return PosSalesLinesModel(
      id: posSalesLinesEntity.id,
      saleId: posSalesLinesEntity.saleId,
      productId: posSalesLinesEntity.productId,
      userId: posSalesLinesEntity.userId,
      productQnty: posSalesLinesEntity.productQnty,
      total: posSalesLinesEntity.total,
      productPrice: posSalesLinesEntity.productPrice,
      product: posSalesLinesEntity.product,
    );
  }
}
