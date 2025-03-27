import 'package:dartz/dartz.dart';
import 'package:flutter/foundation.dart';
import 'package:temwin_front_app/Core/Error/failure.dart';
import 'package:temwin_front_app/Data/dataSources/Local/Auth/auth_local_data_source.dart';
import 'package:temwin_front_app/Data/dataSources/Local/User/user_local_data_source.dart';
import 'package:temwin_front_app/Data/dataSources/Remote/Auth/auth_remote_data_source.dart';

import 'package:temwin_front_app/Data/models/user_model.dart';
import 'package:temwin_front_app/Domain/entities/user_data_entity.dart';
import 'package:temwin_front_app/Domain/entities/user_entity.dart';
import 'package:temwin_front_app/Domain/entities/user_token_entity.dart';
import 'package:temwin_front_app/Domain/repo/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource authRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;
  final UserLocalDataSource userLocalDataSource;

  AuthRepositoryImpl(
      {required this.authRemoteDataSource,
      required this.authLocalDataSource,
      required this.userLocalDataSource});

  @override
  Future<Either<Failure, UserDataEntity>> signIn(
      {required UserEntity userCreds}) async {
    try {
      UserDataEntity user = await authRemoteDataSource.signIn(
          user: UserModel.fromEntity(userEntity: userCreds));

      // store user
      await userLocalDataSource.storeUser(userEntity: user);

      // store token

      await authLocalDataSource.storeToken(
          token: UserTokenEntity(
              accessToken: user.accessToken, tokenType: user.tokenType));

      return Right(user);
    } catch (e) {
      if (kDebugMode) {
        print("signIn error : $e");
      }
      //return Left(Failure(message: e.toString()));
      return Left(Failure(message: (e as Failure).message));
    }
  }

  @override
  Future<Either<Failure, void>> signOut([bool removeTokenOnly = false]) async {
    try {
      await authRemoteDataSource.signOut();
      await authLocalDataSource.clearToken(removeTokenOnly);
      return const Right(null);
    } catch (e) {
      return Left(Failure(message: (e as Failure).message));
    }
  }

  @override
  Future<Either<Failure, UserDataEntity>> authInit() async {
    UserDataEntity? user = await userLocalDataSource.getUser();
    if (user != null && user.accessToken != null) {
      return Right(user);
    } else {
      return Left(Failure(message: "User is unAuthenticated"));
    }
  }
}
