import 'package:ServiceHub/db/main-db.dart';
import 'package:ServiceHub/models/review.dart';

class ReviewDB {
  static final ReviewDB _instance = ReviewDB._internal();

  factory ReviewDB() => _instance;

  ReviewDB._internal();

  Future<List<Review>> getReviews() async {
    List<Review> reviews = [];

    reviews = await MainDB().getAll<Review>(MainDB.ReviewBox);

    return reviews;
  }

  Future<void> saveReviews(List<Review> reviews) async {
    MainDB().insertAll<Review>(MainDB.ReviewBox, object: reviews);
  }
}
