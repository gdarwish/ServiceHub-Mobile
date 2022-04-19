import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/models/request-status.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/models/settings.dart';
import 'package:ServiceHub/mutual_screens/error_screen500.dart';
import 'package:ServiceHub/mutual_screens/no_data_screen.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/service_request_card.dart';
import 'package:ServiceHub/mutual_widgets/service_request_card_grid.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceRequestFetcherBloc, ServiceRequestFetcherState>(
      listener: (context, state) {
        if (state is ServiceRequestsFetcherFailureState) {
          failureSnackBar(state.apiError.message, context);
        }
      },
      builder: (context, state) {
        if (state is ServiceRequestFetcherInitState) {
          _fetchServiceRequests(context);
          return Container();
        }
        if (state is ServiceRequestsFetchingState) {
          return CustomProgressIndicator();
        }

        if (state is ServiceRequestsFetchedState) {
          final serviceRequests = state.serviceRequests.where((serviceRequest) {
            final requestTypes = [
              RequestStatusType.Confirmed,
              RequestStatusType.Canceled,
            ];
            return !requestTypes.contains(serviceRequest?.status?.type);
          }).toList();

          if (serviceRequests.isEmpty) {
            return NoDataScreen(
              message: 'You currently don\'t have any posted Service Requests!',
              onRefresh: _fetchServiceRequests,
            );
          }

          // Check Settings
          if (Settings().listStyle == 0) {
            // ListCard Code
            return _buildListServiceRequests(context, serviceRequests);
          } else {
            // GridCard Code
            return _buildGridServiceRequests(context, serviceRequests);
          }
        }

        return ErrorScreen500(onRefresh: _fetchServiceRequests);
      },
    );
  }

  void _fetchServiceRequests(BuildContext context) {
    BlocProvider.of<ServiceRequestFetcherBloc>(context)
        .add(FetchServiceRequests());
  }

  Widget _buildListServiceRequests(
    BuildContext context,
    List<ServiceRequest> serviceRequests,
  ) {
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

  Widget _buildGridServiceRequests(
    BuildContext context,
    List<ServiceRequest> serviceRequests,
  ) {
    // var size = MediaQuery.of(context).size;
    // final double itemHeight = (size.height - 50) / 2;
    // final double itemWidth = size.width / 2;

    return RefreshIndicator(
      onRefresh: () async => _fetchServiceRequests(context),
      child: SizedBox(
        child: GridView.count(
          // childAspectRatio: (itemWidth / itemHeight),
          childAspectRatio: 8.0 / 15.0,
          crossAxisCount: 2,
          mainAxisSpacing: 3.0,
          children: <Widget>[
            for (var serviceRequest in serviceRequests)
              ServiceRequestCardGrid(serviceRequest)
          ],
        ),
      ),
    );
  }
}
