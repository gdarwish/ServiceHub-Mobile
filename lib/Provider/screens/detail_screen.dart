import 'package:ServiceHub/Customer/Widgets/additional_info_card.dart';
import 'package:ServiceHub/Customer/Widgets/detail_row.dart';
import 'package:ServiceHub/Customer/Widgets/lawn_detail_card.dart';
import 'package:ServiceHub/Customer/Widgets/snow_detail_card.dart';
import 'package:ServiceHub/Provider/screens/review_screen.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/data/service-requests-handler/service-request-handler-bloc.dart';
import 'package:ServiceHub/helper/detail_helper_methods.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/lawn-request.dart';
import 'package:ServiceHub/models/provider.dart';
import 'package:ServiceHub/models/request-status.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/models/snow-request.dart';
import 'package:ServiceHub/mutual_screens/report_screen.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/image_slider.dart';
import 'package:ServiceHub/mutual_widgets/main_button.dart';
import 'package:ServiceHub/mutual_widgets/menu_item.dart';
import 'package:ServiceHub/mutual_widgets/native_alert.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';

class DetailScreen extends StatelessWidget {
  static const route = '/ProviderDetailScreen';

  ServiceRequest serviceRequest;
  DetailScreen(this.serviceRequest, {Key key}) : super(key: key);
  ServiceRequest currentServiceRequest;

  ServiceRequest oldServiceRequest;

