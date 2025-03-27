part of 'vendor_bloc.dart';

sealed class VendorState extends Equatable {
  const VendorState();

  @override
  List<Object> get props => [];
}

final class VendorInitial extends VendorState {}

class VerifyBnfLoading extends VendorState {}

class VerifyBnfSuccess extends VendorState {
  final PosBnfDataEntity data;

  const VerifyBnfSuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class VerifyBnfFailed extends VendorState {
  final String errorMessage;

  const VerifyBnfFailed({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
