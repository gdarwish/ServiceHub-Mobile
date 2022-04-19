import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/db/settings-db.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/provider.dart';
import 'package:ServiceHub/models/request-status.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/models/settings.dart';
import 'package:ServiceHub/mutual_screens/error_screen500.dart';
import 'package:ServiceHub/mutual_widgets/add_alert_dialog.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/filter_alert_dialog_content.dart';
import 'package:ServiceHub/mutual_widgets/service_request_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'no_data_screen.dart';

class OrderHistoryScreen extends StatelessWidget {
  static const route = '/OrderHistoryScreen';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Order Hisroty'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.filter,
              color: Colors.white,
            ),
            onPressed: () {
              addAlertDialog(
                  context: context,
                  title: 'Filter By Service',
                  onTap: () => _filterServiceRequests(context),
                  mainBtnText: 'Filter',
                  content: FilterAlertDialog());
            },
          )
        ],
      ),
      body: BlocConsumer<ServiceRequestFetcherBloc, ServiceRequestFetcherState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is ServiceRequestFetcherInitState) {
            _fetchServiceRequests(context);
            return Container();
          }

          if (state is ServiceRequestsFetchingState) {
            return CustomProgressIndicator();
          }

          if (state is ServiceRequestsFetchedState) {
            final serviceRequests =
                state.serviceRequests.where((serviceRequest) {
              final requestTypes = [
                RequestStatusType.Confirmed,
                RequestStatusType.Canceled,
                if (Account.currentUser is Provider)
                  RequestStatusType.Completed,
              ];
              return requestTypes.contains(serviceRequest.status.type);
            }).toList();
            if (serviceRequests.isNotEmpty)
              return _buildOrderHistoryScreen(context, serviceRequests);

            if (serviceRequests.isEmpty)
              return NoDataScreen(
                message: 'You currently don\'t have any Service Requests!',
                onRefresh: _fetchServiceRequests,
              );
          }

          return ErrorScreen500(onRefresh: _fetchServiceRequests);
        },
      ),
    );
  }

  RefreshIndicator _buildOrderHistoryScreen(
      BuildContext context, List<ServiceRequest> serviceRequests) {
    return RefreshIndicator(
      onRefresh: () async => _fetchServiceRequests(context),
      child: ListView.builder(
        itemCount: serviceRequests.length,
        itemBuilder: (context, index) {
          final serviceRequest = serviceRequests[index];
          return ServiceRequestCard(serviceRequest);
        },
      ),
    );
  }

  void _fetchServiceRequests(BuildContext context) {
    BlocProvider.of<ServiceRequestFetcherBloc>(context)
        .add(FetchServiceRequests());
  }

  void _filterServiceRequests(BuildContext context) {
    // Save to DB
    SettingsDB().saveSettings(Settings());

    // Fetch new results
    final filters = [
      if (Settings().snowFilter) 'snow',
      if (Settings().lawnFilter) 'lawn',
    ];
    BlocProvider.of<ServiceRequestFetcherBloc>(context)
        .add(FetchServiceRequests(filters: filters));

    Navigator.pop(context);
  }
}
