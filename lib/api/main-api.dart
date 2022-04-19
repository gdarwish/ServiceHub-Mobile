import 'dart:io';

import 'package:ServiceHub/models/api-error.dart';
import 'package:dio/dio.dart';

class MainAPI {
  static final MainAPI _instance = MainAPI._internal();

  factory MainAPI() => _instance;

  Dio dio;
  String _token;
  String get token => _token;
  void setToken(String token) {
    _token = token;
    dio.options.headers.update('Authorization', (value) => 'Bearer $token');
  }

  MainAPI._internal() {
    final options = BaseOptions(
      connectTimeout: 3000, // 3 seconds
      receiveTimeout: 3000, // 3 seconds
      // baseUrl: Uri.encodeFull('http://127.0.0.1:80/api/v1'), // iOS
      // baseUrl: Uri.encodeFull('http://10.0.2.2:80/api/v1'), // Android
      baseUrl: Uri.encodeFull('https://servicehub.alidali.ca/api/v1'), // WHC
      headers: {
        'Content-Type': 'application/json;charset=UTF-8',
        'Charset': 'utf-8',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    dio = Dio(options);
  }

  Future<dynamic> get(String path) async {
    try {
      print('token: ' + token);
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
      throw APIError.fromMap(
        error.response?.data ?? {'message': error.message},
      );
    } on Exception catch (error) {
      throw APIError(message: error.toString());
    }
  }

  Future<dynamic> post(String path, dynamic data,
      {List<File> files, String field}) async {
    try {
      final formData = FormData.fromMap(data);
      if (files != null) {
        files.forEach((file) async {
          if (file == null) return;
          formData.files
              .add(MapEntry(field, await MultipartFile.fromFile(file.path)));
        });
      }

      final response = await dio.post(path, data: formData);
      print(
          'GET REQUEST:\nURI: ${response.request.uri}\nSTATUS: ${response.statusCode}\nRESPONSE: ${response.data}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return response.data;
      } else {
        throw APIError.fromMap(response.data);
      }
    } on DioError catch (error) {
      print(error.message);
      throw APIError.fromMap(
        error.response?.data ?? {'message': error.message},
      );
    } on Exception catch (error) {
      throw APIError(message: error.toString());
    }
  }

  Future<dynamic> put(String path, dynamic data,
      {List<File> files, String field}) async {
    try {
      final formData = FormData.fromMap(data);
      if (files != null) {
        files.forEach((file) async {
          if (file == null) return;
          formData.files
              .add(MapEntry(field, await MultipartFile.fromFile(file.path)));
        });
      }
      final response = await dio.post(path, data: formData);
      print(
          'GET REQUEST:\nURI: ${response.request.uri}\nSTATUS: ${response.statusCode}\nRESPONSE: ${response.data}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return response.data;
      } else {
        throw APIError.fromMap(response.data);
      }
    } on DioError catch (error) {
      print(error.message);
      throw APIError.fromMap(
        error.response?.data ?? {'message': error.message},
      );
    } on Exception catch (error) {
      throw APIError(message: error.toString());
    }
  }

  Future<dynamic> delete(String path) async {
    try {
      final response = await dio.delete(path);
      print(
          'GET REQUEST:\nURI: ${response.request.uri}\nSTATUS: ${response.statusCode}\nRESPONSE: ${response.data}');

      if (response.statusCode >= 200 && response.statusCode <= 299) {
        return response.data;
      } else {
        throw APIError.fromMap(response.data);
      }
    } on DioError catch (error) {
      throw APIError.fromMap(
        error.response?.data ?? {'message': error.message},
      );
    } on Exception catch (error) {
      throw APIError(message: error.toString());
    }
  }
}
