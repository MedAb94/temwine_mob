import 'package:temwin_front_app/Core/utils/hive_boxes.dart';
import 'package:temwin_front_app/Core/utils/hive_init_helper.dart';
import 'package:temwin_front_app/Domain/entities/offline_entities/sales_entity.dart';

abstract class OfflineSalessLocalDataSource {
  Future<List<SalesEntity>?> getOfflineSaless();

  Future<void> storeOfflineSales({required SalesEntity data});

  // Future<void> removeOfflineSales({required SalesEntity data});

  // Future<void> updateOfflineSales(
  //     {required String id, required SalesEntity data});

  Future<void> clearOfflineSaless();
}

class OfflineSalessLocalDataSourceImpl implements OfflineSalessLocalDataSource {
  final HiveHelper hiveHelper;

  const OfflineSalessLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<void> clearOfflineSaless() async {
    return await hiveHelper.clearBox(boxName: HiveBox.OFFLINE_TASKS_BOX);
  }

  @override
  Future<List<SalesEntity>?> getOfflineSaless() async {
    try {
      return await hiveHelper.getListData<SalesEntity>(
          boxName: HiveBox.OFFLINE_TASKS_BOX);
    } catch (e) {
      //print("getOfflineSaless error :$e");
      return null;
    }
  }

  @override
  Future<void> storeOfflineSales({required SalesEntity data}) async {
    List<SalesEntity>? offlinetasks = await getOfflineSaless();
    if (offlinetasks != null) {
      //print("storeOfflineSales here 1");
      offlinetasks.add(data);
    } else {
      //print("storeOfflineSales here 2");
      offlinetasks = [data];
    }

    //print("storeOfflineSales data : $data");

    //print("storeOfflineSales lenght: ${offlinetasks.length}");

    await hiveHelper.storeData<List<SalesEntity>>(
        object: offlinetasks!, boxName: HiveBox.OFFLINE_TASKS_BOX);

    // List<SalesEntity> offlinetasks2 = await getOfflineSaless() ?? [];

    //print("offlinetasks2 lenght : ${offlinetasks2.length}");
  }

  // @override
  // Future<void> removeOfflineSales({required SalesEntity data}) async {
  //   List<SalesEntity> offlinetasks = await getOfflineSaless() ?? [];

  //   if (offlinetasks.isNotEmpty) {
  //     offlinetasks.removeWhere((element) => element.id == data.id);
  //   }

  //   await hiveHelper.storeData<List<SalesEntity>?>(
  //       object: offlinetasks, boxName: HiveBox.OFFLINE_TASKS_BOX);
  // }

  // @override
  // Future<void> updateOfflineSales(
  //     {required String id, required SalesEntity data}) async {
  //   List<SalesEntity> offlinetasks = await getOfflineSaless() ?? [];

  //   if (offlinetasks.isNotEmpty) {
  //     offlinetasks.removeWhere((element) => element.id == data.id);
  //   }

  //   offlinetasks.add(data);

  //   await hiveHelper.storeData<List<SalesEntity>?>(
  //       object: offlinetasks, boxName: HiveBox.OFFLINE_TASKS_BOX);
  // }
}
