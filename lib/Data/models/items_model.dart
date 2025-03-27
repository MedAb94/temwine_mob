import 'package:temwin_front_app/Domain/entities/offline_entities/items_entity.dart';

class ItemsModel extends ItemsEntity {
  const ItemsModel({super.id, super.qte});

  factory ItemsModel.fromJson(Map<String, dynamic> map) {
    return ItemsModel(id: map['id'] as num?, qte: map['qte'] as num?);
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "qte": qte,
    };
  }

  factory ItemsModel.fromEntity({required ItemsEntity item}) {
    return ItemsModel(
      id: item.id,
      qte: item.qte,
    );
  }
}
