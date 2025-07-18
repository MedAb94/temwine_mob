import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';
import 'package:temwin_front_app/Domain/entities/user_entity.dart';

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

  const UserDataEntity(
      {this.user, this.accessToken, this.tokenType, this.products});

  UserDataEntity copyWith(
      {UserEntity? user,
      String? accessToken,
      String? tokenType,
      List<ProductsEntity>? products}) {
    return UserDataEntity(
      user: user ?? this.user,
      accessToken: accessToken ?? this.accessToken,
      tokenType: tokenType ?? this.tokenType,
      products: products ?? this.products,
    );
  }

  @override
  List<Object?> get props => [user, accessToken, tokenType, products];
}
