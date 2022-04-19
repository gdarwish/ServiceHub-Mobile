import 'dart:convert';

import 'package:ServiceHub/db/main-db.dart';
import 'package:flutter/foundation.dart';

import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/address.dart';
import 'package:ServiceHub/models/payment-method.dart';
import 'package:ServiceHub/models/report.dart';
import 'package:ServiceHub/models/review.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:hive/hive.dart';

part '../db/adapters/customer.g.dart';

@HiveType(typeId: MainDB.CustomerType)
class Customer extends Account {
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
  List<Address> addresses;
  @HiveField(10)
  List<PaymentMethod> paymentMethods = [];

  @override
  @HiveField(11)
  String stripeCustomer;

  Customer({
    this.id,
    this.firstName,
    this.lastName,
    this.imageURL,
    this.email,
    this.verified,
    this.reviews,
    this.reports,
    this.serviceRequests,
    this.addresses,
    this.paymentMethods,
    this.stripeCustomer,
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
          stripeCustomer: stripeCustomer,
        );

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
      'addresses': addresses?.map((x) => x?.toMap())?.toList(),
      'payment_methods': paymentMethods?.map((x) => x?.toMap())?.toList(),
      'stripe_customer': stripeCustomer,
    };
  }

  factory Customer.fromMap(Map map) {
    if (map == null) return null;

    final customer = Customer(
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
      serviceRequests: map['service_requests'] == null
          ? []
          : List<ServiceRequest>.from(
              map['service_requests']?.map((x) => ServiceRequest.fromMap(x))),
      addresses: map['addresses'] == null
          ? []
          : List<Address>.from(
              map['addresses']?.map((x) => Address.fromMap(x))),
      paymentMethods: map['payment_methods'] == null
          ? []
          : List<PaymentMethod>.from(
              map['payment_methods']?.map((x) => PaymentMethod.fromMap(x))),
      stripeCustomer: map['stripe_customer'],
    );

    return customer;
  }

  String toJson() => json.encode(toMap());

  factory Customer.fromJson(String source) =>
      Customer.fromMap(json.decode(source));

  @override
  String toString() =>
      'Customer(id: $id, firstName: $firstName, lastName: $lastName, imageURL: $imageURL, email: $email, verified: $verified, reviews: $reviews, reports: $reports, serviceRequests: $serviceRequests, addresses: $addresses, paymentMethods: $paymentMethods)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Customer &&
        listEquals(o.addresses, addresses) &&
        listEquals(o.paymentMethods, paymentMethods);
  }

  @override
  int get hashCode => addresses.hashCode ^ paymentMethods.hashCode;

  Address getSelectedAddress(Address serviceRequestAddress) {
    final exists = addresses.indexOf(serviceRequestAddress) != -1;
    return exists ? serviceRequestAddress : addresses.first;
  }
}
