part of 'offline_sales_storage_cubit.dart';

sealed class OfflineSalesStorageState extends Equatable {
  const OfflineSalesStorageState();

  @override
  List<Object> get props => [];
}

final class OfflineSalesStorageInitial extends OfflineSalesStorageState {}

final class OfflineSalesStorageLoading extends OfflineSalesStorageState {}

final class OfflineSalesStorageSuccess extends OfflineSalesStorageState {}

final class OfflineSalesStorageFailed extends OfflineSalesStorageState {}
