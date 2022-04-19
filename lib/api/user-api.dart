import 'dart:io';

import 'package:ServiceHub/api/main-api.dart';
import 'package:ServiceHub/db/settings-db.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:ServiceHub/models/provider.dart';
import 'package:ServiceHub/models/settings.dart';
import 'package:flutter/foundation.dart';

class UserAPI {
  static final UserAPI _instance = UserAPI._internal();

  factory UserAPI() => _instance;

  UserAPI._internal();

  Future<Account> login({
    @required String email,
    @required String password,
    @required Type type,
    @required bool rememberMe,
  }) async {
    final data = await MainAPI().post(
      '/login',
      {'email': email, 'password': password},
    );
    // Set token API
    MainAPI().setToken(data['token']);

    // Save token DB
    Settings().token = data['token'];
    Settings().rememberMe = rememberMe;
    Settings().userType = (type == Customer) ? 'customer' : 'provider';
    // Remember me
    if (rememberMe) {
      Settings().email = email;
      Settings().password = password;
    } else {
      Settings().email = '';
      Settings().password = '';
    }
    // Save settings DB
    SettingsDB().saveSettings(Settings());

    if (type == Customer) return Customer.fromMap(data['user']);
    if (type == Provider) return Provider.fromMap(data['user']);

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<Map<String, String>> register({
    @required String firstName,
    @required String lastName,
    @required String email,
    @required String password,
    @required String passwordConfirmation,
    Type type,
  }) async {
    final data = await MainAPI().post(
      '/register',
      {
        'first_name': firstName,
        'last_name': lastName,
        'email': email,
        'password': password,
        'password_confirmation': passwordConfirmation,
      },
    );
    // // if register success
    // if (data != null) {
    //   // login user (customer is default)
    //   return await login(
    //     email: email,
    //     password: password,
    //     type: type ?? Customer,
    //   );
    // }

    // if register success
    if (data != null) {
      return {'email': email, 'password': password};
    }

    throw APIError();
  }

  Future<Map<String, dynamic>> resetPassword({
    @required String email,
  }) async {
    final data = await MainAPI().post(
      '/reset-password',
      {'email': email},
    );

    if (data != null) return data;

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<Map<String, dynamic>> verifyEmail() async {
    final data = await MainAPI().post('/send-email-verification', null);

    if (data != null) return data;

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<Account> updateUser(Account user, {File newImage}) async {
    final data = await MainAPI()
        .put('/user', user.toMap(), files: [newImage], field: 'image_url');

    if (user is Customer) return Customer.fromMap(data['user']);
    if (user is Provider) return Provider.fromMap(data['user']);

    // if you hit this line, something weird is going on :)
    throw APIError();
  }
}
