import 'dart:convert';

import 'package:ServiceHub/db/main-db.dart';
import 'package:hive/hive.dart';

part '../db/adapters/payment.g.dart';

@HiveType(typeId: MainDB.PaymentType)
class Payment {
  @HiveField(0)
  int id;

  @HiveField(1)
  String paymentId;

  @HiveField(2)
  double amount;

  @HiveField(3)
  String currency;

  @HiveField(4)
  DateTime createdAt;

  Payment({
    this.id,
    this.paymentId,
    this.amount,
    this.currency,
    this.createdAt,
  });

  Payment copyWith({
    int id,
    String paymentId,
    double amount,
    String currency,
    DateTime createdAt,
  }) {
    return Payment(
      id: id ?? this.id,
      paymentId: paymentId ?? this.paymentId,
      amount: amount ?? this.amount,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'paymentId': paymentId,
      'amount': amount,
      'currency': currency,
      // 'created_at': createdAt?.millisecondsSinceEpoch,
    };
  }

  factory Payment.fromMap(Map map) {
    if (map == null) return null;

    return Payment(
      id: map['id'] ?? 0,
      paymentId: map['payment_id'] ?? '',
      amount: map['amount'],
      currency: map['currency'],
      // createdAt: DateTime.tryParse(map['created_at']) ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Payment.fromJson(String source) =>
      Payment.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Payment(id: $id, paymentId: $paymentId, amount: $amount, currency: $currency, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Payment &&
        o.id == id &&
        o.paymentId == paymentId &&
        o.amount == amount &&
        o.currency == currency &&
        o.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        paymentId.hashCode ^
        amount.hashCode ^
        currency.hashCode ^
        createdAt.hashCode;
  }
}
