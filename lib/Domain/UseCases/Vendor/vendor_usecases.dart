import 'package:dartz/dartz.dart';
import 'package:temwin_front_app/Core/Error/failure.dart';
import 'package:temwin_front_app/Domain/entities/bnf_entity.dart';
import 'package:temwin_front_app/Domain/entities/offline_entities/sales_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_bnf_data_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_sales_entity.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';
import 'package:temwin_front_app/Domain/repo/vendor_repository.dart';

class VendorUsecases {
  final VendorRepository vendorRepository;

  VendorUsecases({required this.vendorRepository});

  Future<Either<Failure, PosBnfDataEntity>> verifyBnf({required String nni}) =>
      vendorRepository.verifyBnf(nni: nni);

  Future<Either<Failure, void>> sendOtp({required String phone}) =>
      vendorRepository.sendOtp(phone: phone);

  Future<Either<Failure, void>> verifyOtp(
          {required String phone, required String otp}) =>
      vendorRepository.verifyOtp(phone: phone, otp: otp);

  Future<Either<Failure, void>> saveSales(
          {required Map<ProductsEntity, num> items,
          required BnfEntity bnf,
          required PosEntity posEntity}) =>
      vendorRepository.saveSales(items: items, bnf: bnf, posEntity: posEntity);

  Future<Either<Failure, List<PosSalesEntity>>> getPosSales(
          {required String date1, required String date2}) =>
      vendorRepository.getPosSales(date1: date1, date2: date2);

  Future<Either<Failure, void>> syncOfflineSales(
          {required PosEntity posEntity, required List<SalesEntity> sales}) =>
      vendorRepository.syncOfflineSales(posEntity: posEntity, sales: sales);
}
