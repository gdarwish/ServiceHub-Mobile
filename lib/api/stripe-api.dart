import 'dart:convert';
import 'dart:io';

import 'package:ServiceHub/api_keys.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:dio/dio.dart';

class StripeAPI {
  static final StripeAPI _instance = StripeAPI._internal();

  factory StripeAPI() => _instance;

  Dio dio;
  final String _token = kStripeSecret;

  StripeAPI._internal() {
    final options = BaseOptions(
      connectTimeout: 3000, // 3 seconds
      receiveTimeout: 3000, // 3 seconds
      baseUrl: Uri.encodeFull('https://api.stripe.com/v1'), // Stripe
      headers: {
        'Accept': 'application/json',
        // 'Content-Type': 'application/x-www-form-urlencoded',
        'Authorization': 'Bearer $_token',
      },
      contentType: Headers.formUrlEncodedContentType,
    );
    dio = Dio(options);
  }

  Future<dynamic> get(String path) async {
    try {
      final response = await dio.get(path);
      print(
          'GET REQUEST:\nURI: ${response.request.uri}\nSTATUS: ${response.statusCode}\nRESPONSE: ${response.data}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return response.data;
      } else {
        throw APIError.fromMap(response.data);
      }
    } on DioError catch (error) {
      print(error.message);
      throw APIError(message: error.response.data['error']['message']);
    } on Exception catch (error) {
      throw APIError(message: error.toString());
    }
  }

  Future<dynamic> post(String path, dynamic data,
      {List<File> files, String field}) async {
    try {
      final response = await dio.post(path, data: data);
      print(
          'GET REQUEST:\nURI: ${response.request.uri}\nSTATUS: ${response.statusCode}\nRESPONSE: ${response.data}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return response.data;
      } else {
        throw APIError.fromMap(response.data);
      }
    } on DioError catch (error) {
      print(error.message);
      throw APIError(message: error.response.data['error']['message']);
    } on Exception catch (error) {
      throw APIError(message: error.toString());
    }
  }
}
