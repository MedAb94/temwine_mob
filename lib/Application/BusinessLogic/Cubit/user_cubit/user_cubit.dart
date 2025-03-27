import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temwin_front_app/Data/dataSources/Local/User/user_local_data_source.dart';
import 'package:temwin_front_app/Domain/entities/user_data_entity.dart';

class UserCubit extends Cubit<UserDataEntity?> {
  final UserLocalDataSource userLocalDataSource;

  //  final UserProfileBloc userProfileBloc;

  // StreamSubscription<UserProfileState> userProfileBlocStreamSub;

  UserCubit({required this.userLocalDataSource}) : super(null);

  void getUser() async {
    UserDataEntity? userData = await userLocalDataSource.getUser();

    debugPrint('UserCubit userEntity : $userData');

    emit(userData);
  }

  void setUser({required UserDataEntity user}) async {
    await userLocalDataSource.storeUser(userEntity: user);

    emit(user);
  }

  void updateUserProductsUsedQuota(
      {required Map<int, num> storedSalesItems}) async {
    UserDataEntity? newUser = await userLocalDataSource
        .updateUserProductsUsedQuota(storedSalesItems: storedSalesItems);

    emit(newUser);
  }
}
