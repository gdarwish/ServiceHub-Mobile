import 'package:flutter/foundation.dart';

import 'package:ServiceHub/models/report.dart';
import 'package:ServiceHub/models/review.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';

abstract class Account {
  static Account _currentUser;
  static Account get currentUser => _currentUser;
  static void setCurrentUser(Account user) => _currentUser = user;

  int id;
  String firstName;
  String lastName;
  String imageURL;
  String email;
  bool verified;
  List<Review> reviews;
  List<Report> reports;
  List<ServiceRequest> serviceRequests;

  String stripeCustomer;

  String get fullName => '$firstName $lastName';

  String get averageRating {
    final ratings = reviews.fold(0.0, (double lastRating, review) {
      print(review.rating);
      return review.rating + lastRating;
    });
    final average = ratings == 0 ? 0 : ratings / reviews.length;
    print(ratings);
    return NumberFormat('##.##').format(average);
  }

  Position position;

  Account({
    this.id,
    this.firstName,
    this.lastName,
    this.imageURL,
    this.email,
    this.verified,
    this.reviews,
    this.reports,
    this.serviceRequests,
    this.stripeCustomer,
  });

  Map<String, dynamic> toMap();

  @override
  String toString() {
    return 'Account(id: $id, firstName: $firstName, lastName: $lastName, imageURL: $imageURL, email: $email, verified: $verified, reviews: $reviews, reports: $reports, serviceRequests: $serviceRequests, stripeCustomer: $stripeCustomer)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Account &&
        o.id == id &&
        o.firstName == firstName &&
        o.lastName == lastName &&
        o.imageURL == imageURL &&
        o.email == email &&
        o.verified == verified &&
        o.stripeCustomer == stripeCustomer &&
        listEquals(o.reviews, reviews) &&
        listEquals(o.reports, reports) &&
        listEquals(o.serviceRequests, serviceRequests);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        firstName.hashCode ^
        lastName.hashCode ^
        imageURL.hashCode ^
        email.hashCode ^
        verified.hashCode ^
        reviews.hashCode ^
        reports.hashCode ^
        serviceRequests.hashCode ^
        stripeCustomer.hashCode;
  }
}
