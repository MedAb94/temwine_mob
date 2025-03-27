import 'package:dartz/dartz.dart';
import 'package:temwin_front_app/Core/Error/failure.dart';
import 'package:temwin_front_app/Domain/entities/user_data_entity.dart';
import 'package:temwin_front_app/Domain/entities/user_entity.dart';
import 'package:temwin_front_app/Domain/repo/auth_repository.dart';

class AuthUsecases {
  final AuthRepository authRepository;

  AuthUsecases({required this.authRepository});

  Future<Either<Failure, UserDataEntity>> authInit() =>
      authRepository.authInit();

  Future<Either<Failure, UserDataEntity>> signIn(
          {required UserEntity userCreds}) =>
      authRepository.signIn(userCreds: userCreds);

  Future<Either<Failure, void>> signOut([bool removeTokenOnly = false]) =>
      authRepository.signOut(removeTokenOnly);
}
