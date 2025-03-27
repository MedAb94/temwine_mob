import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:temwin_front_app/Core/Error/failure.dart';
import 'package:temwin_front_app/Core/utils/api_end_points.dart';
import 'package:temwin_front_app/Data/Service/api_service.dart';
import 'package:temwin_front_app/Data/dataSources/Local/Auth/auth_local_data_source.dart';
import 'package:temwin_front_app/Data/models/pos_bnf_data_model.dart';
import 'package:temwin_front_app/Data/models/pos_sales_model.dart';
import 'package:temwin_front_app/Data/models/sales_model.dart';
import 'package:temwin_front_app/Domain/entities/bnf_entity.dart';
import 'package:temwin_front_app/Domain/entities/offline_entities/sales_entity.dart';

import 'package:temwin_front_app/Domain/entities/pos_bnf_data_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_entity.dart';
import 'package:temwin_front_app/Domain/entities/pos_sales_entity.dart';
import 'package:temwin_front_app/Domain/entities/product_entity.dart';

abstract class VendorRemoteDataSource {
  Future<PosBnfDataEntity> verifyBnf({required String nni});
  Future<void> sendOtp({required String phone});
  Future<void> verifyOtp({required String phone, required String otp});
  Future<void> saveSales(
      {required Map<ProductsEntity, num> items,
      required BnfEntity bnf,
      required PosEntity posEntity});

  Future<List<PosSalesEntity>> getPosSales(
      {required String date1, required String date2});

  Future<void> syncOfflineSales(
      {required PosEntity posEntity, required List<SalesEntity> sales});
}

class VendorRemoteDataSourceImpl implements VendorRemoteDataSource {
  final http.Client httpClient;
  final AuthLocalDataSource authLocalDataSource;
  final ApiService apiService;

  VendorRemoteDataSourceImpl(
      {required this.httpClient,
      required this.authLocalDataSource,
      required this.apiService});

  @override
  Future<PosBnfDataEntity> verifyBnf({required String nni}) async {
    debugPrint("verifyBnf => nni: $nni");

    try {
      final response = await apiService.makeRequest(
        endpoint: "${EndPoint.verifyBnfUrl}/$nni",
        method: "GET",
      );
      if (response == null) {
        throw Failure(message: "need to log out", hastoLogOut: true);
      } else if (response.statusCode == 200) {
        final data = json.decode(response.body);

        debugPrint("VendorRemoteDataSource verifyBnf success ${response.body}");

        PosBnfDataEntity posBnfDataEntity = PosBnfDataModel.fromJson(data);

        return posBnfDataEntity;
      } else {
        if (kDebugMode) {
          debugPrint(
              "VendorRemoteDataSource verifyBnf error1 ${response.body}");
        }

        Map<String, dynamic> bodyJson = jsonDecode(response.body);

        String message = (bodyJson['msg'] as String);
        throw Failure(message: message);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint("VendorRemoteDataSource verifyBnf error 2${e.toString()}");
      }

      throw Failure(message: e.toString());
    }
  }

  @override
  Future<void> sendOtp({required String phone}) async {
    try {
      final response = await apiService.makeRequest(
          endpoint: EndPoint.sendOtpfUrl, method: "POST", body: {'to': phone});
      if (response == null) {
        throw Failure(message: "need to log out", hastoLogOut: true);
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        if (kDebugMode) {
          debugPrint("VendorRemoteDataSource sendOtp error1 ${response.body}");
        }

        Map<String, dynamic> bodyJson = jsonDecode(response.body);

        String message = (bodyJson['msg'] as String);
        throw Failure(message: message);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint("VendorRemoteDataSource sendOtp error 2${e.toString()}");
      }

      throw Failure(message: e.toString());
    }
  }

