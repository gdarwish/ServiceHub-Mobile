import 'package:equatable/equatable.dart';

import 'package:ServiceHub/models/service-request.dart';

abstract class ServiceRequestFetcherEvent extends Equatable {
  @override
  String toString() => 'ServiceRequestFetcherEvent';
}

class ResetServiceRequestFetcher extends ServiceRequestFetcherEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'ResetServiceRequestFetcher';
}

class FetchServiceRequests extends ServiceRequestFetcherEvent {
  final List<String> filters;

  FetchServiceRequests({this.filters = const []});

  @override
  List<Object> get props => [filters];

  @override
  String toString() => 'FetchServiceRequests(filters: $filters)';
}

class FetchServiceRequest extends ServiceRequestFetcherEvent {
  final ServiceRequest serviceRequest;

  FetchServiceRequest(this.serviceRequest);

  @override
  List<Object> get props => [serviceRequest];

  @override
  String toString() => 'FetchServiceRequest(serviceRequest: $serviceRequest)';
}
