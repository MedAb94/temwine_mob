import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'items_entity.g.dart';

@HiveType(typeId: 11)
class ItemsEntity extends Equatable {
  @HiveField(0)
  final num? id;
  @HiveField(1)
  final num? qte;

  const ItemsEntity({this.id, this.qte});

  @override
  List<Object?> get props => [id, qte];
}
