import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'product_entity.g.dart';

@HiveType(typeId: 5)
class ProductsEntity extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? code;
  @HiveField(2)
  final String? title;
  @HiveField(3)
  final String? titleAr;
  @HiveField(4)
  final String? fabricationDate;
  @HiveField(5)
  final String? expirationDate;
  @HiveField(6)
  final num? quantity;
  @HiveField(7)
  final num? categoryId;
  @HiveField(8)
  final num? price;
  @HiveField(9)
  final num? priceSub;
  @HiveField(10)
  final num? smallestUnit;
  @HiveField(11)
  final num? quotaMonth;
  @HiveField(12)
  final num? quotaDay;
  @HiveField(13)
  final String? image;
  @HiveField(14)
  final String? uom;
  @HiveField(15)
  final num? usedQuota;
  @HiveField(16)
  final num? qte;

  const ProductsEntity(
      {this.id,
      this.code,
      this.title,
      this.titleAr,
      this.fabricationDate,
      this.expirationDate,
      this.quantity,
      this.categoryId,
      this.price,
      this.priceSub,
      this.smallestUnit,
      this.quotaMonth,
      this.quotaDay,
      this.image,
      this.uom,
      this.usedQuota,
      this.qte});

  ProductsEntity copyWith({
    int? id,
    String? code,
    String? title,
    String? titleAr,
    String? fabricationDate,
    String? expirationDate,
    num? quantity,
    num? categoryId,
    num? price,
    num? priceSub,
    num? smallestUnit,
    num? quotaMonth,
    num? quotaDay,
    String? image,
    String? uom,
    num? usedQuota,
    num? qte,
  }) {
    return ProductsEntity(
      id: id ?? this.id,
      code: code ?? this.code,
      title: title ?? this.title,
      titleAr: titleAr ?? this.titleAr,
      fabricationDate: fabricationDate ?? this.fabricationDate,
      expirationDate: expirationDate ?? this.expirationDate,
      quantity: quantity ?? this.quantity,
      categoryId: categoryId ?? this.categoryId,
      price: price ?? this.price,
      priceSub: priceSub ?? this.priceSub,
      smallestUnit: smallestUnit ?? this.smallestUnit,
      quotaMonth: quotaMonth ?? this.quotaMonth,
      quotaDay: quotaDay ?? this.quotaDay,
      image: image ?? this.image,
      uom: uom ?? this.uom,
      usedQuota: usedQuota ?? this.usedQuota,
      qte: qte ?? this.qte,
    );
  }

  @override
  List<Object?> get props => [
        id,
        code,
        title,
        titleAr,
        fabricationDate,
        expirationDate,
        quantity,
        categoryId,
        price,
        priceSub,
        smallestUnit,
        quotaMonth,
        quotaDay,
        image,
        uom,
        usedQuota,
        qte
      ];

  // Products.fromJson(Map<String, dynamic> json) {
  //   id = json['id'];
  //   code = json['code'];
  //   name = json['name'];
  //   title = json['title'];
  //   titleAr = json['title_ar'];
  //   fabricationDate = json['fabrication_date'];
  //   expirationDate = json['expiration_date'];
  //   quantity = json['quantity'];
  //   categoryId = json['category_id'];
  //   price = json['price'];
  //   priceSub = json['price_sub'];
  //   smallestUnit = json['smallest_unit'];
  //   quotaMonth = json['quota_month'];
  //   quotaDay = json['quota_day'];
  //   amount = json['amount'];
  //   img = json['img'];
  //   image = json['image'];
  //   createdAt = json['created_at'];
  //   updatedAt = json['updated_at'];
  //   deletedAt = json['deleted_at'];
  //   uom = json['uom'];
  //   usedQuota = json['used_quota'];
  //   qte = json['qte'];
  // }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['id'] = this.id;
  //   data['code'] = this.code;
  //   data['name'] = this.name;
  //   data['title'] = this.title;
  //   data['title_ar'] = this.titleAr;
  //   data['fabrication_date'] = this.fabricationDate;
  //   data['expiration_date'] = this.expirationDate;
  //   data['quantity'] = this.quantity;
  //   data['category_id'] = this.categoryId;
  //   data['price'] = this.price;
  //   data['price_sub'] = this.priceSub;
  //   data['smallest_unit'] = this.smallestUnit;
  //   data['quota_month'] = this.quotaMonth;
  //   data['quota_day'] = this.quotaDay;
  //   data['amount'] = this.amount;
  //   data['img'] = this.img;
  //   data['image'] = this.image;
  //   data['created_at'] = this.createdAt;
  //   data['updated_at'] = this.updatedAt;
  //   data['deleted_at'] = this.deletedAt;
  //   data['uom'] = this.uom;
  //   data['used_quota'] = this.usedQuota;
  //   data['qte'] = this.qte;
  //   return data;
  // }
}
