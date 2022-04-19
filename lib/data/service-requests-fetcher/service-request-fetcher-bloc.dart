import 'package:ServiceHub/api/connection.dart';
import 'package:ServiceHub/api/service-request-api.dart';
import 'package:ServiceHub/data/service-requests-fetcher/service-request-fetcher.dart';
import 'package:ServiceHub/db/service-request-db.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'service-request-fetcher-event.dart';
import 'service-request-fetcher-state.dart';

class ServiceRequestFetcherBloc
    extends Bloc<ServiceRequestFetcherEvent, ServiceRequestFetcherState> {
  final _serviceRequestAPI = ServiceRequestAPI();
  final _serviceRequestDB = ServiceRequestDB();

  ServiceRequestFetcherBloc() : super(ServiceRequestFetcherInitState());

  @override
  Stream<ServiceRequestFetcherState> mapEventToState(
      ServiceRequestFetcherEvent event) async* {
    if (event is ResetServiceRequestFetcher) {
      yield ServiceRequestFetcherInitState();
    } else if (event is FetchServiceRequest) {
      yield* _mapFetchServiceRequestToState(event);
    } else if (event is FetchServiceRequests) {
      yield* _mapFetchServiceRequestsToState(event);
    }
  }

  Stream<ServiceRequestFetcherState> _mapFetchServiceRequestToState(
      FetchServiceRequest event) async* {
    try {
      yield ServiceRequestsFetchingState();
      ServiceRequest data;

      final isConnected = await Connection().isConnected();
      if (isConnected) {
        data =
            await _serviceRequestAPI.fetchServiceRequest(event.serviceRequest);
      } else {
        // return same service request
        data = event.serviceRequest;
      }

      if (data != null) {
        yield ServiceRequestFetchedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ServiceRequestsFetcherFailureState(apiError);
    } catch (error) {
      yield ServiceRequestsFetcherFailureState(
          APIError(message: error.toString()));
    }
  }

  Stream<ServiceRequestFetcherState> _mapFetchServiceRequestsToState(
      FetchServiceRequests event) async* {
    try {
      yield ServiceRequestsFetchingState();
      List<ServiceRequest> data;

      final isConnected = await Connection().isConnected();
      if (isConnected) {
        data = await _serviceRequestAPI.fetchServiceRequests(
          filters: event.filters,
        );
      } else {
        data = await _serviceRequestDB.getServiceRequests(
          filters: event.filters,
        );
      }

      if (data != null && data is List<ServiceRequest>) {
        yield ServiceRequestsFetchedState(data);
        // Update local records
        if (isConnected) _serviceRequestDB.saveServiceRequests(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ServiceRequestsFetcherFailureState(apiError);
    } catch (error) {
      yield ServiceRequestsFetcherFailureState(
          APIError(message: error.toString()));
    }
  }
}
