import 'dart:io';

import 'package:ServiceHub/api/main-api.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/lawn-request.dart';
import 'package:ServiceHub/models/provider.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/models/snow-request.dart';
import 'package:flutter/cupertino.dart';

class ServiceRequestAPI {
  static final ServiceRequestAPI _instance = ServiceRequestAPI._internal();

  factory ServiceRequestAPI() => _instance;

  ServiceRequestAPI._internal();

  final customerPath = '/customer';
  final providerPath = '/provider';

  Future<List<ServiceRequest>> searchServiceRequests(
      {List<String> filters = const []}) async {
    final userPath = _getUserPath(Account.currentUser);

    String filtersURI = '';
    filters.forEach((filter) => filtersURI += '$filter+');

    final data =
        await MainAPI().get('$userPath/requests/search?filter=$filtersURI');

    if (data != null) {
      final serviceRequests = List<ServiceRequest>.from(data.map(
        (serviceRequest) {
          if (serviceRequest['request_number'].toString().startsWith('SN'))
            return SnowRequest.fromMap(serviceRequest);
          if (serviceRequest['request_number'].toString().startsWith('LN'))
            return LawnRequest.fromMap(serviceRequest);
        },
      ));

      return serviceRequests;
    }

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<List<ServiceRequest>> fetchServiceRequests(
      {List<String> filters = const []}) async {
    final userPath = _getUserPath(Account.currentUser);

    String filtersURI = '';
    filters.forEach((filter) => filtersURI += '$filter+');

    final data = await MainAPI().get('$userPath/requests?filter=$filtersURI');

    if (data != null) {
      final serviceRequests = List<ServiceRequest>.from(data.map(
        (serviceRequest) {
          if (serviceRequest['request_number'].toString().startsWith('SN'))
            return SnowRequest.fromMap(serviceRequest);
          if (serviceRequest['request_number'].toString().startsWith('LN'))
            return LawnRequest.fromMap(serviceRequest);
        },
      ));

      return serviceRequests;
    }

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<ServiceRequest> fetchServiceRequest(
      ServiceRequest serviceRequest) async {
    final userPath = _getUserPath(Account.currentUser);
    String path;

    if (Account.currentUser is Provider) {
      path =
          '$userPath/requests/${serviceRequest.id}?request_number=${serviceRequest.requestNumber}';
    }
    if (Account.currentUser is Customer) {
      final servicePath = _getServicePath(serviceRequest);
      path = '$userPath$servicePath/${serviceRequest.id}';
    }

    if (path == null) throw APIError(message: 'Path is null.');

    final data = await MainAPI().get(path);

    if (data != null) {
      if (data['request_number'].toString().startsWith('SN'))
        return SnowRequest.fromMap(data);
      if (data['request_number'].toString().startsWith('LN'))
        return LawnRequest.fromMap(data);
    }

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<ServiceRequest> postServiceRequest(
    ServiceRequest serviceRequest, {
    @required List<File> customerImages,
  }) async {
    final servicePath = _getServicePath(serviceRequest);

    final data = await MainAPI().post(
      '$customerPath$servicePath',
      serviceRequest.toMap(),
      files: customerImages,
      field: 'customer_images[]',
    );

    if (serviceRequest is SnowRequest) return SnowRequest.fromMap(data);
    if (serviceRequest is LawnRequest) return LawnRequest.fromMap(data);

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<ServiceRequest> updateServiceRequest(
    ServiceRequest serviceRequest,
  ) async {
    final servicePath = _getServicePath(serviceRequest);

    final data = await MainAPI().put(
        '$customerPath$servicePath/${serviceRequest.id}',
        serviceRequest.toMap());

    if (serviceRequest is SnowRequest) return SnowRequest.fromMap(data);
    if (serviceRequest is LawnRequest) return LawnRequest.fromMap(data);

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<ServiceRequest> confirmServiceRequest(
    ServiceRequest serviceRequest,
  ) async {
    final servicePath = _getServicePath(serviceRequest);

    final data = await MainAPI().post(
      '$customerPath$servicePath/${serviceRequest.id}/confirm',
      serviceRequest.toMap(),
    );

    if (serviceRequest is SnowRequest) return SnowRequest.fromMap(data);
    if (serviceRequest is LawnRequest) return LawnRequest.fromMap(data);

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<ServiceRequest> acceptServiceRequest(
    ServiceRequest serviceRequest,
  ) async {
    final data = await MainAPI().post(
      '$providerPath/requests/${serviceRequest.id}/accept?request_number=${serviceRequest.requestNumber}',
      serviceRequest.toMap(),
    );

    if (serviceRequest is SnowRequest) return SnowRequest.fromMap(data);
    if (serviceRequest is LawnRequest) return LawnRequest.fromMap(data);

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<ServiceRequest> cancelCustomerServiceRequest(
    ServiceRequest serviceRequest,
  ) async {
    final servicePath = _getServicePath(serviceRequest);

    final data = await MainAPI().post(
      '$customerPath$servicePath/${serviceRequest.id}/cancel',
      serviceRequest.toMap(),
    );

    if (serviceRequest is SnowRequest) return SnowRequest.fromMap(data);
    if (serviceRequest is LawnRequest) return LawnRequest.fromMap(data);

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<ServiceRequest> startServiceRequest(
    ServiceRequest serviceRequest, {
    @required List<File> providerBeforeImages,
  }) async {
    final data = await MainAPI().post(
      '$providerPath/requests/${serviceRequest.id}/start?request_number=${serviceRequest.requestNumber}',
      serviceRequest.toMap(),
      files: providerBeforeImages,
      field: 'provider_before_images[]',
    );

    if (serviceRequest is SnowRequest) return SnowRequest.fromMap(data);
    if (serviceRequest is LawnRequest) return LawnRequest.fromMap(data);

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<ServiceRequest> completeServiceRequest(
    ServiceRequest serviceRequest, {
    @required List<File> providerAfterImages,
  }) async {
    final data = await MainAPI().post(
      '$providerPath/requests/${serviceRequest.id}/complete?request_number=${serviceRequest.requestNumber}',
      serviceRequest.toMap(),
      files: providerAfterImages,
      field: 'provider_after_images[]',
    );

    if (serviceRequest is SnowRequest) return SnowRequest.fromMap(data);
    if (serviceRequest is LawnRequest) return LawnRequest.fromMap(data);

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<bool> cancelProviderServiceRequest(
    ServiceRequest serviceRequest,
  ) async {
    final data = await MainAPI().post(
      '$providerPath/requests/${serviceRequest.id}/cancel?request_number=${serviceRequest.requestNumber}',
      serviceRequest.toMap(),
    );

    return data != null;
  }

  String _getUserPath(Account user) {
    if (user == null) throw APIError(message: 'User is not autheticated.');

    if (user is Customer) return customerPath;
    if (user is Provider) return providerPath;

    throw APIError(message: 'User account is not supported.');
  }

  String _getServicePath(ServiceRequest serviceRequest) {
    if (serviceRequest is SnowRequest) return '/snow-requests';
    if (serviceRequest is LawnRequest) return '/lawn-requests';

    throw APIError(message: 'Service request is not supported.');
  }
}
