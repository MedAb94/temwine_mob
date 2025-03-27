import 'package:temwin_front_app/Data/models/pos_model.dart';
import 'package:temwin_front_app/Data/models/product_model.dart';
import 'package:temwin_front_app/Data/models/roles_model.dart';
import 'package:temwin_front_app/Data/models/user_model.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';
import 'package:temwin_front_app/Domain/entities/roles_entity.dart';
import 'package:temwin_front_app/Domain/entities/user_data_entity.dart';
import 'package:temwin_front_app/Domain/entities/user_entity.dart';

class UserDataModel extends UserDataEntity {
  const UserDataModel(
      {super.user, super.accessToken, super.tokenType, super.products});

  factory UserDataModel.fromJson(Map<String, dynamic> map) {
    return UserDataModel(
      accessToken: map['access_token'] as String?,
      tokenType: map['token_type'] as String?,
      user: map['user'] != null ? UserModel.fromJson(map['user']) : null,
      products: map['products'] != null
          ? List<ProductsEntity>.from(
              map['products'].map((x) => ProductsModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "access_token": accessToken,
      "token_type": tokenType,
      'user': user != null
          ? UserModel.fromEntity(userEntity: user!).toJson()
          : null,
      "products": products
          ?.map((e) => ProductsModel.fromEntity(productEntity: e).toJson())
          .toList(),
    };
  }

  factory UserDataModel.fromEntity({required UserDataEntity userDataEntity}) {
    return UserDataModel(
        accessToken: userDataEntity.accessToken,
        tokenType: userDataEntity.tokenType,
        user: userDataEntity.user,
        products: userDataEntity.products);
  }
}
