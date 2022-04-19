import 'package:ServiceHub/Customer/Widgets/confirm_review_button.dart';
import 'package:ServiceHub/constants.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/models/review.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/image_slider.dart';
import 'package:ServiceHub/mutual_widgets/main_button.dart';
import 'package:ServiceHub/mutual_widgets/multy_select_box.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'customer_main_screen.dart';

class ConfirmScreen extends StatefulWidget {
  static const route = '/ConfirmScreen';

  final ServiceRequest serviceRequest;
  ConfirmScreen(this.serviceRequest, {Key key}) : super(key: key);

  @override
  _ConfirmScreenState createState() => _ConfirmScreenState();
}

class _ConfirmScreenState extends State<ConfirmScreen> {
  bool after = true;
  final reviewControler = TextEditingController();
  final serviceRequestReview = Review(rating: 5, review: '');
  @override
  Widget build(BuildContext context) {
    serviceRequestReview.requestNumber = widget.serviceRequest.requestNumber;

    return Scaffold(
      appBar: AppBar(
        title: Text("Confirm and Review"),
      ),
      body: SafeArea(
        child:
            BlocConsumer<ServiceRequestHandlerBloc, ServiceRequestHandlerState>(
          listener: (context, state) {
            if (state is ServiceRequestConfirmedState) {
              Navigator.of(context).pushNamedAndRemoveUntil(
                  CustomerMainScreen.route, (route) => false);

              serviceRequestReview.review = reviewControler.text.trim();
              BlocProvider.of<ReviewBloc>(context).add(
                PostReview(serviceRequestReview),
              );
              successSnackBar('Service request has been confirmed.', context);
            }
            if (state is ServiceRequestsHandlerFailureState) {
              failureSnackBar(state.apiError.message, context);
            }
          },
          buildWhen: (before, current) =>
              !(current is ServiceRequestConfirmedState),
          builder: (context, state) {
            if (state is ServiceRequestProcessing) {
              return CustomProgressIndicator();
            }
            return _buildConfirmScreen(context);
          },
        ),
      ),
    );
  }

  Widget _buildConfirmScreen(BuildContext context) {
    final sliderImages = after
        ? widget.serviceRequest.providerAfterImages
        : widget.serviceRequest.providerBeforeImages;
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(vertical: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                ImageSliser(
                  networkImages: sliderImages,
                ),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: ConfirmReviewButton(
                          title: 'Before',
                          rectangleBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(15.0),
                                  bottomLeft: Radius.circular(15.0))),
                          color: !after ? kPrimaryColor : kPrimaryColorLight,
                          onTap: () {
                            setState(() {
                              after = false;
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: ConfirmReviewButton(
                          title: 'After',
                          rectangleBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(15.0),
                                  topRight: Radius.circular(15.0))),
                          color: after ? kPrimaryColor : kPrimaryColorLight,
                          onTap: () {
                            setState(() {
                              after = true;
                              print(after);
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                spacer(height: 30),
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
                    'Rate your experience with ${widget.serviceRequest.provider.firstName}',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 15.0,
                        fontFamily: 'OpenSans'),
                  ),
                ),
                spacer(height: 30),
                Center(
                  child: Text(
                    'Leave a review to ${widget.serviceRequest.provider.firstName}',
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
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: mainBtn(
                    'Submit',
                    () {
                      BlocProvider.of<ServiceRequestHandlerBloc>(context).add(
                        ConfirmServiceRequest(widget.serviceRequest),
                      );
                    },
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
