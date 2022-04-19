import 'package:ServiceHub/models/api-error.dart';
import 'package:ServiceHub/models/report.dart';
import 'package:equatable/equatable.dart';

abstract class ReportState extends Equatable {}

class ReportInitState extends ReportState {
  @override
  List<Object> get props => [];
}

class ReportsFetchedState extends ReportState {
  final List<Report> reports;

  ReportsFetchedState(this.reports);

  @override
  List<Object> get props => [reports];

  @override
  String toString() => 'ReportsFetchedState(reports: $reports)';
}

class ReportFetchedState extends ReportState {
  final Report report;

  ReportFetchedState(this.report);

  @override
  List<Object> get props => [report];

  @override
  String toString() => 'ReportFetchedState(report: $report)';
}

class ReportsFetchingState extends ReportState {
  final String message;

  ReportsFetchingState({this.message = 'Loading...'});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ReportsFetchingState(message: $message)';
}

class ReportPostingState extends ReportState {
  final String message;

  ReportPostingState({this.message = 'Loading...'});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ReportPostingState(message: $message)';
}

class ReportPostedState extends ReportState {
  final Report report;

  ReportPostedState(this.report);

  @override
  List<Object> get props => [report];

  @override
  String toString() => 'ReportPostedState(report: $report)';
}

class ReportFailureState extends ReportState {
  final APIError apiError;

  ReportFailureState(this.apiError);

  @override
  List<Object> get props => [apiError];

  @override
  String toString() => 'ReportsFailureState(message: $apiError)';
}
