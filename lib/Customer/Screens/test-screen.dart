import 'package:ServiceHub/api/main-api.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/data/report/report.dart';
import 'package:ServiceHub/data/review/review-bloc.dart';
import 'package:ServiceHub/data/review/review.dart';
import 'package:ServiceHub/models/profile.dart';
import 'package:ServiceHub/models/report.dart';
import 'package:ServiceHub/models/review.dart';
import 'package:ServiceHub/models/snow-request.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TestScreen extends StatefulWidget {
  static const route = '/test';
  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  String text = 'Init';
  @override
  Widget build(BuildContext context) {
    /// TEST: Blocs

    BlocProvider.of<UserBloc>(context).add(
      CustomerLogin(email: 'contact@alidali.ca', password: 'password', rememberMe: true),
      // ProviderLogin(email: 'contact@alidali.ca', password: 'password'),
      // UserResetPassword(email: 'contact@alidali.ca'),
      // UserVerifyEmail(),
    );

    // BlocProvider.of<UserBloc>(context).add(
    //   UserRegister(
    //     firstName: 'Ali',
    //     lastName: 'Dali',
    //     email: 'contact@alidali.caf',
    //     password: 'password',
    //     passwordConfirmation: 'password',
    //   ),
    // );

    return Scaffold(
      body: BlocBuilder<UserBloc, UserState>(
        builder: (context, state) {
          if (state is UserAuthenticated) {
            // BlocProvider.of<ServiceRequestSearcherBloc>(context)
            //     .add(SearchServiceRequests(filters: []));

            // BlocProvider.of<ReportFetcherBloc>(context).add(FetchReports());

            // BlocProvider.of<ReportFetcherBloc>(context).add(
            //   PostReport(
            //     Report(
            //       userDetails: 'Test Mobile',
            //       serviceRequest: SnowRequest(requestNumber: 'SN45011143'),
            //     ),
            //     images: [],
            //   ),
            // );

            // BlocProvider.of<ReportBloc>(context).add(FetchReports());
            // BlocProvider.of<ReportBloc>(context).add(PostReport(Report(userDetails: 'TEST MOBILE'),images: [],isBug: true));

            // BlocProvider.of<ReviewBloc>(context).add(FetchReviews());
            // BlocProvider.of<ReviewBloc>(context).add(PostReview(Review(
            //   profile: Profile(id: 2),
            //   review: 'ASD',
            //   rating: 5,
            //   serviceRequest: SnowRequest(id: 1)
            // )));

            BlocProvider.of<ServiceRequestFetcherBloc>(context).add(FetchServiceRequests());

            return Text(MainAPI().token);
          }

          if (state is UserNotVerified) {
            BlocProvider.of<UserBloc>(context).add(UserVerifyEmail());
          }

          return Text(state.toString());
        },
      ),
    );
  }
}
