import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:temwin_front_app/Domain/UseCases/Vendor/vendor_usecases.dart';
import 'package:temwin_front_app/Domain/entities/bnf_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_entity.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';

part 'otp_event.dart';
part 'otp_state.dart';

class OtpBloc extends Bloc<OtpEvent, OtpState> {
  final VendorUsecases vendorUsecases;
  OtpBloc({required this.vendorUsecases}) : super(OtpInitial()) {
    on<SendOtp>(_onSendOtp);
    on<VerifyOtp>(_onVerifyOtp);
    on<SaveSale>(_onSaveSale);
  }

  void _onSendOtp(SendOtp event, Emitter<OtpState> emit) async {
    emit(SendOtpLoading());

    debugPrint("_onSendOtp phone : ${event.phone}");

    final result = await vendorUsecases.sendOtp(phone: event.phone);

    result.fold((l) {
      debugPrint('_onSendOtp error : ${l.message}');
      emit(SendOtpFailed(errorMessage: l.message));
    }, (r) {
      //emit state

      emit(SendOtpSuccess());
    });
  }

  void _onVerifyOtp(VerifyOtp event, Emitter<OtpState> emit) async {
    emit(VerifyOtpLoading());

    debugPrint("_onVerifyOtp phone : ${event.phone}");

    final result =
        await vendorUsecases.verifyOtp(phone: event.phone, otp: event.otp);

    result.fold((l) {
      debugPrint('_onVerifyOtp error : ${l.message}');
      emit(VerifyOtpFailed(errorMessage: l.message));
    }, (r) async {
      //emit state

      emit(VerifyOtpSuccess());
      add(SaveSale(
          items: event.items, bnf: event.bnf, posEntity: event.posEntity));
    });
  }

  void _onSaveSale(SaveSale event, Emitter<OtpState> emit) async {
    emit(SaveSalesLoading());
    debugPrint('_onSaveSale posEntity : ${event.posEntity}');
    final result2 = await vendorUsecases.saveSales(
        items: event.items, bnf: event.bnf, posEntity: event.posEntity);

    result2.fold((l) {
      debugPrint('_onSaveSale error : ${l.message}');
      emit(SaveSalesFailed(errorMessage: l.message));
    }, (l) {
      emit(SaveSalesSuccess());
    });
  }
}
