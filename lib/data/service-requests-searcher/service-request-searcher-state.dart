import 'package:ServiceHub/models/api-error.dart';
import 'package:equatable/equatable.dart';

import 'package:ServiceHub/models/service-request.dart';

abstract class ServiceRequestSearcherState extends Equatable {}

class ServiceRequestSearcherInitState extends ServiceRequestSearcherState {
  @override
  List<Object> get props => [];
}

class ServiceRequestsSearchedState extends ServiceRequestSearcherState {
  final List<ServiceRequest> serviceRequests;

  ServiceRequestsSearchedState(this.serviceRequests);

  @override
  List<Object> get props => [serviceRequests];

  @override
  String toString() =>
      'ServiceRequestsFetchedState(serviceRequests: $serviceRequests)';
}

class ServiceRequestsSearchingState extends ServiceRequestSearcherState {
  final String message;

  ServiceRequestsSearchingState({this.message = 'Loading...'});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ServiceRequestsSearchingState(message: $message)';
}

class ServiceRequestsSearchFailureState extends ServiceRequestSearcherState {
  final APIError apiError;

  ServiceRequestsSearchFailureState(this.apiError);

  @override
  List<Object> get props => [apiError];

  @override
  String toString() => 'ServiceRequestsSearchFailureState(message: $apiError)';
}
