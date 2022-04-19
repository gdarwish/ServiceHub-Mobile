import 'package:ServiceHub/models/api-error.dart';
import 'package:ServiceHub/models/review.dart';
import 'package:equatable/equatable.dart';

abstract class ReviewState extends Equatable {}

class ReviewInitState extends ReviewState {
  @override
  List<Object> get props => [];
}

class ReviewsFetchedState extends ReviewState {
  final List<Review> reviews;

  ReviewsFetchedState(this.reviews);

  @override
  List<Object> get props => [reviews];

  @override
  String toString() => 'ReviewsFetchedState(reviews: $reviews)';
}

class ReviewFetchedState extends ReviewState {
  final Review review;

  ReviewFetchedState(this.review);

  @override
  List<Object> get props => [review];

  @override
  String toString() => 'ReviewFetchedState(review: $review)';
}

class ReviewsFetchingState extends ReviewState {
  final String message;

  ReviewsFetchingState({this.message = 'Loading...'});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ReviewsFetchingState(message: $message)';
}

class ReviewPostingState extends ReviewState {
  final String message;

  ReviewPostingState({this.message = 'Loading...'});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'ReviewPostingState(message: $message)';
}

class ReviewPostedState extends ReviewState {
  final Review review;

  ReviewPostedState(this.review);

  @override
  List<Object> get props => [review];

  @override
  String toString() => 'ReviewPostedState(Review: $Review)';
}

class ReviewFailureState extends ReviewState {
  final APIError apiError;

  ReviewFailureState(this.apiError);

  @override
  List<Object> get props => [apiError];

  @override
  String toString() => 'ReviewsFailureState(message: $apiError)';
}
