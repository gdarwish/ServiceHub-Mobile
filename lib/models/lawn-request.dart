import 'dart:convert';
import 'dart:io';

import 'package:ServiceHub/db/main-db.dart';
import 'package:ServiceHub/models/address.dart';
import 'package:ServiceHub/models/payment.dart';
import 'package:ServiceHub/models/profile.dart';
import 'package:ServiceHub/models/request-status.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:hive/hive.dart';

part '../db/adapters/lawn-request.g.dart';

@HiveType(typeId: MainDB.LawnRequestType)
class LawnRequest extends ServiceRequest {
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
  String grassLength;

  @HiveField(16)
  String frontyard;

  @HiveField(17)
  String backyard;

  @HiveField(18)
  String sideyard;

  @HiveField(19)
  bool stringTrimming;

  @HiveField(20)
  bool clearClipping;

  @HiveField(21)
  String instructions;

  LawnRequest({
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
    this.grassLength,
    this.frontyard,
    this.backyard,
    this.sideyard,
    this.stringTrimming,
    this.clearClipping,
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

  LawnRequest copyWith({
    String grassLength,
    String frontyard,
    String backyard,
    String sideyard,
    bool stringTrimming,
    bool clearClipping,
  }) {
    return LawnRequest(
      grassLength: grassLength ?? this.grassLength,
      frontyard: frontyard ?? this.frontyard,
      backyard: backyard ?? this.backyard,
      sideyard: sideyard ?? this.sideyard,
      stringTrimming: stringTrimming ?? this.stringTrimming,
      clearClipping: clearClipping ?? this.clearClipping,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'request_number': requestNumber,
      'customer': customer?.toMap(),
      'provider': provider?.toMap(),
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
      'grass_length': grassLength,
      'front_yard': frontyard,
      'back_yard': backyard,
      'side_yard': sideyard,
      'string_trimming': stringTrimming ? 1 : 0,
      'clear_clipping': clearClipping ? 1 : 0,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory LawnRequest.fromMap(Map map) {
    if (map == null) return null;

    return LawnRequest(
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
      grassLength: map['grass_length'] ?? '',
      frontyard: map['front_yard'] ?? '',
      backyard: map['back_yard'] ?? '',
      sideyard: map['side_yard'] ?? '',
      stringTrimming: map['string_trimming'] ?? false,
      clearClipping: map['clear_clipping'] ?? false,
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory LawnRequest.fromJson(String source) =>
      LawnRequest.fromMap(json.decode(source));

  @override
  String toString() {
    return 'LawnRequest(grassLength: $grassLength, frontyard: $frontyard, backyard: $backyard, sideyard: $sideyard, stringTrimming: $stringTrimming, clearClipping: $clearClipping)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is LawnRequest &&
        o.grassLength == grassLength &&
        o.frontyard == frontyard &&
        o.backyard == backyard &&
        o.sideyard == sideyard &&
        o.stringTrimming == stringTrimming &&
        o.clearClipping == clearClipping;
  }

  @override
  int get hashCode {
    return grassLength.hashCode ^
        frontyard.hashCode ^
        backyard.hashCode ^
        sideyard.hashCode ^
        stringTrimming.hashCode ^
        clearClipping.hashCode;
  }
}
