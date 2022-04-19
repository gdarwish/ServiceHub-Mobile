import 'dart:convert';
import 'dart:io';

import 'package:ServiceHub/db/main-db.dart';
import 'package:ServiceHub/models/address.dart';
import 'package:ServiceHub/models/payment.dart';
import 'package:ServiceHub/models/profile.dart';
import 'package:ServiceHub/models/request-status.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:hive/hive.dart';

part '../db/adapters/snow-request.g.dart';

@HiveType(typeId: MainDB.SnowRequestType)
class SnowRequest extends ServiceRequest {
  @override
  @HiveField(0)
  int id;

  @override
  @HiveField(1)
  String requestNumber;

  @override
  @HiveField(3)
  Profile customer;

  @override
  @HiveField(4)
  Profile provider;

  @override
  @HiveField(5)
  RequestStatus status;

  @override
  @HiveField(6)
  Address address;

  @override
  @HiveField(7)
  Payment payment;

  @override
  @HiveField(8)
  double price;

  @override
  @HiveField(9)
  String currency;

  @override
  @HiveField(10)
  DateTime date;

  @override
  @HiveField(11)
  List<String> customerImages;

  @override
  @HiveField(12)
  List<String> providerBeforeImages;

  @override
  @HiveField(13)
  List<String> providerAfterImages;

  @override
  @HiveField(14)
  DateTime createdAt;

  @HiveField(15)
  String driveway;

  @HiveField(16)
  bool sidewalk;

  @HiveField(17)
  bool walkway;

  @HiveField(18)
  bool salting;

  @HiveField(19)
  String instructions;

  SnowRequest({
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
    this.customerImages,
    this.providerBeforeImages,
    this.providerAfterImages,
    this.createdAt,
    this.driveway,
    this.sidewalk,
    this.walkway,
    this.salting,
    this.instructions,
    List<File> localImages,
  }) : super(
          id: id,
          requestNumber: requestNumber,
          customer: customer,
          provider: provider,
          status: status,
          address: address,
          payment: payment,
          price: price,
          currency: currency,
          date: date,
          customerImages: customerImages,
          providerBeforeImages: providerBeforeImages,
          providerAfterImages: providerAfterImages,
          createdAt: createdAt,
          localImages: localImages,
          instructions: instructions,
        );

  SnowRequest copyWith({
    String driveway,
    bool sidewalk,
    bool walkway,
    bool salting,
  }) {
    return SnowRequest(
      driveway: driveway ?? this.driveway,
      sidewalk: sidewalk ?? this.sidewalk,
      walkway: walkway ?? this.walkway,
      salting: salting ?? this.salting,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'request_number': requestNumber,
      'customer_id': customer?.id,
      'provider_id': provider?.id,
      'request_status': status?.toMap(),
      'address_id': address?.id,
      'payment_id': payment?.id,
      'price': price,
      'currency': currency,
      'request_date': date?.toIso8601String(),
      'instruction': instructions,
      // 'customer_images': customerImages,
      // 'provider_before_images': providerBeforeImages,
      // 'provider_after_images': providerAfterImages,
      'driveway': driveway,
      'sidewalk': sidewalk ? 1 : 0,
      'walkway': walkway ? 1 : 0,
      'salting': salting ? 1 : 0,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory SnowRequest.fromMap(Map map) {
    if (map == null) return null;
    return SnowRequest(
      id: map['id'] ?? 0,
      requestNumber: map['request_number'] ?? '',
      customer:
          map['customer'] == null ? null : Profile.fromMap(map['customer']),
      provider:
          map['provider'] == null ? null : Profile.fromMap(map['provider']),
      status: map['request_status'] == null
          ? null
          : RequestStatus.fromMap(map['request_status']),
      address: map['address'] == null ? null : Address.fromMap(map['address']),
      payment: map['payment'] == null ? null : Payment.fromMap(map['payment']),
      price: double.tryParse(map['price'].toString() ?? '0') ?? 0.0,
      currency: map['currency'] ?? 'CAD',
      // date: DateTime.now(),
      // date: map['request_date'] ?? DateTime.now(),
      date: DateTime.tryParse(map['request_date'] ?? '') ?? DateTime.now(),
      instructions: map['instruction'] ?? '',
      customerImages: map['customer_images'] == null
          ? null
          : List<String>.from(map['customer_images']),
      providerBeforeImages: map['provider_before_images'] == null
          ? null
          : List<String>.from(map['provider_before_images']),
      providerAfterImages: map['provider_after_images'] == null
          ? null
          : List<String>.from(map['provider_after_images']),
      driveway: map['driveway'] ?? '',
      sidewalk: map['sidewalk'] ?? false,
      walkway: map['walkway'] ?? false,
      salting: map['salting'] ?? false,
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory SnowRequest.fromJson(String source) =>
      SnowRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'SnowRequest(driveway: $driveway, sidewalk: $sidewalk, walkway: $walkway, salting: $salting)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is SnowRequest &&
        o.driveway == driveway &&
        o.sidewalk == sidewalk &&
        o.walkway == walkway &&
        o.salting == salting;
  }

  @override
  int get hashCode {
    return driveway.hashCode ^
        sidewalk.hashCode ^
        walkway.hashCode ^
        salting.hashCode;
  }
}
