part of 'pos_sales_history_bloc.dart';

sealed class PosSalesHistoryState extends Equatable {
  const PosSalesHistoryState();

  @override
  List<Object> get props => [];
}

final class PosSalesHistoryInitial extends PosSalesHistoryState {}

class GetPosSaleHistoryLoading extends PosSalesHistoryState {}

class GetPosSaleHistorySuccess extends PosSalesHistoryState {
  final List<PosSalesEntity> data;

  const GetPosSaleHistorySuccess({required this.data});

  @override
  List<Object> get props => [data];
}

class GetPosSalesHistoryFailure extends PosSalesHistoryState {
  final String errorMessage;

  const GetPosSalesHistoryFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
