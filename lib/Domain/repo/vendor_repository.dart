import 'package:dartz/dartz.dart';
import 'package:temwin_front_app/Core/Error/failure.dart';
import 'package:temwin_front_app/Domain/entities/bnf_entity.dart';
import 'package:temwin_front_app/Domain/entities/offline_entities/sales_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_bnf_data_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_sales_entity.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';

abstract class VendorRepository {
  Future<Either<Failure, PosBnfDataEntity>> verifyBnf({required String nni});
  Future<Either<Failure, void>> sendOtp({required String phone});
  Future<Either<Failure, void>> verifyOtp(
      {required String phone, required String otp});

  Future<Either<Failure, void>> saveSales(
      {required Map<ProductsEntity, num> items,
      required BnfEntity bnf,
      required PosEntity posEntity});

  Future<Either<Failure, List<PosSalesEntity>>> getPosSales(
      {required String date1, required String date2});

  Future<Either<Failure, void>> syncOfflineSales(
      {required PosEntity posEntity, required List<SalesEntity> sales});
}
