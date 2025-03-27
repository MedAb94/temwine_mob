//Future<void> executePostOfflineTask({required OfflineTaskEntity task});

import 'package:dartz/dartz.dart';
import 'package:temwin_front_app/Core/Error/failure.dart';
import 'package:temwin_front_app/Domain/entities/offline_task_entity.dart';

abstract class OfflineTaskRepository {
  Future<Either<Failure, Map<String, dynamic>>> executePostOfflineTask(
      {required OfflineTaskEntity task});

  Future<Either<Failure, void>> storeOfflineTask(
      {required OfflineTaskEntity task});

  Future<Either<Failure, void>> deleteOfflineTask(
      {required OfflineTaskEntity task});

  Future<Either<Failure, void>> updateOfflineTask(
      {required String id, required OfflineTaskEntity task});

  Future<Either<Failure, List<OfflineTaskEntity>>> getOfflineTasks();
}
