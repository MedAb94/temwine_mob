import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:temwin_front_app/Domain/UseCases/Vendor/vendor_usecases.dart';
import 'package:temwin_front_app/Domain/entities/pos_sales_entity.dart';

part 'pos_sales_history_event.dart';
part 'pos_sales_history_state.dart';

class PosSalesHistoryBloc
    extends Bloc<PosSalesHistoryEvent, PosSalesHistoryState> {
  final VendorUsecases vendorUsecases;

  PosSalesHistoryBloc({required this.vendorUsecases})
      : super(PosSalesHistoryInitial()) {
    on<GetPosSaleHistory>(_onGetPosSaleHistory);
  }

  void _onGetPosSaleHistory(
      GetPosSaleHistory event, Emitter<PosSalesHistoryState> emit) async {
    emit(GetPosSaleHistoryLoading());

    debugPrint(
        "GetPosSaleHistory between : ${event.date1}  -  ${event.date2} ");

    final result = await vendorUsecases.getPosSales(
        date1: event.date1, date2: event.date2);

    result.fold((l) {
      debugPrint('_onGetPosSaleHistory error : ${l.message}');
      emit(GetPosSalesHistoryFailure(errorMessage: l.message));
    }, (r) {
      //emit state

      emit(GetPosSaleHistorySuccess(data: r));
    });
  }
}
