import 'package:temwin_front_app/Domain/entities/pos_entity.dart';

class PosModel extends PosEntity {
  const PosModel({
    super.id,
    super.name,
    super.responsileId,
    super.vendeurId,
    super.wilayaId,
    super.moughataaId,
    super.communeId,
    super.localiteId,
    super.type,
    super.isActive,
    super.hasRestrictedBenefs,
  });

  factory PosModel.fromJson(Map<String, dynamic> map) {
    return PosModel(
      id: map['id'] as int?,
      name: map['name'] as String?,
      responsileId: map['responsile_id'] as int?,
      vendeurId: map['vendeur_id'] as int?,
      wilayaId: map['wilaya_id'] as String?,
      moughataaId: map['moughataa_id'] as String?,
      communeId: map['commune_id'] as String?,
      localiteId: map['localite_id'] as String?,
      type: map['type'] as int?,
      isActive: map['isActive'] as int?,
      hasRestrictedBenefs: map['has_restricted_benefs'] as bool?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "responsile_id": responsileId,
      "moughataa_id": moughataaId,
      "commune_id": communeId,
      "localite_id": localiteId,
      "isActive": isActive,
      "type": type,
      "has_restricted_benefs": hasRestrictedBenefs,
    };
  }

  factory PosModel.fromEntity({required PosEntity posEntity}) {
    return PosModel(
      id: posEntity.id,
      name: posEntity.name,
      responsileId: posEntity.responsileId,
      vendeurId: posEntity.vendeurId,
      wilayaId: posEntity.wilayaId,
      moughataaId: posEntity.moughataaId,
      communeId: posEntity.communeId,
      localiteId: posEntity.localiteId,
      type: posEntity.type,
      isActive: posEntity.isActive,
      hasRestrictedBenefs: posEntity.hasRestrictedBenefs,
    );
  }
}
