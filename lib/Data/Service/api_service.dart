import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:temwin_front_app/Core/utils/api_end_points.dart';
import 'package:temwin_front_app/Data/dataSources/Local/Auth/auth_local_data_source.dart';
import 'package:temwin_front_app/Domain/entities/user_token_entity.dart';

class ApiService {
  final http.Client httpClient;
  final AuthLocalDataSource authLocalDataSource;

  ApiService({required this.httpClient, required this.authLocalDataSource});

  /// Refreshes the access token using the refresh token
  Future<String?> refreshToken() async {
    // final refreshToken = await TokenStorage.getRefreshToken();
    String? token = (await authLocalDataSource.getToken())?.accessToken;
    if (token == null) return null;

    try {
      final url = Uri.parse(EndPoint.authRefreshUrl);

      final response = await httpClient.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refreshToken': refreshToken}),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final newAccessToken = data['access_token'];
        final tokenType = data['token_type'];

        if (newAccessToken != null && tokenType != null) {
          await authLocalDataSource.storeToken(
              token: UserTokenEntity(
                  accessToken: newAccessToken, tokenType: tokenType));
          return newAccessToken;
        }
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  /// Generic function to make authenticated requests
  Future<http.Response?> makeRequest(
      {required String endpoint,
      required String method,
      Map<String, dynamic>? body,
      Map<String, dynamic>? queryParameters}) async {
    final url = Uri.parse(endpoint).replace(queryParameters: queryParameters);

    String? accessToken = (await authLocalDataSource.getToken())?.accessToken;

    http.Response response = await _sendRequest(url, method, body, accessToken);

    // If unauthorized, try to refresh token and retry request
    if (response.statusCode == 401 || response.statusCode == 403) {
      accessToken = await refreshToken();
      if (accessToken != null) {
        response = await _sendRequest(url, method, body, accessToken);
      } else {
        return null;
      }
    }

    return response;
  }

  /// Private function to send HTTP requests
  Future<http.Response> _sendRequest(Uri url, String method,
      Map<String, dynamic>? body, String? accessToken) async {
    final headers = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
      if (accessToken != null) 'Authorization': 'Bearer $accessToken',
    };

    switch (method) {
      case 'POST':
        return await httpClient.post(url,
            headers: headers, body: jsonEncode(body));
      case 'PUT':
        return await httpClient.put(url,
            headers: headers, body: jsonEncode(body));
      case 'DELETE':
        return await httpClient.delete(url, headers: headers);
      default:
        return await httpClient.get(url, headers: headers);
    }
  }
}
