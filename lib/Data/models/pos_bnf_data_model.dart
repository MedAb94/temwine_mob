import 'package:temwin_front_app/Data/models/bnf_model.dart';
import 'package:temwin_front_app/Data/models/product_model.dart';
import 'package:temwin_front_app/Domain/entities/pos_bnf_data_entity.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';

class PosBnfDataModel extends PosBnfDataEntity {
  const PosBnfDataModel({
    super.status,
    super.bnf,
    super.products,
  });

  factory PosBnfDataModel.fromJson(Map<String, dynamic> map) {
    return PosBnfDataModel(
        status: map['status'] as int?,
        products: map['products'] != null
            ? List<ProductsEntity>.from(
                map['products'].map((x) => ProductsModel.fromJson(x)))
            : null,
        bnf: map['bn'] != null ? BnfModel.fromJson(map['bn']) : null);
  }

  Map<String, dynamic> toJson() {
    return {
      "status": status,
      "products": products
          ?.map((e) => ProductsModel.fromEntity(productEntity: e).toJson())
          .toList(),
      'bn': bnf != null ? BnfModel.fromEntity(bnfEntity: bnf!).toJson() : null,
    };
  }

  // Map<String, dynamic> toJson() {
  //   return {
  //     "id": id,
  //     "name": name,
  //     "email": email,
  //     "phone": phone,
  //     "walletNumber": walletNumber,
  //     "roles": roles
  //         ?.map((e) => RolesModel.fromEntity(rolesEntity: e).toJson())
  //         .toList(),
  //     'pos': pos != null ? PosModel.fromEntity(posEntity: pos!).toJson() : null,
  //   };
  // }

  factory PosBnfDataModel.fromEntity(
      {required PosBnfDataEntity posBnfDataEntity}) {
    return PosBnfDataModel(
      status: posBnfDataEntity.status,
      products: posBnfDataEntity.products,
      bnf: posBnfDataEntity.bnf,
    );
  }
}
