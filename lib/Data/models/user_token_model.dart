import 'package:temwin_front_app/Domain/entities/user_token_entity.dart';

class UserTokenModel extends UserTokenEntity {
  const UserTokenModel({super.accessToken, super.tokenType});

  factory UserTokenModel.fromJson(Map<String, dynamic> map) {
    return UserTokenModel(
      accessToken: map['access_token'] as String?,
      tokenType: map['token_type'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "access_token": accessToken,
      "token_type": tokenType,
    };
  }

  factory UserTokenModel.fromEntity(
      {required UserTokenEntity userTokenEntity}) {
    return UserTokenModel(
        accessToken: userTokenEntity.accessToken,
        tokenType: userTokenEntity.tokenType);
  }
}
