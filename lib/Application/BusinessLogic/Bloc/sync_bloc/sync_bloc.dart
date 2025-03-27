import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temwin_front_app/Data/dataSources/Local/OfflineSales/offline_sales_local_data_source.dart';
import 'package:temwin_front_app/Domain/UseCases/Vendor/vendor_usecases.dart';
import 'package:temwin_front_app/Domain/entities/offline_entities/sales_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_entity.dart';

part 'sync_event.dart';
part 'sync_state.dart';

class SyncBloc extends Bloc<SyncEvent, SyncState> {
  final OfflineSalessLocalDataSource offlineSalessLocalDataSource;
  final VendorUsecases vendorUsecases;
  SyncBloc(
      {required this.offlineSalessLocalDataSource,
      required this.vendorUsecases})
      : super(SyncInitial()) {
    on<SyncOfflineData>(_onSyncOfflineData);
  }

  void _onSyncOfflineData(
      SyncOfflineData event, Emitter<SyncState> emit) async {
    emit(SyncOfflineDataLoading());

    List<SalesEntity>? sales =
        await offlineSalessLocalDataSource.getOfflineSaless();

    if (sales != null && sales.isNotEmpty) {
      final result = await vendorUsecases.syncOfflineSales(
          posEntity: event.posEntity, sales: sales);

      result.fold((l) {
        debugPrint('auth error : ${l.message}');
        emit(SyncOfflineDataFailure(errorMessage: l.message));
      }, (r) async {
        emit(SyncOfflineDataSuccess());
        await offlineSalessLocalDataSource.clearOfflineSaless();
      });
    } else {
      emit(SyncOfflineDataFailure(errorMessage: "No data to sync"));
    }
  }

  // void _onSyncOfflineData(
  //     SyncOfflineData event, Emitter<SyncState> emit) async {
  //   emit(SyncOfflineDataLoading());

  //   debugPrint("SyncOfflineData  : ${event.items}  ");

  //   // final result = await vendorUsecases.getPosSales(
  //   //     date1: event.date1, date2: event.date2);

  //   // result.fold((l) {
  //   //   debugPrint('_onSyncOfflineData error : ${l.message}');
  //   //   emit(GetPosSalesHistoryFailure(errorMessage: l.message));
  //   // }, (r) {
  //   //   //emit state

  //   //   emit(SyncOfflineDataSuccess(data: r));
  //   // });

  //   final data1 = await offlineTaskUsecases.getOfflineTasks();
  //   data1.fold((l) => null, (r) async {
  //     if (kDebugMode) {
  //       print(
  //           "checkAndExecuteOfflineTasks offline here before offlineTasks size: ${r.length}");
  //     }
  //     List<OfflineTaskEntity> offlineTasks = r;
  //     if (offlineTasks.isNotEmpty) {
  //       for (var task in offlineTasks) {
  //         if (task.type == OfflineTaskType.sync.name) {
  //           final data2 =
  //               await offlineTaskUsecases.executePostOfflineTask(task: task);
  //           // await data2.fold((l) => null, (r) async {
  //           //   if (r != null) {
  //           //     //delete the task
  //           //     //Delete all the offline tasks after execution
  //           //     final data3 =
  //           //         await offlineTaskUsecases.deleteOfflineTask(task: task);

  //           //     await data3.fold((l) {
  //           //       //print("checkAndExecuteOfflineTasks error : $l");
  //           //     }, (r) async {
  //           //       final data4 = await offlineTaskUsecases.getOfflineTasks();

  //           //       data4.fold((l) => null, (r) {
  //           //         //print(
  //           //         // "checkAndExecuteOfflineTasks offline here after offlineTasks size: ${r.length}");
  //           //       });

  //           //       //print(
  //           //       //"checkAndExecuteOfflineTasks : ${task.type} in background done successfully");
  //           //     });
  //           //   }
  //           // });
  //         }

  //         //Delete all the offline tasks after execution
  //         final data3 = await offlineTaskUsecases.deleteOfflineTask(task: task);

  //         await data3.fold((l) {
  //           //print("checkAndExecuteOfflineTasks error : $l");
  //         }, (r) async {
  //           final data4 = await offlineTaskUsecases.getOfflineTasks();
  //         });
  //       }
  //     }
  //   });
  // }
}
