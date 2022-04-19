import 'package:ServiceHub/helper/detail_helper_methods.dart';
import 'package:ServiceHub/mutual_screens/have_service_request_screen.dart';
import 'package:ServiceHub/mutual_screens/no_data_screen.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/provider.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/models/settings.dart';
import 'package:ServiceHub/mutual_screens/error_screen500.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/service_request_card.dart';
import 'package:ServiceHub/mutual_widgets/service_request_card_grid.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  Position position;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ServiceRequestSearcherBloc,
        ServiceRequestSearcherState>(
      listener: (context, state) {
        if (state is ServiceRequestsSearchFailureState) {
          failureSnackBar(state.apiError.message, context);
        }
      },
      builder: (context, state) {
        final currentServiceRequest =
            (Account.currentUser as Provider).currentServiceRequest;
        if (state is ServiceRequestSearcherInitState &&
            currentServiceRequest == null) {
          _fetchServiceRequests(context);
          return Container();
        }
        if (state is ServiceRequestsSearchingState) {
          return CustomProgressIndicator();
        }

        if (currentServiceRequest != null) {
          return HaveServiceRequestContent();
        }

        // Set current position
        final currentPosition = position ?? Account.currentUser.position;

        if (currentPosition == null) {
          return Container(
            height: double.infinity,
            child: RefreshIndicator(
              child: ListView(
                children: [
                  SizedBox(height: 250),
                  Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      'Please give the app your location permission to search for service requests in your area.',
                    ),
                  ),
                ],
              ),
              onRefresh: () async => _fetchServiceRequests(context),
            ),
          );
        }

        if (state is ServiceRequestsSearchedState) {
          final serviceRequests = state.serviceRequests.where((serviceRequest) {
            final distance = HelperFunctions.calculateDistance(
              currentPosition.latitude,
              currentPosition.longitude,
              serviceRequest.address.latitude,
              serviceRequest.address.longitude,
            );
            print(distance);

            // Set service request distance
            serviceRequest.distance = distance;

            return distance <=
                (Settings().distanceFilter ?? 50); // distance (km)
          }).toList();
          // testDistance(serviceRequests);
          //
          // Show NO Item
          if (serviceRequests.isEmpty) {
            return NoDataScreen(
              message: 'There aren\'t any Service Requests in the area!',
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

  void _fetchServiceRequests(BuildContext context) async {
    final filters = [
      if (Settings().snowFilter) 'snow',
      if (Settings().lawnFilter) 'lawn',
    ];
    try {
      position = await HelperFunctions.determinePosition();
      if (position != null) {
        Account.currentUser.position = position;
        BlocProvider.of<ServiceRequestSearcherBloc>(context)
            .add(SearchServiceRequests(filters: filters));
      }
    } catch (error) {
      print(error.toString());
      failureSnackBar(error.toString(), context);
    }

    // BlocProvider.of<ServiceRequestSearcherBloc>(context)
    //     .add(SearchServiceRequests(filters: filters));
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
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 100) / 2;
    final double itemWidth = size.width / 2;

    return RefreshIndicator(
      onRefresh: () async => _fetchServiceRequests(context),
      child: GridView.count(
        // childAspectRatio: (itemWidth / itemHeight),
        childAspectRatio: 8.0 / 15.0,
        crossAxisCount: 2,
        mainAxisSpacing: 3.0,
        children: <Widget>[
          for (var i in serviceRequests) ServiceRequestCardGrid(i)
        ],
      ),
    );
  }

  void testDistance(List<ServiceRequest> serviceRequests) {
    for (var i = 0; i < serviceRequests.length - 1; i++) {
      final a1 = serviceRequests[i].address;
      final a2 = serviceRequests[i + 1].address;
      final d = HelperFunctions.calculateDistance(
          a1.latitude, a1.longitude, a2.latitude, a2.longitude);

      final test =
          HelperFunctions.calculateDistance(42.2812346, -83.0537431, 42.2983854, -83.0660166);
      print('Address A: ${a1.formattedAddress}');
      print('Address B: ${a2.formattedAddress}');
      print('Distance: $d');
      print('TEST: $test');
      print('------------------');
    }
  }

}
