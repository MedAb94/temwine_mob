import 'package:temwin_front_app/Data/models/pos_model.dart';
import 'package:temwin_front_app/Data/models/roles_model.dart';
import 'package:temwin_front_app/Domain/entities/roles_entity.dart';
import 'package:temwin_front_app/Domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {super.id,
      super.name,
      super.email,
      super.phone,
      super.walletNumber,
      super.roles,
      super.pos,
      super.password});

  factory UserModel.fromJson(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      name: map['name'] as String?,
      email: map['email'] as String?,
      phone: map['phone'] as String?,
      walletNumber: map['wallet_number'] as String?,
      roles: map['roles'] != null
          ? List<RolesEntity>.from(
              map['roles'].map((x) => RolesModel.fromJson(x)))
          : null,
      pos: map['pos'] != null ? PosModel.fromJson(map['pos']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "email": email,
      "phone": phone,
      "walletNumber": walletNumber,
      "roles": roles
          ?.map((e) => RolesModel.fromEntity(rolesEntity: e).toJson())
          .toList(),
      'pos': pos != null ? PosModel.fromEntity(posEntity: pos!).toJson() : null,
    };
  }

  Map<String, dynamic> userCredstoJson() {
    return {"email": email, "password": password};
  }

  factory UserModel.fromEntity({required UserEntity userEntity}) {
    return UserModel(
        id: userEntity.id,
        name: userEntity.name,
        walletNumber: userEntity.walletNumber,
        email: userEntity.email,
        phone: userEntity.phone,
        roles: userEntity.roles,
        pos: userEntity.pos,
        password: userEntity.password);
  }
}
