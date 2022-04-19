import 'package:ServiceHub/api/connection.dart';
import 'package:ServiceHub/api/review-api.dart';
import 'package:ServiceHub/data/review/review.dart';
import 'package:ServiceHub/db/review-db.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/review.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ReviewBloc extends Bloc<ReviewEvent, ReviewState> {
  final _reviewAPI = ReviewAPI();
  final _reviewDB = ReviewDB();

  ReviewBloc() : super(ReviewInitState());

  @override
  Stream<ReviewState> mapEventToState(ReviewEvent event) async* {
    if (event is ResetReview) {
      yield ReviewInitState();
    } else if (event is FetchReviews) {
      yield* _mapFetchReviewsToState(event);
    } else if (event is FetchReview) {
      yield* _mapFetchReviewToState(event);
    } else if (event is PostReview) {
      yield* _mapPostReviewToState(event);
    }
  }

  Stream<ReviewState> _mapFetchReviewToState(FetchReview event) async* {
    try {
      yield ReviewsFetchingState();
      // return same review (reviews are immutable :)
      Review data = event.review;

      // final isConnected = await Connection().isConnected();
      // if (isConnected) {
      //   data = await _reviewAPI.fetchReview(event.review);
      // } else {
      //   // return same review
      //   data = event.review;
      // }

      if (data != null && data is Review) {
        yield ReviewFetchedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ReviewFailureState(apiError);
    } catch (error) {
      yield ReviewFailureState(APIError(message: error.toString()));
    }
  }

  Stream<ReviewState> _mapFetchReviewsToState(FetchReviews event) async* {
    try {
      yield ReviewsFetchingState();
      List<Review> data;

      final isConnected = await Connection().isConnected();
      if (isConnected) {
        data = await _reviewAPI.fetchReviews();
      } else {
        data = await _reviewDB.getReviews();
      }

      if (data != null && data is List<Review>) {
        yield ReviewsFetchedState(data);
        // Update user reviews
        Account.currentUser.reviews = data;

        // Update local records
        if (isConnected) _reviewDB.saveReviews(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ReviewFailureState(apiError);
    } catch (error) {
      yield ReviewFailureState(APIError(message: error.toString()));
    }
  }

  Stream<ReviewState> _mapPostReviewToState(PostReview event) async* {
    try {
      yield ReviewsFetchingState();
      final data = await _reviewAPI.postReview(event.review);
      if (data != null && data is Review) {
        yield ReviewPostedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield ReviewFailureState(apiError);
    } catch (error) {
      yield ReviewFailureState(APIError(message: error.toString()));
    }
  }
}