  @override
  Future<void> verifyOtp({required String phone, required String otp}) async {
    try {
      final response = await apiService.makeRequest(
          endpoint: EndPoint.verifyOtpUrl,
          method: "POST",
          body: {'to': phone, 'otp': otp});

      if (response == null) {
        throw Failure(message: "need to log out", hastoLogOut: true);
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        if (kDebugMode) {
          debugPrint(
              "VendorRemoteDataSource verifyOtp error1 ${response.body}");
        }

        Map<String, dynamic> bodyJson = jsonDecode(response.body);

        String message = (bodyJson['msg'] as String);
        throw Failure(message: message);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint("VendorRemoteDataSource verifyOtp error 2${e.toString()}");
      }

      throw Failure(message: e.toString());
    }
  }

  @override
  Future<void> saveSales(
      {required Map<ProductsEntity, num> items,
      required BnfEntity bnf,
      required PosEntity posEntity}) async {
    List<Map<String, num>> allItems = [];
    num total = 0;
    items.forEach((key, value) {
      Map<String, num> itemMap = {
        'id': key.id!,
        'qte': value,
      };
      allItems.add(itemMap);
      total += (key.price ?? 0) * value;
    });

    try {
      final response = await apiService
          .makeRequest(endpoint: EndPoint.saveSalesUrl, method: "POST", body: {
        'items': allItems,
        'bnf_id': bnf.id,
        'total': total,
        'pos_id': posEntity.id,
      });

      if (response == null) {
        throw Failure(message: "need to log out", hastoLogOut: true);
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        return;
      } else {
        if (kDebugMode) {
          debugPrint(
              "VendorRemoteDataSource verifyOtp error1 ${response.body}");
        }

        Map<String, dynamic> bodyJson = jsonDecode(response.body);

        String message = (bodyJson['msg'] as String);
        throw Failure(message: message);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint("VendorRemoteDataSource verifyOtp error 2${e.toString()}");
      }

      throw Failure(message: e.toString());
    }
  }

  @override
  Future<List<PosSalesEntity>> getPosSales(
      {required String date1, required String date2}) async {
    try {
      final response = await apiService.makeRequest(
        endpoint: EndPoint.posSalesUrl(date1: date1, date2: date2),
        method: "GET",
      );
      if (response == null) {
        throw Failure(message: "need to log out", hastoLogOut: true);
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        final data = json.decode(response.body);

        List<PosSalesEntity> allPosSales = List<PosSalesEntity>.from(
            data.map((e) => PosSalesModel.fromJson(e)));

        return allPosSales;
      } else {
        if (kDebugMode) {
          debugPrint(
              "VendorRemoteDataSource getPosSales error1 ${response.body}");
        }

        Map<String, dynamic> bodyJson = jsonDecode(response.body);

        String message = (bodyJson['msg'] as String);
        throw Failure(message: message);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint("VendorRemoteDataSource getPosSales error 2${e.toString()}");
      }

      throw Failure(message: e.toString());
    }
  }

  @override
  Future<void> syncOfflineSales(
      {required PosEntity posEntity, required List<SalesEntity> sales}) async {
    try {
      final response = await apiService.makeRequest(
          endpoint: EndPoint.syncOfflineSalesUrl,
          method: "POST",
          body: {
            'pos_id': posEntity.id,
            'sales': sales
                .map((e) => SalesModel.fromEntity(sale: e).toJson())
                .toList()
          });
      if (response == null) {
        throw Failure(message: "need to log out", hastoLogOut: true);
      } else if (response.statusCode == 200 || response.statusCode == 201) {
        debugPrint(
            "VendorRemoteDataSource syncOfflineSales success ${response.body}");
        return;
      } else {
        if (kDebugMode) {
          debugPrint(
              "VendorRemoteDataSource syncOfflineSales error1 ${response.body}");
        }

        Map<String, dynamic> bodyJson = jsonDecode(response.body);

        String message = (bodyJson['msg'] as String);
        throw Failure(message: message);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint(
            "VendorRemoteDataSource syncOfflineSales error 2${e.toString()}");
      }

      throw Failure(message: e.toString());
    }
  }
}
