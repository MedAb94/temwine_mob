import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'roles_entity.g.dart';

@HiveType(typeId: 2)
class RolesEntity extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final String? redirectUrl;
  @HiveField(3)
  final String? guardName;
  @HiveField(4)
  final String? description;

  const RolesEntity({
    this.id,
    this.name,
    this.redirectUrl,
    this.guardName,
    this.description,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        redirectUrl,
        guardName,
        description,
      ];
}
