import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temwin_front_app/Data/dataSources/Local/OfflineSales/offline_sales_local_data_source.dart';
import 'package:temwin_front_app/Domain/entities/offline_entities/sales_entity.dart';

part 'offline_sales_storage_state.dart';

class OfflineSalesStorageCubit extends Cubit<OfflineSalesStorageState> {
  final OfflineSalessLocalDataSource offlineSalessLocalDataSource;
  OfflineSalesStorageCubit({required this.offlineSalessLocalDataSource})
      : super(OfflineSalesStorageInitial());

  void storeOfflineSales({required SalesEntity data}) async {
    try {
      emit(OfflineSalesStorageLoading());
      await offlineSalessLocalDataSource.storeOfflineSales(data: data);
      emit(OfflineSalesStorageSuccess());
    } catch (e) {
      debugPrint("storeOfflineSales error : $e");
      emit(OfflineSalesStorageFailed());
    }
  }
}
