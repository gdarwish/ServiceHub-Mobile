import 'dart:convert';
import 'package:ServiceHub/db/main-db.dart';
import 'package:hive/hive.dart';

part '../db/adapters/address.g.dart';

@HiveType(typeId: MainDB.AddressType)
class Address {
  @HiveField(0)
  int id;
  @HiveField(1)
  String placeId;
  @HiveField(2)
  String title;
  @HiveField(3)
  String formattedAddress;
  @HiveField(4)
  double latitude;
  @HiveField(5)
  double longitude;
  @HiveField(6)
  String phone;
  @HiveField(7)
  DateTime createdAt;

  String get fPhone => phone.replaceAllMapped(RegExp(r'(\d{3})(\d{3})(\d+)'), (Match m) => "(${m[1]}) ${m[2]}-${m[3]}");

  Address({
    this.id,
    this.placeId,
    this.title,
    this.formattedAddress,
    this.latitude,
    this.longitude,
    this.phone,
    this.createdAt,
  });

  Address copyWith({
    int id,
    String placeId,
    String title,
    String formattedAddress,
    double latitude,
    double longitude,
    String phone,
    DateTime createdAt,
  }) {
    return Address(
      id: id ?? this.id,
      placeId: placeId ?? this.placeId,
      title: title ?? this.title,
      formattedAddress: formattedAddress ?? this.formattedAddress,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phone: phone ?? this.phone,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'place_id': placeId,
      'title': title,
      'formatted_address': formattedAddress,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory Address.fromMap(Map map) {
    if (map == null) return null;

    return Address(
      id: map['id'],
      placeId: map['place_id'],
      title: map['title'],
      formattedAddress: map['formatted_address'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      phone: map['phone'],
      // createdAt: DateTime.fromMillisecondsSinceEpoch(map['created_at']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Address.fromJson(String source) =>
      Address.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Address(id: $id, placeId: $placeId, title: $title, formattedAddress: $formattedAddress, latitude: $latitude, longitude: $longitude, phone: $phone, createdAt: $createdAt)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Address &&
        o.id == id &&
        o.placeId == placeId &&
        o.title == title &&
        o.formattedAddress == formattedAddress &&
        o.latitude == latitude &&
        o.longitude == longitude &&
        o.phone == phone &&
        o.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        placeId.hashCode ^
        title.hashCode ^
        formattedAddress.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        phone.hashCode ^
        createdAt.hashCode;
  }
}
