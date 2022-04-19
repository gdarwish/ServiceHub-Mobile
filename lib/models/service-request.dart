import 'dart:io';

import 'package:ServiceHub/models/snow-request.dart';
import 'package:flutter/foundation.dart';

import 'package:ServiceHub/models/address.dart';
import 'package:ServiceHub/models/payment.dart';
import 'package:ServiceHub/models/profile.dart';
import 'package:ServiceHub/models/request-status.dart';
import 'package:intl/intl.dart';

import 'lawn-request.dart';

abstract class ServiceRequest {
  int id;
  String requestNumber;
  Profile customer;
  Profile provider;
  RequestStatus status;
  Address address;
  Payment payment;
  double price;
  String currency;
  DateTime date;
  String instructions;
  List<String> customerImages;
  List<String> providerBeforeImages;
  List<String> providerAfterImages;
  DateTime createdAt;

  List<File> localImages;

  String get fPrice => '\$${price?.toStringAsFixed(2)}';
  String get fDate => DateFormat.yMMMMd().add_jm().format(date);
  String get fCreatedAt => DateFormat.yMMMMd().format(createdAt);

  double distance = 0;
  String get fDistance => distance.toStringAsFixed(1);

  ServiceRequest({
    this.id,
    this.requestNumber,
    this.customer,
    this.provider,
    this.status,
    this.address,
    this.payment,
    this.price,
    this.currency,
    this.date,
    this.instructions,
    this.customerImages,
    this.providerBeforeImages,
    this.providerAfterImages,
    this.createdAt,
    this.localImages,
  }) {
    this.localImages ??= [];
  }

  Map<String, dynamic> toMap();
  factory ServiceRequest.fromMap(Map map) {
    if (map['request_number'] == null) return null;

    return map['request_number'].contains('SN')
        ? SnowRequest.fromMap(map)
        : LawnRequest.fromMap(map);
  }

  @override
  String toString() {
    return 'ServiceRequest(id: $id, customer: $customer, provider: $provider, status: $status, address: $address, payment: $payment, price: $price, currency: $currency, date: $date, customerImages: $customerImages, providerBeforeImages: $providerBeforeImages, providerAfterImages: $providerAfterImages, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ServiceRequest &&
        o.id == id &&
        o.customer == customer &&
        o.provider == provider &&
        o.status == status &&
        o.address == address &&
        o.payment == payment &&
        o.price == price &&
        o.currency == currency &&
        o.date == date &&
        listEquals(o.customerImages, customerImages) &&
        listEquals(o.providerBeforeImages, providerBeforeImages) &&
        listEquals(o.providerAfterImages, providerAfterImages) &&
        o.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        customer.hashCode ^
        provider.hashCode ^
        status.hashCode ^
        address.hashCode ^
        payment.hashCode ^
        price.hashCode ^
        currency.hashCode ^
        date.hashCode ^
        customerImages.hashCode ^
        providerBeforeImages.hashCode ^
        providerAfterImages.hashCode ^
        createdAt.hashCode;
  }
}
