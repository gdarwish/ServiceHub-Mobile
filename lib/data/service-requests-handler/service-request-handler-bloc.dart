import 'package:ServiceHub/api/service-request-api.dart';
import 'package:ServiceHub/data/service-requests-handler/service-request-handler.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:ServiceHub/models/provider.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ServiceRequestHandlerBloc
    extends Bloc<ServiceRequestHandlerEvent, ServiceRequestHandlerState> {
  final _serviceRequestAPI = ServiceRequestAPI();

  ServiceRequestHandlerBloc() : super(ServiceRequestHandlerInitState());

  @override
  Stream<ServiceRequestHandlerState> mapEventToState(
      ServiceRequestHandlerEvent event) async* {
    if (event is ResetServiceRequestHandler) {
      yield ServiceRequestHandlerInitState();
    } else if (event is PostServiceRequest) {
      yield* _mapPostServiceRequestToState(event);
    } else if (event is UpdateServiceRequest) {
      yield* _mapUpdateServiceRequestToState(event);
    } else if (event is CancelCustomerServiceRequest) {
      yield* _mapCancelCustomerServiceRequestToState(event);
    } else if (event is ConfirmServiceRequest) {
      yield* _mapConfirmServiceRequestToState(event);
    } else if (event is AcceptServiceRequest) {
      yield* _mapAcceptServiceRequestToState(event);
    } else if (event is StartServiceRequest) {
      yield* _mapStartServiceRequestToState(event);
    } else if (event is CompleteServiceRequest) {
      yield* _mapCompleteServiceRequestToState(event);
    } else if (event is CancelProviderServiceRequest) {
      yield* _mapCancelProviderServiceRequestToState(event);
    }
  }

  Stream<ServiceRequestHandlerState> _mapPostServiceRequestToState(
      PostServiceRequest event) async* {
    try {
      yield ServiceRequestProcessing();
      final data = await _serviceRequestAPI.postServiceRequest(
          event.serviceRequest,
          customerImages: event.customerImages);
      if (data != null) {
        yield ServiceRequestPostedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ServiceRequestsHandlerFailureState(apiError);
    } catch (error) {
      yield ServiceRequestsHandlerFailureState(
          APIError(message: error.toString()));
    }
  }

  Stream<ServiceRequestHandlerState> _mapUpdateServiceRequestToState(
      UpdateServiceRequest event) async* {
    try {
      yield ServiceRequestProcessing();
      final data =
          await _serviceRequestAPI.updateServiceRequest(event.serviceRequest);
      if (data != null) {
        yield ServiceRequestUpdatedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ServiceRequestsHandlerFailureState(apiError);
    } catch (error) {
      yield ServiceRequestsHandlerFailureState(
          APIError(message: error.toString()));
    }
  }

  Stream<ServiceRequestHandlerState> _mapCancelCustomerServiceRequestToState(
      CancelCustomerServiceRequest event) async* {
    try {
      yield ServiceRequestProcessing();
      final data = await _serviceRequestAPI
          .cancelCustomerServiceRequest(event.serviceRequest);
      if (data != null) {
        yield ServiceRequestCustomerCanceledState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ServiceRequestsHandlerFailureState(apiError);
    } catch (error) {
      yield ServiceRequestsHandlerFailureState(
          APIError(message: error.toString()));
    }
  }

  Stream<ServiceRequestHandlerState> _mapConfirmServiceRequestToState(
      ConfirmServiceRequest event) async* {
    try {
      yield ServiceRequestProcessing();
      final data =
          await _serviceRequestAPI.confirmServiceRequest(event.serviceRequest);
      if (data != null) {
        yield ServiceRequestConfirmedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ServiceRequestsHandlerFailureState(apiError);
    } catch (error) {
      yield ServiceRequestsHandlerFailureState(
          APIError(message: error.toString()));
    }
  }

  Stream<ServiceRequestHandlerState> _mapAcceptServiceRequestToState(
      AcceptServiceRequest event) async* {
    try {
      yield ServiceRequestProcessing();
      final data =
          await _serviceRequestAPI.acceptServiceRequest(event.serviceRequest);
      if (data != null && data is ServiceRequest) {
        (Account.currentUser as Provider).requestNumber =
            event.serviceRequest.requestNumber;
        (Account.currentUser as Provider).currentServiceRequest = data;
        yield ServiceRequestAcceptedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ServiceRequestsHandlerFailureState(apiError);
    } catch (error) {
      yield ServiceRequestsHandlerFailureState(
          APIError(message: error.toString()));
    }
  }

  Stream<ServiceRequestHandlerState> _mapStartServiceRequestToState(
      StartServiceRequest event) async* {
    try {
      yield ServiceRequestProcessing();
      final data = await _serviceRequestAPI.startServiceRequest(
        event.serviceRequest,
        providerBeforeImages: event.providerBeforeImages,
      );
      if (data != null && data is ServiceRequest) {
        (Account.currentUser as Provider).currentServiceRequest = data;
        yield ServiceRequestStartedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ServiceRequestsHandlerFailureState(apiError);
    } catch (error) {
      yield ServiceRequestsHandlerFailureState(
          APIError(message: error.toString()));
    }
  }

  Stream<ServiceRequestHandlerState> _mapCompleteServiceRequestToState(
      CompleteServiceRequest event) async* {
    try {
      yield ServiceRequestProcessing();
      final data = await _serviceRequestAPI.completeServiceRequest(
        event.serviceRequest,
        providerAfterImages: event.providerAfterImages,
      );
      if (data != null) {
        (Account.currentUser as Provider).requestNumber = null;
        (Account.currentUser as Provider).currentServiceRequest = null;
        yield ServiceRequestCompeltedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ServiceRequestsHandlerFailureState(apiError);
    } catch (error) {
      yield ServiceRequestsHandlerFailureState(
          APIError(message: error.toString()));
    }
  }

  Stream<ServiceRequestHandlerState> _mapCancelProviderServiceRequestToState(
      CancelProviderServiceRequest event) async* {
    try {
      yield ServiceRequestProcessing();
      final data = await _serviceRequestAPI
          .cancelProviderServiceRequest(event.serviceRequest);
      if (data != null) {
        (Account.currentUser as Provider).requestNumber = null;
        (Account.currentUser as Provider).currentServiceRequest = null;
        yield ServiceRequestProviderCanceledState();
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ServiceRequestsHandlerFailureState(apiError);
    } catch (error) {
      yield ServiceRequestsHandlerFailureState(
          APIError(message: error.toString()));
    }
  }
}
