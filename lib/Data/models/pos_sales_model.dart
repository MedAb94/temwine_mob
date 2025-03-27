import 'package:temwin_front_app/Data/models/bnf_model.dart';
import 'package:temwin_front_app/Data/models/pos_sales_lines_model.dart';
import 'package:temwin_front_app/Domain/entities/pos_sales_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_sales_lines_entity.dart';

class PosSalesModel extends PosSalesEntity {
  PosSalesModel(
      {super.id,
      super.code,
      super.posId,
      super.userId,
      super.beneficiareId,
      super.total,
      super.totalSub,
      super.beneficaire,
      super.lines});

  factory PosSalesModel.fromJson(Map<String, dynamic> map) {
    return PosSalesModel(
      id: map['id'] as num?,
      code: map['code'] as String?,
      posId: map['pos_id'] as num?,
      userId: map['user_id'] as num?,
      beneficiareId: map['beneficiare_id'] as num?,
      total: map['total'] as num?,
      totalSub: map['total_sub'] as num?,
      lines: map['lines'] != null
          ? List<PosSalesLinesEntity>.from(
              map['lines'].map((x) => PosSalesLinesModel.fromJson(x)))
          : null,
      beneficaire: map['beneficaire'] != null
          ? BnfModel.fromJson(map['beneficaire'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "code": code,
      "posId": posId,
      "userId": userId,
      "beneficiareId": beneficiareId,
      "total": total,
      "totalSub": totalSub,
      "lines": lines
          ?.map((e) =>
              PosSalesLinesModel.fromEntity(posSalesLinesEntity: e).toJson())
          .toList(),
      "beneficaire": beneficaire != null
          ? BnfModel.fromEntity(bnfEntity: beneficaire!).toJson()
          : null,
    };
  }

  factory PosSalesModel.fromEntity({required PosSalesEntity posSalesEntity}) {
    return PosSalesModel(
      id: posSalesEntity.id,
      code: posSalesEntity.code,
      posId: posSalesEntity.posId,
      userId: posSalesEntity.userId,
      beneficiareId: posSalesEntity.beneficiareId,
      total: posSalesEntity.total,
      totalSub: posSalesEntity.totalSub,
      beneficaire: posSalesEntity.beneficaire,
      lines: posSalesEntity.lines,
    );
  }
}
