import 'dart:convert';

import 'package:ServiceHub/db/main-db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';

import 'card-type.dart';

part '../db/adapters/credit-card.g.dart';

@HiveType(typeId: MainDB.CreditCardType)
class CreditCard {
  @HiveField(0)
  String id;
  @HiveField(1)
  String name;
  @HiveField(2)
  int expMonth;
  @HiveField(3)
  int expYear;
  @HiveField(4)
  String last4Digits;
  @HiveField(5)
  String type;

  CardType get cardType => null;

  String cardNumber;
  String expiryDate;
  String cvv;

  String get fExpiryDate => '$expMonth/${expYear.toString().substring(2)}';

  CreditCard({
    this.id = '',
    this.name = '',
    this.expMonth = 0,
    this.expYear = 0,
    this.last4Digits = '',
    this.type = '',
    this.cardNumber = '',
    this.expiryDate = '',
    this.cvv = '',
  });

  IconData get icon {
    switch (type.toUpperCase()) {
      case 'VISA':
        return FontAwesomeIcons.ccVisa;
      case 'AMERICAN EXPRESS':
        return FontAwesomeIcons.ccAmex;
      case 'MASTERCARD':
        return FontAwesomeIcons.ccMastercard;
      case 'DISCOVER':
        return FontAwesomeIcons.ccDiscover;
      case 'DINERS CLUB':
        return FontAwesomeIcons.ccDinersClub;
      case 'JCB':
        return FontAwesomeIcons.ccJcb;
      case 'UNIONPAY':
      default:
        return FontAwesomeIcons.creditCard;
    }
  }

  Color get color {
    switch (type.toUpperCase()) {
      case 'VISA':
        return Color(0xFF28334b);
      case 'AMERICAN EXPRESS':
        return Color(0xFF74ccab);
      case 'MASTERCARD':
        return Color(0xFFf65158);
      case 'DISCOVER':
      case 'UNIONPAY':
      case 'DINERS CLUB':
      case 'JCB':
      default:
        return Color(0xFF043768);
    }
  }

  CreditCard copyWith({
    String id,
    String name,
    String expMonth,
    String expYear,
    String last4Digits,
    CardType type,
  }) {
    return CreditCard(
      id: id ?? this.id,
      name: name ?? this.name,
      expMonth: expMonth ?? this.expMonth,
      expYear: expYear ?? this.expYear,
      last4Digits: last4Digits ?? this.last4Digits,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    // return {
    //   'type': 'card',
    //   'billing_details': {
    //     'name': name,
    //   },
    //   'card': {
    //     'exp_month': expMonth,
    //     'exp_year': expYear,
    //     'number': last4Digits,
    //     'cvc': cvv,
    //   }
    // };
    return {
      'type': 'card',
      'billing_details[name]': name,
      'card[exp_month]': expMonth,
      'card[exp_year]': expYear,
      'card[number]': cardNumber,
      'card[cvc]': cvv,
    };
  }

  factory CreditCard.fromMap(Map map) {
    if (map == null) return null;

    return CreditCard(
      id: map['id'] ?? 0,
      name: map['billing_details']['name'] ?? '',
      expMonth: map['card']['exp_month'] ?? '',
      expYear: map['card']['exp_year'] ?? '',
      last4Digits: map['card']['last4'] ?? '',
      type: map['card']['brand'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory CreditCard.fromJson(String source) =>
      CreditCard.fromMap(json.decode(source));

  @override
  String toString() {
    return 'CreditCard(id: $id, name: $name, expMonth: $expMonth, expYear: $expYear, last4Digits: $last4Digits, type: $type)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CreditCard &&
        o.id == id &&
        o.name == name &&
        o.expMonth == expMonth &&
        o.expYear == expYear &&
        o.last4Digits == last4Digits &&
        o.type == type;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        expMonth.hashCode ^
        expYear.hashCode ^
        last4Digits.hashCode ^
        type.hashCode;
  }
}
