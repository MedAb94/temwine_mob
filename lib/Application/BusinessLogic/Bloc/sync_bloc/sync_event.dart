part of 'sync_bloc.dart';

sealed class SyncEvent extends Equatable {
  const SyncEvent();

  @override
  List<Object> get props => [];
}

class SyncOfflineData extends SyncEvent {
  final PosEntity posEntity;

  const SyncOfflineData({required this.posEntity});

  @override
  List<Object> get props => [posEntity];
}
