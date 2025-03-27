import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'user_token_entity.g.dart';

@HiveType(typeId: 0)
class UserTokenEntity extends Equatable {
  @HiveField(0)
  final String? accessToken;
  @HiveField(1)
  final String? tokenType;

  const UserTokenEntity({this.accessToken, this.tokenType});

  @override
  List<Object?> get props => [accessToken, tokenType];

  @override
  String toString() {
    return 'access: $accessToken , tokenType : $tokenType';
  }

  @override
  bool get stringify => true;
}
