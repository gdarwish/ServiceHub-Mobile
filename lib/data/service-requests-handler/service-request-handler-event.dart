import 'dart:io';

import 'package:equatable/equatable.dart';

import 'package:ServiceHub/models/service-request.dart';
import 'package:flutter/foundation.dart';

abstract class ServiceRequestHandlerEvent extends Equatable {
  final ServiceRequest serviceRequest;

  ServiceRequestHandlerEvent(this.serviceRequest);

  @override
  List<Object> get props => [serviceRequest];

  @override
  String toString() =>
      'ServiceRequestHandlerEvent(serviceRequest: $serviceRequest)';
}

class ResetServiceRequestHandler extends ServiceRequestHandlerEvent {
  ResetServiceRequestHandler() : super(null);

  @override
  List<Object> get props => [];
  @override
  String toString() => 'ResetServiceRequestHandler';
}

// Customer
class PostServiceRequest extends ServiceRequestHandlerEvent {
  final List<File> customerImages;
  PostServiceRequest(
    ServiceRequest serviceRequest, {
    @required this.customerImages,
  }) : super(serviceRequest);

  @override
  String toString() => 'PostServiceRequest(customerImages: $customerImages)';
}

class UpdateServiceRequest extends ServiceRequestHandlerEvent {
  UpdateServiceRequest(ServiceRequest serviceRequest) : super(serviceRequest);
  @override
  String toString() => 'UpdateServiceRequest(serviceRequest: $serviceRequest)';
}

class CancelCustomerServiceRequest extends ServiceRequestHandlerEvent {
  CancelCustomerServiceRequest(ServiceRequest serviceRequest)
      : super(serviceRequest);
  @override
  String toString() =>
      'CancelCustomerServiceRequest(serviceRequest: $serviceRequest)';
}

class ConfirmServiceRequest extends ServiceRequestHandlerEvent {
  ConfirmServiceRequest(ServiceRequest serviceRequest) : super(serviceRequest);
  @override
  String toString() => 'ConfirmServiceRequest(serviceRequest: $serviceRequest)';
}

// Provider
class AcceptServiceRequest extends ServiceRequestHandlerEvent {
  AcceptServiceRequest(ServiceRequest serviceRequest) : super(serviceRequest);
  @override
  String toString() => 'AcceptServiceRequest(serviceRequest: $serviceRequest)';
}

class StartServiceRequest extends ServiceRequestHandlerEvent {
  final List<File> providerBeforeImages;
  StartServiceRequest(ServiceRequest serviceRequest,
      {this.providerBeforeImages})
      : super(serviceRequest);

  @override
  String toString() =>
      'StartServiceRequest(providerBeforeImages: $providerBeforeImages)';
}

class CompleteServiceRequest extends ServiceRequestHandlerEvent {
  final List<File> providerAfterImages;
  CompleteServiceRequest(ServiceRequest serviceRequest,
      {this.providerAfterImages})
      : super(serviceRequest);
  @override
  String toString() =>
      'CompleteServiceRequest(providerAfterImages: $providerAfterImages)';
}

class CancelProviderServiceRequest extends ServiceRequestHandlerEvent {
  CancelProviderServiceRequest(ServiceRequest serviceRequest)
      : super(serviceRequest);
  @override
  String toString() =>
      'CancelProviderServiceRequest(serviceRequest: $serviceRequest)';
}
