part of 'otp_bloc.dart';

sealed class OtpEvent extends Equatable {
  const OtpEvent();

  @override
  List<Object> get props => [];
}

class SendOtp extends OtpEvent {
  final String phone;

  const SendOtp({required this.phone});

  @override
  List<Object> get props => [phone];
}

class VerifyOtp extends OtpEvent {
  final String phone;
  final String otp;
  final Map<ProductsEntity, num> items;
  final BnfEntity bnf;
  final PosEntity posEntity;

  const VerifyOtp(
      {required this.phone,
      required this.otp,
      required this.items,
      required this.bnf,
      required this.posEntity});

  @override
  List<Object> get props => [phone, otp, items, bnf, posEntity];
}

class SaveSale extends OtpEvent {
  final Map<ProductsEntity, num> items;
  final BnfEntity bnf;
  final PosEntity posEntity;

  const SaveSale(
      {required this.items, required this.bnf, required this.posEntity});

  @override
  List<Object> get props => [items, bnf, posEntity];
}
