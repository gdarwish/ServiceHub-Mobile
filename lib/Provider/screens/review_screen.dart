import 'package:ServiceHub/Provider/screens/provider_main_screen.dart';
import 'package:ServiceHub/constants.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/provider.dart';
import 'package:ServiceHub/models/request-status.dart';
import 'package:ServiceHub/models/review.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/main_button.dart';
import 'package:ServiceHub/mutual_widgets/multy_image_slider.dart';
import 'package:ServiceHub/mutual_widgets/multy_select_box.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class ReviewScreen extends StatelessWidget {
  static const route = '/ReviewScreen';
  final review = Review(rating: 5, review: '');
  final reviewControler = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final serviceRequest =
        (Account.currentUser as Provider).currentServiceRequest;
    serviceRequest.localImages = [];
    review.requestNumber = serviceRequest.requestNumber;

    String title = 'Upload Images';
    if (serviceRequest.status.type == RequestStatusType.Accepted) {
      title = 'Upload Images to Start';
    }
    if (serviceRequest.status.type == RequestStatusType.InProgress) {
      title = 'Upload Images to Complete';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child:
            BlocConsumer<ServiceRequestHandlerBloc, ServiceRequestHandlerState>(
          listener: (context, state) {
            if (state is ServiceRequestStartedState) {
              successSnackBar('Service request has been started.', context);
              Navigator.pop(context);
            }
            if (state is ServiceRequestCompeltedState) {
              successSnackBar('Service request has been completed.', context);
              review.review = reviewControler.text.trim();
              BlocProvider.of<ReviewBloc>(context).add(PostReview(review));
              Navigator.pushNamedAndRemoveUntil(
                  context, ProviderMainScreen.route, (route) => false);
            }
          },
          builder: (context, state) {
            if (state is ServiceRequestProcessing) {
              return CustomProgressIndicator();
            }
            return Stack(
              children: <Widget>[
                Container(
                  height: double.infinity,
                  child: SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      vertical: 20.0,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MultyImageSliser(
                          images: serviceRequest.localImages,
                        ),
                        spacer(),
                        if (serviceRequest.status.type ==
                            RequestStatusType.InProgress)
                          ..._buildRatingWidgets(
                              context, serviceRequest, review),
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: mainBtn(
                            'Submit',
                            () {
                              if (serviceRequest.localImages.isEmpty ||
                                  serviceRequest.localImages.length > 10) {
                                failureSnackBar(
                                    'Please upload 1 to 10 images.', context);
                                return;
                              }

                              if (serviceRequest.status.type ==
                                  RequestStatusType.Accepted) {
                                BlocProvider.of<ServiceRequestHandlerBloc>(
                                        context)
                                    .add(
                                  StartServiceRequest(
                                    serviceRequest,
                                    providerBeforeImages:
                                        serviceRequest.localImages,
                                  ),
                                );
                              } else if (serviceRequest.status.type ==
                                  RequestStatusType.InProgress) {
                                BlocProvider.of<ServiceRequestHandlerBloc>(
                                        context)
                                    .add(
                                  CompleteServiceRequest(
                                    serviceRequest,
                                    providerAfterImages:
                                        serviceRequest.localImages,
                                  ),
                                );
                              }
                            },
                          ),
                        )
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
  }

  List<Widget> _buildRatingWidgets(
    BuildContext context,
    ServiceRequest serviceRequest,
    Review serviceRequestReview,
  ) {
    return [
      Center(
        child: RatingBar.builder(
          initialRating: serviceRequestReview.rating.toDouble(),
          minRating: 1,
          direction: Axis.horizontal,
          itemCount: 5,
          unratedColor: kPrimaryColorLight,
          itemSize: 50.0,
          itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
          itemBuilder: (context, _) => Icon(
            Icons.star,
            color: kPrimaryColor,
          ),
          onRatingUpdate: (rating) {
            serviceRequestReview.rating = rating.toInt();
          },
        ),
      ),
      Center(
        child: Text(
          'Rate your experience with ${serviceRequest.customer.firstName}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 15.0,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      spacer(height: 30),
      Center(
        child: Text(
          'Leave a review to ${serviceRequest.customer.firstName}',
          style: TextStyle(
            color: Colors.black,
            fontSize: 25.0,
            fontFamily: 'OpenSans',
          ),
        ),
      ),
      spacer(),
      MultySelectBox(reviewTextFieldController: reviewControler),
      spacer(),
    ];
  }
}
