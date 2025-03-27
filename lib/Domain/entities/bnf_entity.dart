import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'bnf_entity.g.dart';

@HiveType(typeId: 6)
class BnfEntity extends Equatable {
  @HiveField(0)
  final int? id;
  @HiveField(1)
  final String? nom;
  @HiveField(2)
  final String? prenom;
  @HiveField(3)
  final String? nni;
  @HiveField(4)
  final String? phone;

  const BnfEntity({
    this.id,
    this.nom,
    this.prenom,
    this.nni,
    this.phone,
  });

  @override
  List<Object?> get props => [
        id,
        nom,
        prenom,
        nni,
        phone,
      ];
}
