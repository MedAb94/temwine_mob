import 'package:temwin_front_app/Data/models/items_model.dart';
import 'package:temwin_front_app/Domain/entities/offline_entities/items_entity.dart';
import 'package:temwin_front_app/Domain/entities/offline_entities/sales_entity.dart';

class SalesModel extends SalesEntity {
  const SalesModel(
      {super.date,
      super.nni,
      super.benefFirstName,
      super.benefLastName,
      super.items});

  factory SalesModel.fromJson(Map<String, dynamic> map) {
    return SalesModel(
      date: map['date'] as String?,
      nni: map['nni'] as String?,
      benefFirstName: map['benef_first_name'] as String?,
      benefLastName: map['benef_last_name'],
      items: map['items'] != null
          ? List<ItemsEntity>.from(
              map['items'].map((x) => ItemsModel.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "date": date,
      "nni": nni,
      'benef_first_name': benefFirstName,
      'benef_last_name': benefLastName,
      "items":
          items?.map((e) => ItemsModel.fromEntity(item: e).toJson()).toList(),
    };
  }

  factory SalesModel.fromEntity({required SalesEntity sale}) {
    return SalesModel(
      date: sale.date,
      nni: sale.nni,
      benefFirstName: sale.benefFirstName,
      benefLastName: sale.benefLastName,
      items: sale.items,
    );
  }
}