  @override
  Widget build(BuildContext context) {
    if (oldServiceRequest == null) oldServiceRequest = serviceRequest;

    String title = 'Service Request';
    if (serviceRequest is SnowRequest) title = 'Snow Removing';
    if (serviceRequest is LawnRequest) title = 'Lawn Mowing';
    void appBarItemOnTap(String value) {
      switch (value) {
        case 'Report':
          Navigator.pushNamed(context, ReportScreen.route,
              arguments: serviceRequest);
          break;
        case 'Cancel':
          nativeAlert(
            context: context,
            title: 'Cancel Service Request',
            body: 'Are you sure you want to cancel the service request?',
            btnText: 'Confirm',
            onTap: () {
              BlocProvider.of<ServiceRequestHandlerBloc>(context).add(
                CancelProviderServiceRequest(serviceRequest),
              );
              Navigator.pop(context);
            },
          );
      }
    }

    final provider = Account.currentUser as Provider;

    return BlocBuilder<ServiceRequestHandlerBloc, ServiceRequestHandlerState>(
        builder: (context, state) {
      currentServiceRequest =
          (Account.currentUser as Provider).currentServiceRequest;
      return Scaffold(
        appBar: AppBar(
          title: Text(title),
          actions: <Widget>[
            if (_showCustomerInfo())
              PopupMenuButton<String>(
                onSelected: appBarItemOnTap,
                itemBuilder: (BuildContext context) {
                  return {
                    'Report',
                    if (currentServiceRequest.status.type ==
                        RequestStatusType.Accepted)
                      'Cancel'
                  }.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: MenuItem(
                        text: choice,
                        icon: choice == 'Report'
                            ? FontAwesomeIcons.flag
                            : Icons.cancel,
                        color: choice == 'Cancel' ? kFailureColor : null,
                      ),
                    );
                  }).toList();
                },
              ),
          ],
        ),
        body: SafeArea(
          child: BlocConsumer<ServiceRequestHandlerBloc,
              ServiceRequestHandlerState>(
            listener: (context, state) {
              if (state is ServiceRequestAcceptedState) {
                successSnackBar('Service request has been accepted.', context);
              }
              if (state is ServiceRequestsHandlerFailureState) {
                failureSnackBar(state.apiError.message, context);
              }
              if (state is ServiceRequestProviderCanceledState) {
                Navigator.pop(context);
              }
            },
            buildWhen: (before, state) =>
                !(state is ServiceRequestProviderCanceledState),
            builder: (context, state) {
              if (state is ServiceRequestProcessing) {
                return CustomProgressIndicator();
              }

              if (provider.currentServiceRequest != null) {
                serviceRequest = provider.currentServiceRequest;
              } else {
                serviceRequest = oldServiceRequest;
              }

              return Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: double.infinity,
                    child: SingleChildScrollView(
                      physics: AlwaysScrollableScrollPhysics(),
                      padding: EdgeInsets.symmetric(
                        // horizontal: 0.0,
                        vertical: 20.0,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ImageSliser(
                            networkImages: serviceRequest.customerImages,
                          ),
                          Container(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Status
                                  Text(
                                    serviceRequest.status.title,
                                    style: TextStyle(
                                      fontSize: 25.0,
                                      color: serviceRequest.status.color,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  spacer(),
                                  // Price
                                  detailRow(
                                    FontAwesomeIcons.dollarSign,
                                    serviceRequest.fPrice,
                                  ),
                                  spacer(height: 10),
                                  // Date
                                  detailRow(
                                    FontAwesomeIcons.clock,
                                    serviceRequest.fDate,
                                  ),
                                  if (_showCustomerInfo()) spacer(height: 10),
                                  if (_showCustomerInfo())
                                    // Address
                                    detailRow(
                                      FontAwesomeIcons.mapPin,
                                      serviceRequest.address.formattedAddress,
                                      decoration: TextDecoration.underline,
                                      onTap: () {
                                        HelperFunctions.openMap(
                                          serviceRequest.address,
                                        );
                                      },
                                    ),
                                  if (_showCustomerInfo()) spacer(height: 10),
                                  // Phone Num
                                  if (_showCustomerInfo())
                                    detailRow(
                                      FontAwesomeIcons.phone,
                                      serviceRequest.address.fPhone,
                                      decoration: TextDecoration.underline,
                                      onTap: () {
                                        HelperFunctions.callNumber(
                                          number: serviceRequest.address.phone,
                                        );
                                      },
                                    ),
                                  // Distance (km)
                                  if (serviceRequest.distance > 0)
                                    spacer(height: 10),
                                  if (serviceRequest.distance > 0)
                                    detailRow(
                                      FontAwesomeIcons.directions,
                                      '(${serviceRequest.fDistance} km)',
                                    ),
                                  spacer(),
                                  Text(
                                    'Instructions',
                                    style: kheaderDetailStyle,
                                  ),

                                  // Snow Detail
                                  if (serviceRequest is SnowRequest)
                                    SnowDetailCard(serviceRequest),

                                  // Lawn Detail
                                  if (serviceRequest is LawnRequest)
                                    LawnDetailCard(serviceRequest),

                                  Text(
                                    'Additional info',
                                    style: kheaderDetailStyle,
                                  ),
                                  //Additional info
                                  addInfoCard(
                                      // TODO:: change to model
                                      'Please remove the snow from Driveway, Walkway, SideWalk, and apply salting.'),
                                  spacer(),

                                  _actionButton(context, serviceRequest),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      );
    });
  }

  Widget _actionButton(BuildContext context, ServiceRequest serviceRequest) {
    if (currentServiceRequest == null) {
      if (serviceRequest.status.type != RequestStatusType.Pending)
        return Container();
      return mainBtn(
        'Accept Service Request',
        () {
          // Start Job
          BlocProvider.of<ServiceRequestHandlerBloc>(context)
              .add(AcceptServiceRequest(serviceRequest));
        },
      );
    } else {
      if (currentServiceRequest.status.type == RequestStatusType.Accepted) {
        return mainBtn(
          'Start Service Request',
          () {
            Navigator.pushNamed(context, ReviewScreen.route);
          },
        );
      }
      if (currentServiceRequest.status.type == RequestStatusType.InProgress) {
        return mainBtn(
          'Complete Service Request',
          () {
            Navigator.pushNamed(context, ReviewScreen.route);
          },
        );
      }
    }

    return Container();
  }

  bool _showCustomerInfo() => currentServiceRequest != null;
}
