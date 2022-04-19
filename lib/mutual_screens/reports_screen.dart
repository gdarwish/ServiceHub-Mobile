import 'package:ServiceHub/constants.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/mutual_screens/error_screen500.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/report_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'no_data_screen.dart';

class ReportsScreen extends StatelessWidget {
  static const route = '/ReportsScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Reports'),
      ),
      body: BlocConsumer<ReportBloc, ReportState>(
        listener: (context, state) {},
        buildWhen: (before, state) {
          if (state is ReportPostedState || state is ReportPostingState) {
            return false;
          }
          return true;
        },
        builder: (context, state) {
          if (state is ReportInitState ||
              state is ReportPostedState ||
              state is ReportPostingState) {
            _fetchReports(context);
            return Container();
          }
          if (state is ReportsFetchingState) {
            return CustomProgressIndicator();
          }
          if (state is ReportsFetchedState) {
            final reports = state.reports;

            if (reports.isNotEmpty)
              return RefreshIndicator(
                onRefresh: () async => _fetchReports(context),
                child: ListView(
                  padding: EdgeInsets.all(8),
                  children:
                      reports.map((report) => ReportCard(report)).toList(),
                ),
              );

            if (reports.isEmpty)
              return NoDataScreen(
                message: 'You currently don\'t have any Reports!',
                onRefresh: _fetchReports,
              );
          }

          return ErrorScreen500(onRefresh: _fetchReports);
        },
      ),
    );
  }

  void _fetchReports(BuildContext context) {
    BlocProvider.of<ReportBloc>(context).add(FetchReports());
  }
}
