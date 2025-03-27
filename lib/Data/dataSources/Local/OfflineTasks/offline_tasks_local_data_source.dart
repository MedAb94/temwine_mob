import 'package:temwin_front_app/Core/utils/hive_boxes.dart';
import 'package:temwin_front_app/Core/utils/hive_init_helper.dart';
import 'package:temwin_front_app/Domain/entities/offline_task_entity.dart';

abstract class OfflineTasksLocalDataSource {
  Future<List<OfflineTaskEntity>?> getOfflineTasks();

  Future<void> storeOfflineTask({required OfflineTaskEntity data});

  Future<void> removeOfflineTask({required OfflineTaskEntity data});

  Future<void> updateOfflineTask(
      {required String id, required OfflineTaskEntity data});

  Future<void> clearOfflineTasks();
}

class OfflineTasksLocalDataSourceImpl implements OfflineTasksLocalDataSource {
  final HiveHelper hiveHelper;

  const OfflineTasksLocalDataSourceImpl({required this.hiveHelper});

  @override
  Future<void> clearOfflineTasks() async {
    return await hiveHelper.clearBox(boxName: HiveBox.OFFLINE_TASKS_BOX);
  }

  @override
  Future<List<OfflineTaskEntity>?> getOfflineTasks() async {
    try {
      return await hiveHelper.getListData<OfflineTaskEntity>(
          boxName: HiveBox.OFFLINE_TASKS_BOX);
    } catch (e) {
      //print("getOfflineTasks error :$e");
      return null;
    }
  }

  @override
  Future<void> storeOfflineTask({required OfflineTaskEntity data}) async {
    List<OfflineTaskEntity>? offlinetasks = await getOfflineTasks();
    if (offlinetasks != null) {
      //print("storeOfflineTask here 1");
      offlinetasks.add(data);
    } else {
      //print("storeOfflineTask here 2");
      offlinetasks = [data];
    }

    //print("storeOfflineTask data : $data");

    //print("storeOfflineTask lenght: ${offlinetasks.length}");

    await hiveHelper.storeData<List<OfflineTaskEntity>>(
        object: offlinetasks!, boxName: HiveBox.OFFLINE_TASKS_BOX);

    // List<OfflineTaskEntity> offlinetasks2 = await getOfflineTasks() ?? [];

    //print("offlinetasks2 lenght : ${offlinetasks2.length}");
  }

  @override
  Future<void> removeOfflineTask({required OfflineTaskEntity data}) async {
    List<OfflineTaskEntity> offlinetasks = await getOfflineTasks() ?? [];

    if (offlinetasks.isNotEmpty) {
      offlinetasks.removeWhere((element) => element.id == data.id);
    }

    await hiveHelper.storeData<List<OfflineTaskEntity>?>(
        object: offlinetasks, boxName: HiveBox.OFFLINE_TASKS_BOX);
  }

  @override
  Future<void> updateOfflineTask(
      {required String id, required OfflineTaskEntity data}) async {
    List<OfflineTaskEntity> offlinetasks = await getOfflineTasks() ?? [];

    if (offlinetasks.isNotEmpty) {
      offlinetasks.removeWhere((element) => element.id == data.id);
    }

    offlinetasks.add(data);

    await hiveHelper.storeData<List<OfflineTaskEntity>?>(
        object: offlinetasks, boxName: HiveBox.OFFLINE_TASKS_BOX);
  }
}
