import 'package:temwin_front_app/Core/utils/hive_boxes.dart';
import 'package:temwin_front_app/Core/utils/hive_init_helper.dart';

abstract class DeviceConnectivityLocalDataSource {
  Future<bool?> getDeviceConnectivity();

  Future<void> storeDeviceConnectivity({required bool data});

  Future<void> clearDeviceConnectivity();
}

class DeviceConnectivityLocalDataSourceImpl
    implements DeviceConnectivityLocalDataSource {
  final HiveHelper hiveHelper;

  const DeviceConnectivityLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<void> clearDeviceConnectivity() async {
    return await hiveHelper.clearBox(boxName: HiveBox.DEVICE_CONNECTIVITY_BOX);
  }

  @override
  Future<bool?> getDeviceConnectivity() async {
    try {
      return await hiveHelper.getData<bool?>(
          boxName: HiveBox.DEVICE_CONNECTIVITY_BOX);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> storeDeviceConnectivity({required bool data}) async {
    return await hiveHelper.storeData<bool?>(
        object: data, boxName: HiveBox.DEVICE_CONNECTIVITY_BOX);
  }
}
