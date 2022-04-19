import 'package:ServiceHub/models/review.dart';
import 'package:equatable/equatable.dart';

abstract class ReviewEvent extends Equatable {
  @override
  String toString() => 'ReviewEvent';
}

class ResetReview extends ReviewEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'ResetReview';
}

class FetchReviews extends ReviewEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'FetchReviews';
}

class FetchReview extends ReviewEvent {
  final Review review;

  FetchReview(this.review);

  @override
  List<Object> get props => [review];

  @override
  String toString() => 'FetchReview(review: $review)';
}

class PostReview extends ReviewEvent {
  final Review review;

  PostReview(this.review);

  @override
  List<Object> get props => [review];

  @override
  String toString() => 'PostReview(review: $review)';
}
