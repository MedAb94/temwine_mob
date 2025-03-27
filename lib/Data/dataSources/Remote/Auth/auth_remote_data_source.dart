import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:temwin_front_app/Core/Error/failure.dart';
import 'package:temwin_front_app/Core/utils/api_end_points.dart';
import 'package:temwin_front_app/Data/Service/api_service.dart';
import 'package:temwin_front_app/Data/dataSources/Local/Auth/auth_local_data_source.dart';
import 'package:temwin_front_app/Data/models/user_data_model.dart';
import 'package:temwin_front_app/Data/models/user_model.dart';
import 'package:temwin_front_app/Domain/entities/user_data_entity.dart';

abstract class AuthRemoteDataSource {
  Future<UserDataEntity> signIn({required UserModel user});
  Future<void> signOut();
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final http.Client httpClient;
  final AuthLocalDataSource authLocalDataSource;
  final ApiService apiService;
  AuthRemoteDataSourceImpl(
      {required this.httpClient,
      required this.authLocalDataSource,
      required this.apiService});

  @override
  Future<UserDataEntity> signIn({required UserModel user}) async {
    // Define the parameters
    Map<String, String> params = {
      'email': user.email ?? '',
      'password': user.password ?? '',
    };

    try {
      final response = await apiService.makeRequest(
          endpoint: EndPoint.authSignInUrl,
          method: "POST",
          queryParameters: params);
      if (response?.statusCode == 200) {
        final data = json.decode(response!.body);

        UserDataEntity userDataEntity = UserDataModel.fromJson(data);
        return userDataEntity;
      } else {
        if (kDebugMode) {
          debugPrint("AuthRemoteDataSource signIn error1 ${response!.body}");
        }

        Map<String, dynamic> bodyJson = jsonDecode(response!.body);

        String message = (bodyJson['msg'] as String);

        throw Failure(message: message);
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        debugPrint("AuthRemoteDataSource signIn error 2${e.toString()}");
      }

      throw Failure(message: e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      final response = await apiService.makeRequest(
        endpoint: EndPoint.authSignOutUrl,
        method: "POST",
      );

      if (response?.statusCode == 200 || response?.statusCode == 204) {
        return;
      } else {
        if (kDebugMode) {
          //print("signOut error ${response.body}");
        }
        throw Failure(message: "signOut Failed");
      }
    } on Exception catch (e) {
      if (kDebugMode) {
        //print("signOut error ${e.toString()}");
      }

      throw Failure(message: e.toString());
    }
  }
}
