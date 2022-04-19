import 'package:ServiceHub/api/connection.dart';
import 'package:ServiceHub/api/report-api.dart';
import 'package:ServiceHub/data/report/report-event.dart';
import 'package:ServiceHub/data/report/report-state.dart';
import 'package:ServiceHub/db/report-db.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:ServiceHub/models/report.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReportBloc extends Bloc<ReportEvent, ReportState> {
  final _reportAPI = ReportAPI();
  final _reportDB = ReportDB();

  ReportBloc() : super(ReportInitState());

  @override
  Stream<ReportState> mapEventToState(ReportEvent event) async* {
    if (event is ResetReport) {
      yield ReportInitState();
    } else if (event is FetchReports) {
      yield* _mapFetchReportsToState(event);
    } else if (event is FetchReport) {
      yield* _mapFetchReportToState(event);
    } else if (event is PostReport) {
      yield* _mapPostReportToState(event);
    }
  }

  Stream<ReportState> _mapFetchReportToState(FetchReport event) async* {
    try {
      yield ReportsFetchingState();
      Report data;

      final isConnected = await Connection().isConnected();
      if (isConnected) {
        data = await _reportAPI.fetchReport(event.report);
      } else {
        // return same report
        data = event.report;
      }

      if (data != null && data is Report) {
        yield ReportFetchedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ReportFailureState(apiError);
    } catch (error) {
      yield ReportFailureState(APIError(message: error.toString()));
    }
  }

  Stream<ReportState> _mapFetchReportsToState(FetchReports event) async* {
    try {
      yield ReportsFetchingState();
      List<Report> data;

      final isConnected = await Connection().isConnected();
      if (isConnected) {
        data = await _reportAPI.fetchReports();
      } else {
        data = await _reportDB.getReports();
      }

      if (data != null && data is List<Report>) {
        yield ReportsFetchedState(data);
        // Update local records
        if (isConnected) _reportDB.saveReports(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ReportFailureState(apiError);
    } catch (error) {
      yield ReportFailureState(APIError(message: error.toString()));
    }
  }

  Stream<ReportState> _mapPostReportToState(PostReport event) async* {
    try {
      yield ReportPostingState();
      final data = await _reportAPI.postReport(
        event.report,
        images: event.images,
        isBug: event.isBug,
      );
      if (data != null && data is Report) {
        yield ReportPostedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ReportFailureState(apiError);
    } catch (error) {
      yield ReportFailureState(APIError(message: error.toString()));
    }
  }
}
