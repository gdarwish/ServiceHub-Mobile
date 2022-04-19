import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/provider.dart';
import 'package:ServiceHub/api/main-api.dart';
import 'package:ServiceHub/models/review.dart';

class ReviewAPI {
  static final ReviewAPI _instance = ReviewAPI._internal();

  factory ReviewAPI() => _instance;

  ReviewAPI._internal();

  final customerPath = '/customer';
  final providerPath = '/provider';

  Future<List<Review>> fetchReviews() async {
    final userPath = _getUserPath(Account.currentUser, fetching: true);

    final data = await MainAPI().get('$userPath/reviews');

    if (data != null) {
      return List<Review>.from(data.map((review) => Review.fromMap(review)));
    }

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<Review> fetchReview(Review review) async {
    final userPath = _getUserPath(Account.currentUser);

    final data = await MainAPI().get('$userPath/reviews/${review.id}');

    if (data != null) {
      return Review.fromMap(data);
    }

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<Review> postReview(Review review) async {
    final userPath = _getUserPath(Account.currentUser);

    final data = await MainAPI().post('$userPath/reviews', review.toMap());

    if (data != null) {
      return Review.fromMap(data);
    }

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  String _getUserPath(Account user, {bool fetching = false}) {
    if (user == null) throw APIError(message: 'User is not autheticated.');

    if (user is Customer) return fetching ? providerPath : customerPath;
    if (user is Provider) return fetching ? customerPath : providerPath;

    throw APIError(message: 'User account is not supported.');
  }
}
