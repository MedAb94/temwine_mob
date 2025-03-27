import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:temwin_front_app/Domain/entities/bnf_entity.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';

part 'pos_bnf_data_entity.g.dart';

@HiveType(typeId: 7)
class PosBnfDataEntity extends Equatable {
  @HiveField(0)
  final int? status;
  @HiveField(1)
  final BnfEntity? bnf;
  @HiveField(2)
  final List<ProductsEntity>? products;

  const PosBnfDataEntity({this.status, this.bnf, this.products});

  @override
  List<Object?> get props => [status, bnf, products];
}
