part of 'pos_sales_history_bloc.dart';

sealed class PosSalesHistoryEvent extends Equatable {
  const PosSalesHistoryEvent();

  @override
  List<Object> get props => [];
}

class GetPosSaleHistory extends PosSalesHistoryEvent {
  final String date1;

  final String date2;

  const GetPosSaleHistory({required this.date1, required this.date2});

  @override
  List<Object> get props => [date1, date2];
}
