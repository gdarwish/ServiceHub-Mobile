import 'package:ServiceHub/constants.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/mutual_screens/edit_profile_screen.dart';
import 'package:ServiceHub/mutual_screens/error_screen500.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/profile_image_placeholder.dart';
import 'package:ServiceHub/mutual_widgets/profile_review_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'no_data_screen.dart';

class ProfileScreen extends StatefulWidget {
  static const route = '/ProfileScreen';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Account.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              FontAwesomeIcons.userEdit,
              color: Colors.white,
            ),
            onPressed: () async {
              // go to edit user screen
              await Navigator.pushNamed(context, EditProfileScreen.route);
              setState(() {});
            },
          )
        ],
      ),
      body: BlocBuilder<UserBloc, UserState>(
          // buildWhen: (before, current) => current is UserUpdated,
          builder: (context, state) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: Column(
                children: [
                  ProfileImagePlaceholder(imageURL: user?.imageURL),
                  SizedBox(
                    height: 7,
                  ),
                  Text(
                    user?.fullName ?? '',
                    style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'OpenSans',
                    ),
                  ),
                  Text(user?.email ?? ''),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.star,
                        size: 40.0,
                        color: kPrimaryColor,
                      ),
                      BlocBuilder<ReviewBloc, ReviewState>(
                        buildWhen: (before, current) =>
                            current is ReviewsFetchedState,
                        builder: (context, state) {
                          return Text(
                            user.averageRating,
                            style: TextStyle(
                                fontSize: 25.0, fontWeight: FontWeight.w400),
                          );
                        },
                      ),
                    ],
                  )
                ],
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Expanded(
              child: Container(
                height: MediaQuery.of(context).size.height,
                child: BlocConsumer<ReviewBloc, ReviewState>(
                  listener: (context, state) {},
                  builder: (context, state) {
                    if (state is ReviewInitState ||
                        state is ReviewPostingState ||
                        state is ReviewPostedState) {
                      _fetchReviews(context);
                      return Container();
                    }
                    if (state is ReviewsFetchingState) {
                      return CustomProgressIndicator();
                    }

                    if (state is ReviewsFetchedState) {
                      if (state.reviews.isNotEmpty)
                        return RefreshIndicator(
                          onRefresh: () async => _fetchReviews(context),
                          child: ListView(
                            children: state.reviews
                                .map((review) =>
                                    ProfileReviewCard(review: review))
                                .toList(),
                          ),
                        );
                      if (state.reviews.isEmpty)
                        return NoDataScreen(
                          message: 'You currently don\'t have any Reviews!',
                          onRefresh: _fetchReviews,
                        );
                    }

                    return ErrorScreen500(onRefresh: _fetchReviews);
                  },
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  void _fetchReviews(BuildContext context) {
    BlocProvider.of<ReviewBloc>(context).add(FetchReviews());
  }
}
