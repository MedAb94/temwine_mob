import 'package:temwin_front_app/Domain/entities/bnf_entity.dart';

class BnfModel extends BnfEntity {
  const BnfModel({super.id, super.nni, super.nom, super.prenom, super.phone});

  factory BnfModel.fromJson(Map<String, dynamic> map) {
    return BnfModel(
      id: map['id'] as int?,
      nni: map['nni'] as String?,
      nom: map['nom'] as String?,
      prenom: map['prenom'] as String?,
      phone: map['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "nni": nni,
      "nom": nom,
      "prenom": prenom,
      "phone": phone,
    };
  }

  factory BnfModel.fromEntity({required BnfEntity bnfEntity}) {
    return BnfModel(
      id: bnfEntity.id,
      nni: bnfEntity.nni,
      nom: bnfEntity.nom,
      prenom: bnfEntity.prenom,
      phone: bnfEntity.phone,
    );
  }
}
