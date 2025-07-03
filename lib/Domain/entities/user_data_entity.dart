import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';
import 'package:temwin_front_app/Domain/entities/user_entity.dart';
import 'package:temwin_front_app/Domain/entities/bnf_entity.dart';

part 'user_data_entity.g.dart';

@HiveType(typeId: 4)
class UserDataEntity extends Equatable {
  @HiveField(0)
  final UserEntity? user;
  @HiveField(1)
  final String? accessToken;
  @HiveField(2)
  final String? tokenType;
  @HiveField(3)
  final List<ProductsEntity>? products;
  @HiveField(4)
  final List<BnfEntity>? beneficiaires;

  const UserDataEntity(
      {this.user,
      this.accessToken,
      this.tokenType,
      this.products,
      this.beneficiaires});

  UserDataEntity copyWith(
      {UserEntity? user,
      String? accessToken,
      String? tokenType,
      List<ProductsEntity>? products,
      List<BnfEntity>? beneficiaires}) {
    return UserDataEntity(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      products: products ?? this.products,
      beneficiaires: beneficiaires ?? this.beneficiaires,
    );
  }

  @override
  List<Object?> get props => [user, accessToken, tokenType, products, beneficiaires];
}
