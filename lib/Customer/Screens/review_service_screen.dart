import 'package:ServiceHub/Customer/Widgets/detail_row.dart';
import 'package:ServiceHub/Customer/Widgets/lawn_detail_card.dart';
import 'package:ServiceHub/Customer/Widgets/payment_action_sheet.dart';
import 'package:ServiceHub/Customer/Widgets/snow_detail_card.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/models/lawn-request.dart';
import 'package:ServiceHub/models/payment.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/models/snow-request.dart';
import 'package:ServiceHub/Customer/Widgets/additional_info_card.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/custom_stepper.dart';
import 'package:ServiceHub/mutual_widgets/image_slider.dart';
import 'package:ServiceHub/mutual_widgets/main_button.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../constants.dart';
import 'customer_main_screen.dart';

class ReviewServiceScreen extends StatelessWidget {
  static const route = '/ReviewServiceScreen';

  final ServiceRequest serviceRequest;

  ReviewServiceScreen(this.serviceRequest, {Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String title = 'Service Request';
    if (serviceRequest is SnowRequest) title = 'Snow Removing';
    if (serviceRequest is LawnRequest) title = 'Lawn Mowing';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child:
            BlocConsumer<ServiceRequestHandlerBloc, ServiceRequestHandlerState>(
          listener: (context, state) {
            if (state is ServiceRequestPostedState) {
              successSnackBar(
                'Service request has been posted.',
                context,
              );
              BlocProvider.of<ServiceRequestFetcherBloc>(context)
                  .add(FetchServiceRequests());
              Navigator.pushNamedAndRemoveUntil(
                  context, CustomerMainScreen.route, (route) => false);
            }
            if (state is ServiceRequestsHandlerFailureState) {
              failureSnackBar(
                state.apiError.message,
                context,
              );
            }
          },
          builder: (context, state) {
            if (state is ServiceRequestProcessing) {
              return CustomProgressIndicator();
            }
            return _buildReviewServiceScreen(context);
          },
        ),
      ),
    );
  }

  Widget _buildReviewServiceScreen(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                spacer(height: 10.0),
                CustomStepper(
                  serviceDetail: true,
                  reviewAndPayment: false,
                ),
                spacer(height: 10.0),
                ImageSliser(
                  fileImages: serviceRequest.localImages,
                ),
                Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Price
                        detailRow(
                          FontAwesomeIcons.dollarSign,
                          serviceRequest.fPrice,
                        ),
                        spacer(height: 10),
                        // Date
                        detailRow(FontAwesomeIcons.clock, serviceRequest.fDate),
                        spacer(height: 10),
                        // Address
                        detailRow(FontAwesomeIcons.mapPin,
                            serviceRequest.address.formattedAddress),
                        spacer(height: 10),
                        // Phone Num
                        detailRow(FontAwesomeIcons.phone,
                            serviceRequest.address.fPhone),
                        spacer(),
                        Text(
                          'Instraction',
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
                        addInfoCard(serviceRequest.instructions ?? ''),
                        spacer(),
                        Text(
                          'Payment',
                          style: kheaderDetailStyle,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: PaymentActionSheet(),
                        ),
                        spacer(),
                        mainBtn(
                          'Publish',
                          () {
                            // fake payment :)
                            serviceRequest.payment = Payment(id: 1);

                            BlocProvider.of<ServiceRequestHandlerBloc>(context)
                                .add(PostServiceRequest(
                              serviceRequest,
                              customerImages: serviceRequest.localImages,
                            ));
                          },
                        ),
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
  }
}
