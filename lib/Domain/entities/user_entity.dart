import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:temwin_front_app/Domain/entities/pos_entity.dart';
import 'package:temwin_front_app/Domain/entities/roles_entity.dart';

part 'user_entity.g.dart';

@HiveType(typeId: 3)
class UserEntity extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? email;
  @HiveField(3)
  final String? createdAt;
  @HiveField(4)
  final String? updatedAt;
  @HiveField(5)
  final String? phone;
  @HiveField(6)
  final String? walletNumber;
  @HiveField(7)
  final List<RolesEntity>? roles;
  @HiveField(8)
  final PosEntity? pos;
  @HiveField(9)
  final String? password;

  const UserEntity(
      {this.id,
      this.name,
      this.email,
      this.createdAt,
      this.updatedAt,
      this.phone,
      this.walletNumber,
      this.roles,
      this.pos,
      this.password});

  @override
  List<Object?> get props => [
        id,
        name,
        email,
        createdAt,
        updatedAt,
        phone,
        walletNumber,
        roles,
        pos,
        password
      ];
}
