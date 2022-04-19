import 'dart:convert';

import 'package:ServiceHub/db/main-db.dart';
import 'package:ServiceHub/models/credit-card.dart';
import 'package:hive/hive.dart';

part '../db/adapters/payment-method.g.dart';

@HiveType(typeId: MainDB.PaymentMethodType)
class PaymentMethod {
  @HiveField(0)
  int id;

  @HiveField(1)
  CreditCard card;

  @HiveField(2)
  DateTime createdAt;

  PaymentMethod({
    this.id,
    this.card,
    this.createdAt,
  });

  PaymentMethod copyWith({
    int id,
    CreditCard card,
    DateTime createdAt,
  }) {
    return PaymentMethod(
      id: id ?? this.id,
      card: card ?? this.card,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'card': card?.toMap(),
      'createdAt': createdAt?.toIso8601String(),
    };
  }

  factory PaymentMethod.fromMap(Map map) {
    if (map == null) return null;

    return PaymentMethod(
      id: map['id'] ?? 0,
      card: CreditCard.fromMap(map['data']),
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory PaymentMethod.fromJson(String source) =>
      PaymentMethod.fromMap(json.decode(source));

  @override
  String toString() =>
      'PaymentMethod(id: $id, card: $card, createdAt: $createdAt)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PaymentMethod &&
        o.id == id &&
        o.card == card &&
        o.createdAt == createdAt;
  }

  @override
  int get hashCode => id.hashCode ^ card.hashCode ^ createdAt.hashCode;
}
