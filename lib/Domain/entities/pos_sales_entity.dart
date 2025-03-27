import 'package:hive/hive.dart';
import 'package:temwin_front_app/Domain/entities/bnf_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_sales_lines_entity.dart';

part 'pos_sales_entity.g.dart';

@HiveType(typeId: 9)
class PosSalesEntity {
  @HiveField(0)
  final num? id;
  @HiveField(1)
  final String? code;
  @HiveField(2)
  final num? posId;
  @HiveField(3)
  final num? userId;
  @HiveField(4)
  final num? beneficiareId;
  @HiveField(5)
  final num? total;
  @HiveField(6)
  final num? totalSub;
  @HiveField(7)
  final BnfEntity? beneficaire;
  @HiveField(8)
  final List<PosSalesLinesEntity>? lines;

  const PosSalesEntity(
      {this.id,
      this.code,
      this.posId,
      this.userId,
      this.beneficiareId,
      this.total,
      this.totalSub,
      this.beneficaire,
      this.lines});
}
