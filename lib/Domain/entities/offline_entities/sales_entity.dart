import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:temwin_front_app/Domain/entities/offline_entities/items_entity.dart';

part 'sales_entity.g.dart';

@HiveType(typeId: 12)
class SalesEntity extends Equatable {
  @HiveField(0)
  final String? date;
  @HiveField(1)
  final String? nni;
  @HiveField(2)
  final String? benefFirstName;
  @HiveField(3)
  final String? benefLastName;
  @HiveField(4)
  final List<ItemsEntity>? items;

  const SalesEntity(
      {this.date,
      this.nni,
      this.benefFirstName,
      this.benefLastName,
      this.items});

  @override
  List<Object?> get props => [date, nni, benefFirstName, benefLastName, items];
}
