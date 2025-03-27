import 'package:temwin_front_app/Domain/entities/product_entity.dart';

class ProductsModel extends ProductsEntity {
  const ProductsModel(
      {super.id,
      super.code,
      super.title,
      super.titleAr,
      super.fabricationDate,
      super.expirationDate,
      super.quantity,
      super.categoryId,
      super.price,
      super.priceSub,
      super.smallestUnit,
      super.quotaMonth,
      super.quotaDay,
      super.image,
      super.uom,
      super.usedQuota,
      super.qte});

  factory ProductsModel.fromJson(Map<String, dynamic> map) {
    return ProductsModel(
      id: map['id'] as int?,
      code: map['code'] as String?,
      title: map['title'] as String?,
      titleAr: map['title_ar'] as String?,
      quantity: map['category_id'] as num?,
      categoryId: map['phone'] as num?,
      price: map['price'] as num?,
      priceSub: map['price_sub'] as num?,
      smallestUnit: map['smallest_unit'] as num?,
      quotaMonth: map['quota_month'] as num?,
      quotaDay: map['quota_day'] as num?,
      image: map['image'] as String?,
      uom: map['uom'] as String?,
      usedQuota: map['used_quota'] as num?,
      qte: map['qte'] as num?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "code": code,
      "title": title,
      "title_ar": titleAr,
      "quantity": quantity,
      "category_id": categoryId,
      "price": price,
      "price_sub": priceSub,
      "smallest_unit": smallestUnit,
      "quota_month": quotaMonth,
      "quota_day": quotaDay,
      "image": image,
      "uom": uom,
      "used_quota": usedQuota,
      "qte": qte
    };
  }

  factory ProductsModel.fromEntity({required ProductsEntity productEntity}) {
    return ProductsModel(
      id: productEntity.id,
      code: productEntity.code,
      title: productEntity.title,
      titleAr: productEntity.titleAr,
      quantity: productEntity.quantity,
      categoryId: productEntity.categoryId,
      price: productEntity.price,
      priceSub: productEntity.priceSub,
      smallestUnit: productEntity.smallestUnit,
      quotaMonth: productEntity.quotaMonth,
      quotaDay: productEntity.quotaDay,
      image: productEntity.image,
      uom: productEntity.uom,
      usedQuota: productEntity.usedQuota,
      qte: productEntity.qte,
    );
  }
}
