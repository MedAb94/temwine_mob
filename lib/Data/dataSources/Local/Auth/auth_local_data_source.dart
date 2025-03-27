import 'package:temwin_front_app/Core/utils/hive_boxes.dart';
import 'package:temwin_front_app/Core/utils/hive_init_helper.dart';
import 'package:temwin_front_app/Domain/entities/user_token_entity.dart';

abstract class AuthLocalDataSource {
  Future<UserTokenEntity?> getToken();

  Future<void> storeToken({required UserTokenEntity token});

  Future<void> clearToken([bool removeTokenOnly = false]);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final HiveHelper hiveHelper;

  const AuthLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<void> clearToken([bool removeTokenOnly = false]) async {
    //clear token and also remove all stored data locally
    //await hiveHelper.clearBox(boxName: HiveBox.TOKEN_BOX);
    if (removeTokenOnly) {
      return hiveHelper.clearBox(boxName: HiveBox.TOKEN_BOX);
    } else {
      return hiveHelper.clearAllBoxes();
    }
  }

  @override
  Future<UserTokenEntity?> getToken() async {
    try {
      return await hiveHelper.getData<UserTokenEntity>(
          boxName: HiveBox.TOKEN_BOX);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> storeToken({required UserTokenEntity token}) async {
    return await hiveHelper.storeData<UserTokenEntity>(
        object: token, boxName: HiveBox.TOKEN_BOX);
  }
}
