part of 'vendor_bloc.dart';

sealed class VendorEvent extends Equatable {
  const VendorEvent();

  @override
  List<Object> get props => [];
}

class VerifyBnf extends VendorEvent {
  final String nni;

  const VerifyBnf({required this.nni});

  @override
  List<Object> get props => [nni];
}
