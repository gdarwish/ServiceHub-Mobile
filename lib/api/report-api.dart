

import 'dart:io';

import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/provider.dart';
import 'package:ServiceHub/models/report.dart';
import 'package:ServiceHub/api/main-api.dart';
import 'package:flutter/foundation.dart';

class ReportAPI {
  static final ReportAPI _instance = ReportAPI._internal();

  factory ReportAPI() => _instance;

  ReportAPI._internal();

  final customerPath = '/customer';
  final providerPath = '/provider';

  Future<List<Report>> fetchReports() async {
    final userPath = _getUserPath(Account.currentUser);

    final data = await MainAPI().get('$userPath/reports');

    if (data != null) {
      return List<Report>.from(data.map((report) => Report.fromMap(report)));
    }

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<Report> fetchReport(Report report) async {
    final userPath = _getUserPath(Account.currentUser);

    final data = await MainAPI().get('$userPath/reports/${report.id}');

    if (data != null) {
      return Report.fromMap(data);
    }

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<Report> postReport(
    Report report, {
    @required List<File> images,
    bool isBug,
  }) async {
    final userPath = _getUserPath(Account.currentUser);
    final path = isBug ? '/bug-reports' : '$userPath/reports';
    
    final data = await MainAPI().post(
      path,
      report.toMap(),
      files: images,
      field: 'images[]',
    );

    if (data != null) {
      return Report.fromMap(data);
    }

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  String _getUserPath(Account user) {
    if (user == null) throw APIError(message: 'User is not autheticated.');

    if (user is Customer) return customerPath;
    if (user is Provider) return providerPath;

    throw APIError(message: 'User account is not supported.');
  }
}
