import 'package:dartz/dartz.dart';
import 'package:temwin_front_app/Core/Error/failure.dart';
import 'package:temwin_front_app/Domain/entities/user_data_entity.dart';
import 'package:temwin_front_app/Domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserDataEntity>> signIn(
      {required UserEntity userCreds});

  Future<Either<Failure, void>> signOut([bool removeTokenOnly = false]);

  Future<Either<Failure, UserDataEntity>> authInit();
}
