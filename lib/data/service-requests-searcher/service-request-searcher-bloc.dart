import 'package:ServiceHub/api/service-request-api.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'service-request-searcher.dart';

class ServiceRequestSearcherBloc
    extends Bloc<ServiceRequestSearcherEvent, ServiceRequestSearcherState> {
  final _serviceRequestAPI = ServiceRequestAPI();

  ServiceRequestSearcherBloc() : super(ServiceRequestSearcherInitState());

  @override
  Stream<ServiceRequestSearcherState> mapEventToState(
      ServiceRequestSearcherEvent event) async* {
    if (event is ResetServiceRequestSearcher) {
      yield ServiceRequestSearcherInitState();
    } else if (event is SearchServiceRequests) {
      yield* _mapSearchServiceRequestsToState(event);
    }
  }

  Stream<ServiceRequestSearcherState> _mapSearchServiceRequestsToState(
      SearchServiceRequests event) async* {
    try {
      yield ServiceRequestsSearchingState();
      final data = await _serviceRequestAPI.searchServiceRequests(
          filters: event.filters);

      if (data != null) {
        yield ServiceRequestsSearchedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ServiceRequestsSearchFailureState(apiError);
    } catch (error) {
      yield ServiceRequestsSearchFailureState(
          APIError(message: error.toString()));
    }
  }
}
