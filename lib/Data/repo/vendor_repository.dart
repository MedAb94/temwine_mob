import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:temwin_front_app/Core/Error/failure.dart';
import 'package:temwin_front_app/Data/dataSources/Local/Auth/auth_local_data_source.dart';
import 'package:temwin_front_app/Data/dataSources/Local/User/user_local_data_source.dart';
import 'package:temwin_front_app/Data/dataSources/Remote/Vendor/vendor_remote_data_source.dart';
import 'package:temwin_front_app/Domain/entities/bnf_entity.dart';
import 'package:temwin_front_app/Domain/entities/offline_entities/sales_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_bnf_data_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_sales_entity.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';
import 'package:temwin_front_app/Domain/repo/vendor_repository.dart';

class VendorRepositoryImpl implements VendorRepository {
  final VendorRemoteDataSource vendorRemoteDataSource;
  final AuthLocalDataSource authLocalDataSource;

  VendorRepositoryImpl(
      {required this.vendorRemoteDataSource,
      required this.authLocalDataSource});

  @override
  Future<Either<Failure, PosBnfDataEntity>> verifyBnf(
      {required String nni}) async {
    try {
      PosBnfDataEntity data = await vendorRemoteDataSource.verifyBnf(nni: nni);

      return Right(data);
    } catch (e) {
      debugPrint("verifyBnf error : $e");

      if ((e as Failure).hastoLogOut) {
        authLocalDataSource.clearToken();
      }

      //return Left(Failure(message: e.toString()));
      //return Left(Failure(message: (e as Failure).message));
      return Left((e as Failure));
    }
  }

  @override
  Future<Either<Failure, void>> sendOtp({required String phone}) async {
    try {
      await vendorRemoteDataSource.sendOtp(phone: phone);

      return Right(null);
    } catch (e) {
      debugPrint("sendOtp error : $e");

      if ((e as Failure).hastoLogOut) {
        authLocalDataSource.clearToken();
      }

      //return Left(Failure(message: e.toString()));
      return Left(Failure(message: (e as Failure).message));
    }
  }

  @override
  Future<Either<Failure, void>> verifyOtp(
      {required String phone, required String otp}) async {
    try {
      await vendorRemoteDataSource.verifyOtp(phone: phone, otp: otp);

      return Right(null);
    } catch (e) {
      debugPrint("verifyOtp error : $e");

      if ((e as Failure).hastoLogOut) {
        authLocalDataSource.clearToken();
      }

      //return Left(Failure(message: e.toString()));
      return Left(Failure(message: (e as Failure).message));
    }
  }

  @override
  Future<Either<Failure, void>> saveSales(
      {required Map<ProductsEntity, num> items,
      required BnfEntity bnf,
      required PosEntity posEntity}) async {
    try {
      await vendorRemoteDataSource.saveSales(
          items: items, bnf: bnf, posEntity: posEntity);

      return Right(null);
    } catch (e) {
      debugPrint("saveSales error : $e");

      if ((e as Failure).hastoLogOut) {
        authLocalDataSource.clearToken();
      }

      //return Left(Failure(message: e.toString()));
      return Left(Failure(message: (e as Failure).message));
    }
  }

  @override
  Future<Either<Failure, List<PosSalesEntity>>> getPosSales(
      {required String date1, required String date2}) async {
    try {
      List<PosSalesEntity> posSalesEntityList =
          await vendorRemoteDataSource.getPosSales(date1: date1, date2: date2);

      return Right(posSalesEntityList);
    } catch (e) {
      debugPrint("getPosSales error : $e");

      if ((e as Failure).hastoLogOut) {
        authLocalDataSource.clearToken();
      }

      //return Left(Failure(message: e.toString()));
      return Left(Failure(message: (e as Failure).message));
    }
  }

  @override
  Future<Either<Failure, void>> syncOfflineSales(
      {required PosEntity posEntity, required List<SalesEntity> sales}) async {
    try {
      await vendorRemoteDataSource.syncOfflineSales(
          posEntity: posEntity, sales: sales);

      return Right(null);
    } catch (e) {
      debugPrint("syncOfflineSales error : $e");

      if ((e as Failure).hastoLogOut) {
        authLocalDataSource.clearToken();
      }

      //return Left(Failure(message: e.toString()));
      return Left(Failure(message: (e as Failure).message));
    }
  }
}
