import 'package:ServiceHub/models/api-error.dart';
import 'package:equatable/equatable.dart';

import 'package:ServiceHub/models/service-request.dart';

abstract class ServiceRequestFetcherState extends Equatable {}

class ServiceRequestFetcherInitState extends ServiceRequestFetcherState {
  @override
  List<Object> get props => [];
}

class ServiceRequestsFetchedState extends ServiceRequestFetcherState {
  final List<ServiceRequest> serviceRequests;

  ServiceRequestsFetchedState(this.serviceRequests);

  @override
  List<Object> get props => [serviceRequests];

  @override
  String toString() =>
      'ServiceRequestsFetchedState(serviceRequests: $serviceRequests)';
}

class ServiceRequestFetchedState extends ServiceRequestFetcherState {
  final ServiceRequest serviceRequest;

  ServiceRequestFetchedState(this.serviceRequest);

  @override
  List<Object> get props => [serviceRequest];

  @override
  String toString() =>
      'ServiceRequestFetchedState(serviceRequest: $serviceRequest)';
}

class ServiceRequestsFetchingState extends ServiceRequestFetcherState {
  final String message;

  ServiceRequestsFetchingState({this.message = 'Loading...'});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ServiceRequestsFetchingState(message: $message)';
}

class ServiceRequestsFetcherFailureState extends ServiceRequestFetcherState {
  final APIError apiError;

  ServiceRequestsFetcherFailureState(this.apiError);

  @override
  List<Object> get props => [apiError];

  @override
  String toString() => 'ServiceRequestsFetcherFailureState(message: $apiError)';
}
