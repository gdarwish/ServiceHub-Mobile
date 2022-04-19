import 'package:equatable/equatable.dart';

abstract class ServiceRequestSearcherEvent extends Equatable {
  @override
  String toString() => 'ServiceRequestSearcherEvent';
}

class ResetServiceRequestSearcher extends ServiceRequestSearcherEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'ResetServiceRequestSearcher';
}

class SearchServiceRequests extends ServiceRequestSearcherEvent {
  final List<String> filters;

  SearchServiceRequests({this.filters = const []});

  @override
  List<Object> get props => [filters];

  @override
  String toString() => 'SearchServiceRequests(filters: $filters)';
}
