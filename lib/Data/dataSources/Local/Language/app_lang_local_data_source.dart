import 'package:temwin_front_app/Core/utils/hive_boxes.dart';
import 'package:temwin_front_app/Core/utils/hive_init_helper.dart';

abstract class AppLangLocalDataSource {
  Future<String?> getAppLang();

  Future<void> storeAppLang({required String appLang});
}

class AppLangLocalDataSourceImpl implements AppLangLocalDataSource {
  final HiveHelper hiveHelper;

  const AppLangLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<String?> getAppLang() async {
    try {
      return await hiveHelper.getData<String>(
          boxName: HiveBox.APP_LANG_DATA_BOX);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> storeAppLang({required String appLang}) async {
    return await hiveHelper.storeData<String>(
        object: appLang, boxName: HiveBox.APP_LANG_DATA_BOX);
  }
}
