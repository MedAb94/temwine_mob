import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'offline_task_entity.g.dart';

@HiveType(typeId: 10)
class OfflineTaskEntity extends Equatable {
  @HiveField(0)
  final String type;
  @HiveField(1)
  final String? body;
  @HiveField(2)
  final String? url;
  @HiveField(3)
  final List<OfflineTaskEntity>? subTasks;
  @HiveField(4)
  final String id;
  @HiveField(5)
  final Map<String, dynamic>? queryParams;

  const OfflineTaskEntity(
      {required this.type,
      this.body,
      this.url,
      this.subTasks,
      this.queryParams,
      required this.id});

  OfflineTaskEntity copyWith(
      {String? id,
      String? type,
      String? body,
      String? url,
      List<OfflineTaskEntity>? subTasks,
      Map<String, dynamic>? queryParams}) {
    return OfflineTaskEntity(
        id: id ?? this.id,
        type: type ?? this.type,
        body: body ?? this.body,
        url: url ?? this.url,
        subTasks: subTasks ?? this.subTasks,
        queryParams: queryParams ?? this.queryParams);
  }

  @override
  List<Object?> get props => [body, type, url, subTasks, id, queryParams];

  @override
  bool get stringify => true;
}
