part of 'otp_bloc.dart';

sealed class OtpState extends Equatable {
  const OtpState();

  @override
  List<Object> get props => [];
}

final class OtpInitial extends OtpState {}

class SendOtpLoading extends OtpState {}

class SendOtpSuccess extends OtpState {}

class SendOtpFailed extends OtpState {
  final String errorMessage;

  const SendOtpFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class VerifyOtpLoading extends OtpState {}

class VerifyOtpSuccess extends OtpState {}

class VerifyOtpFailed extends OtpState {
  final String errorMessage;

  const VerifyOtpFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}

class SaveSalesLoading extends OtpState {}

class SaveSalesSuccess extends OtpState {}

class SaveSalesFailed extends OtpState {
  final String errorMessage;

  const SaveSalesFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
