import 'package:temwin_front_app/Domain/entities/roles_entity.dart';

class RolesModel extends RolesEntity {
  const RolesModel({
    super.id,
    super.name,
    super.redirectUrl,
    super.guardName,
    super.description,
  });

  factory RolesModel.fromJson(Map<String, dynamic> map) {
    return RolesModel(
        id: map['id'] as int?,
        name: map['name'] as String?,
        redirectUrl: map['redirect_url'] as String?,
        guardName: map['guard_name'],
        description: map['description']);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      'redirect_url': redirectUrl,
      'guard_name': guardName,
      'description': description
    };
  }

  factory RolesModel.fromEntity({required RolesEntity rolesEntity}) {
    return RolesModel(
      id: rolesEntity.id,
      name: rolesEntity.name,
      redirectUrl: rolesEntity.redirectUrl,
      guardName: rolesEntity.guardName,
      description: rolesEntity.description,
    );
  }
}
