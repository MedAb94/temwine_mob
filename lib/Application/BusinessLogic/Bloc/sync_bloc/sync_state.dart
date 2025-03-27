part of 'sync_bloc.dart';

sealed class SyncState extends Equatable {
  const SyncState();

  @override
  List<Object> get props => [];
}

final class SyncInitial extends SyncState {}

class SyncOfflineDataLoading extends SyncState {}

class SyncOfflineDataSuccess extends SyncState {}

class SyncOfflineDataFailure extends SyncState {
  final String errorMessage;

  const SyncOfflineDataFailure({required this.errorMessage});

  @override
  List<Object> get props => [errorMessage];
}
