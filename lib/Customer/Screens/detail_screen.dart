import 'package:ServiceHub/Customer/Screens/confirm_screen.dart';
import 'package:ServiceHub/Customer/Screens/edit_screen.dart';
import 'package:ServiceHub/Customer/Widgets/lawn_detail_card.dart';
import 'package:ServiceHub/Customer/Widgets/snow_detail_card.dart';
import 'package:ServiceHub/Customer/Widgets/detail_row.dart';
import 'package:ServiceHub/constants.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/helper/detail_helper_methods.dart';
import 'package:ServiceHub/models/lawn-request.dart';
import 'package:ServiceHub/models/request-status.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/models/snow-request.dart';
import 'package:ServiceHub/Customer/Widgets/additional_info_card.dart';
import 'package:ServiceHub/mutual_widgets/image_slider.dart';
import 'package:ServiceHub/mutual_widgets/menu_item.dart';
import 'package:ServiceHub/mutual_widgets/native_alert.dart';
import 'package:ServiceHub/mutual_screens/report_screen.dart';
import 'package:ServiceHub/mutual_widgets/secendary_button.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailScreen extends StatefulWidget {
  static const route = '/CustomerDetailScreen';

  final ServiceRequest serviceRequest;
  DetailScreen(this.serviceRequest, {Key key}) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    ServiceRequest serviceRequest = widget.serviceRequest;
    String title = 'Service Request';
    if (serviceRequest is SnowRequest) title = 'Snow Removing';
    if (serviceRequest is LawnRequest) title = 'Lawn Mowing';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        actions: <Widget>[
          if (serviceRequest.status.type != RequestStatusType.Pending)
            PopupMenuButton<String>(
              onSelected: appBarItemOnTap,
              itemBuilder: (BuildContext context) {
                return {'Report'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: MenuItem(text: choice, icon: FontAwesomeIcons.flag),
                  );
                }).toList();
              },
            ),
        ],
      ),
      body: SafeArea(
        child:
            BlocConsumer<ServiceRequestHandlerBloc, ServiceRequestHandlerState>(
                listener: (context, state) {
          if (state is ServiceRequestCustomerCanceledState) {
            serviceRequest = state.serviceRequest;
            successSnackBar('Service request has been canceled.', context);
            Navigator.pop(context);
          }
          if (state is ServiceRequestsHandlerFailureState) {
            failureSnackBar(state.apiError.message, context);
          }
        }, builder: (context, state) {
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
                              spacer(height: 10),
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
                              spacer(height: 10),
                              // Phone Num
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
                                // 'Please remove the snow from Driveway, Walkway, SideWalk, and apply salting.'
                                serviceRequest.instructions,
                              ),
                              spacer(),
                              if (serviceRequest.status.type ==
                                      RequestStatusType.Pending ||
                                  serviceRequest.status.type ==
                                      RequestStatusType.Active)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Cancel btn
                                    SecondaryButton(
                                      label: 'Cancel',
                                      icon: Icons.cancel,
                                      onTap: () {
                                        // TODO:: Cancel button
                                        nativeAlert(
                                          context: context,
                                          title: 'Cancel Request',
                                          body:
                                              'Are you sure you want to cancel the order?',
                                          btnText: 'Confirm',
                                          onTap: () {
                                            BlocProvider.of<
                                                        ServiceRequestHandlerBloc>(
                                                    context)
                                                .add(
                                              CancelCustomerServiceRequest(
                                                serviceRequest,
                                              ),
                                            );
                                            Navigator.pop(context);
                                          },
                                        );
                                      },
                                      color: kCancelButtonColor,
                                    ),
                                    // Edit Btn
                                    SecondaryButton(
                                      label: "Edit",
                                      icon: Icons.edit,
                                      color: kEditButtonColor,
                                      onTap: () async {
                                        // TODO:: Edit button
                                        await Navigator.of(context).pushNamed(
                                            EditScreen.route,
                                            arguments: serviceRequest);
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                ),

                              if (serviceRequest.status.type ==
                                  RequestStatusType.Completed)
                                Row(
                                  children: [
                                    // Confirm Btn
                                    SecondaryButton(
                                      label: 'Confirm',
                                      icon: Icons.check,
                                      color: kConfirmButtonColor,
                                      onTap: () async {
                                        // TODO:: Edit button
                                        await Navigator.pushNamed(
                                            context, ConfirmScreen.route,
                                            arguments: serviceRequest);
                                        setState(() {});
                                      },
                                    ),
                                  ],
                                )
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
        }),
      ),
    );
  }

  void appBarItemOnTap(String value) {
    switch (value) {
      case 'Report':
        Navigator.pushNamed(context, ReportScreen.route,
            arguments: widget.serviceRequest);
        break;
    }
  }
}
