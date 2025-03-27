import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temwin_front_app/Domain/UseCases/Vendor/vendor_usecases.dart';
import 'package:temwin_front_app/Domain/entities/pos_bnf_data_entity.dart';

part 'vendor_event.dart';
part 'vendor_state.dart';

class VendorBloc extends Bloc<VendorEvent, VendorState> {
  final VendorUsecases vendorUsecases;

  VendorBloc({required this.vendorUsecases}) : super(VendorInitial()) {
    on<VerifyBnf>(_onVerifyBnf);
  }

  void _onVerifyBnf(VerifyBnf event, Emitter<VendorState> emit) async {
    emit(VerifyBnfLoading());

    debugPrint("VerifyBnf nni : ${event.nni}");

    final result = await vendorUsecases.verifyBnf(nni: event.nni);

    result.fold((l) {
      debugPrint('auth error : ${l.message}');
      emit(VerifyBnfFailed(errorMessage: l.message));
    }, (r) {
      //emit state
      if (r.status == 0) {
        emit(VerifyBnfFailed(errorMessage: "Ce beneficiaire n'existe pas..."));
      } else {
        emit(VerifyBnfSuccess(data: r));
      }
    });
  }
}
