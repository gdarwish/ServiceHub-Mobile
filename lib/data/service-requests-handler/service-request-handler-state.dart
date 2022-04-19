import 'package:ServiceHub/models/api-error.dart';
import 'package:equatable/equatable.dart';

import 'package:ServiceHub/models/service-request.dart';

abstract class ServiceRequestHandlerState extends Equatable {
  final ServiceRequest serviceRequest;

  ServiceRequestHandlerState(this.serviceRequest);

  List<Object> get props => [serviceRequest];

  @override
  String toString() =>
      'ServiceRequestHandlerState{serviceRequest: $serviceRequest}';
}

class ServiceRequestProcessing extends ServiceRequestHandlerState {
  final String message;
  ServiceRequestProcessing({this.message = 'Processing...', ServiceRequest serviceRequest})
      : super(serviceRequest);
  List<Object> get props => [serviceRequest, message];

  @override
  String toString() => 'ServiceRequestProcessing(message: $message)';
}

// Customer
class ServiceRequestHandlerInitState extends ServiceRequestHandlerState {
  ServiceRequestHandlerInitState({ServiceRequest serviceRequest})
      : super(serviceRequest);
}

class ServiceRequestPostedState extends ServiceRequestHandlerState {
  ServiceRequestPostedState(ServiceRequest serviceRequest)
      : super(serviceRequest);
}

class ServiceRequestUpdatedState extends ServiceRequestHandlerState {
  ServiceRequestUpdatedState(ServiceRequest serviceRequest)
      : super(serviceRequest);
}

class ServiceRequestCustomerCanceledState extends ServiceRequestHandlerState {
  ServiceRequestCustomerCanceledState(ServiceRequest serviceRequest)
      : super(serviceRequest);
}

class ServiceRequestConfirmedState extends ServiceRequestHandlerState {
  ServiceRequestConfirmedState(ServiceRequest serviceRequest)
      : super(serviceRequest);
}

// Provider
class ServiceRequestAcceptedState extends ServiceRequestHandlerState {
  ServiceRequestAcceptedState(ServiceRequest serviceRequest)
      : super(serviceRequest);
}

class ServiceRequestStartedState extends ServiceRequestHandlerState {
  ServiceRequestStartedState(ServiceRequest serviceRequest)
      : super(serviceRequest);
}

class ServiceRequestCompeltedState extends ServiceRequestHandlerState {
  ServiceRequestCompeltedState(ServiceRequest serviceRequest)
      : super(serviceRequest);
}

class ServiceRequestProviderCanceledState extends ServiceRequestHandlerState {
  ServiceRequestProviderCanceledState()
      : super(null);
}


class ServiceRequestsHandlerFailureState extends ServiceRequestHandlerState {
  final APIError apiError;

  ServiceRequestsHandlerFailureState(this.apiError,
      {ServiceRequest serviceRequest})
      : super(serviceRequest);

  @override
  List<Object> get props => [apiError];

  @override
  String toString() => 'ServiceRequestsHandlerFailureState(message: $apiError)';
}
