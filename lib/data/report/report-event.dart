import 'dart:io';

import 'package:ServiceHub/models/report.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class ReportEvent extends Equatable {
  @override
  String toString() => 'ReportFetcherEvent';
}

class ResetReport extends ReportEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'ResetReport';
}

class FetchReports extends ReportEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'FetchReports';
}

class FetchReport extends ReportEvent {
  final Report report;

  FetchReport(this.report);

  @override
  List<Object> get props => [report];

  @override
  String toString() => 'FetchReport(report: $report)';
}

class PostReport extends ReportEvent {
  final Report report;
  final List<File> images;
  final bool isBug;

  PostReport(
    this.report, {
    @required this.images,
    this.isBug = false,
  });

  @override
  List<Object> get props => [report, images, isBug];

  @override
  String toString() =>
      'PostReport(report: $report, images: $images, isBug: $isBug)';
}
