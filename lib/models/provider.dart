import 'dart:convert';

import 'package:ServiceHub/db/main-db.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/lawn-request.dart';
import 'package:ServiceHub/models/report.dart';
import 'package:ServiceHub/models/review.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/models/snow-request.dart';
import 'package:hive/hive.dart';

part '../db/adapters/provider.g.dart';

@HiveType(typeId: MainDB.ProviderType)
class Provider extends Account {
  @override
  @HiveField(0)
  int id;

  @override
  @HiveField(1)
  String firstName;

  @override
  @HiveField(2)
  String lastName;

  @override
  @HiveField(3)
  String imageURL;

  @override
  @HiveField(4)
  String email;

  @override
  @HiveField(5)
  bool verified;

  @override
  @HiveField(6)
  List<Review> reviews;

  @override
  @HiveField(7)
  List<Report> reports;

  @override
  @HiveField(8)
  List<ServiceRequest> serviceRequests;

  @HiveField(9)
  String stripeId;

  @HiveField(10)
  String requestNumber;

  @HiveField(11)
  ServiceRequest currentServiceRequest;

  Provider({
    this.id,
    this.firstName,
    this.lastName,
    this.imageURL,
    this.email,
    this.verified,
    this.reviews,
    this.reports,
    this.serviceRequests,
    this.stripeId,
    this.requestNumber,
    this.currentServiceRequest,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          imageURL: imageURL,
          email: email,
          verified: verified,
          reviews: reviews,
          reports: reports,
          serviceRequests: serviceRequests,
        );

  Provider copyWith({
    String stripeId,
  }) {
    return Provider(
      stripeId: stripeId ?? this.stripeId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'image_url': imageURL,
      'email': email,
      'verified': verified,
      'reviews': reviews?.map((x) => x?.toMap())?.toList(),
      'reports': reports?.map((x) => x?.toMap())?.toList(),
      'service_requests': serviceRequests?.map((x) => x?.toMap())?.toList(),
      'stripe_id': stripeId,
      'request_number': requestNumber,
    };
  }

  factory Provider.fromMap(Map map) {
    if (map == null) return null;

    final provider = Provider(
      id: map['id'] ?? 0,
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      imageURL: map['image_url'],
      email: map['email'] ?? '',
      verified: map['verified'] ?? false,
      reviews: map['reviews'] == null
          ? []
          : List<Review>.from(map['reviews']?.map((x) => Review.fromMap(x))),
      reports: map['reports'] == null
          ? []
          : List<Report>.from(map['reports']?.map((x) => Report.fromMap(x))),
      // serviceRequests: map['service_requests'] == null
      //     ? []
      //     : List<ServiceRequest>.from(
      //         map['service_requests']?.map((x) => ServiceRequest.fromMap(x))),
      stripeId: map['stripe_id'],
      requestNumber: map['request_number'],
      // currentServiceRequest: (map['current_service_request'] == null ||
      //         map['request_number'] == null)
      //     ? null
      //     : map['request_number'].contains('SN')
      //         ? SnowRequest.fromMap(map['current_service_request'])
      //         : LawnRequest.fromMap(map['current_service_request']),
      currentServiceRequest: map['current_service_request'] == null
          ? null
          : ServiceRequest.fromMap(map['current_service_request']),
    );

    return provider;
  }

  String toJson() => json.encode(toMap());

  factory Provider.fromJson(String source) =>
      Provider.fromMap(json.decode(source));

  @override
  String toString() =>
      'Provider(id: $id, firstName: $firstName, lastName: $lastName, imageURL: $imageURL, email: $email, verified: $verified, reviews: $reviews, reports: $reports, serviceRequests: $serviceRequests, stripeId: $stripeId)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Provider && o.stripeId == stripeId;
  }

  @override
  int get hashCode => stripeId.hashCode;
}
