import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'pos_entity.g.dart';

@HiveType(typeId: 1)
class PosEntity extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? name;
  @HiveField(2)
  final int? responsileId;
  @HiveField(3)
  final int? vendeurId;
  @HiveField(4)
  final String? wilayaId;
  @HiveField(5)
  final String? moughataaId;
  @HiveField(6)
  final String? communeId;
  @HiveField(7)
  final String? localiteId;

  @HiveField(8)
  final int? type;
  @HiveField(9)
  final int? isActive;

  const PosEntity({
    this.id,
    this.name,
    this.responsileId,
    this.vendeurId,
    this.wilayaId,
    this.moughataaId,
    this.communeId,
    this.localiteId,
    this.type,
    this.isActive,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        responsileId,
        vendeurId,
        wilayaId,
        moughataaId,
        communeId,
        localiteId,
        type,
        isActive
      ];
}
