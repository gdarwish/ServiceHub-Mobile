import 'dart:convert';

import 'package:ServiceHub/db/main-db.dart';
import 'package:ServiceHub/models/profile.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part '../db/adapters/review.g.dart';

@HiveType(typeId: MainDB.ReviewType)
class Review {
  @HiveField(0)
  int id;

  @HiveField(1)
  int rating;

  @HiveField(2)
  String review;

  @HiveField(3)
  Profile profile;

  @HiveField(4)
  String requestNumber;

  @HiveField(5)
  DateTime createdAt;

  String get fCreatedAt => DateFormat.yMMMMd().add_jm().format(createdAt);

  Review({
    this.id = 0,
    this.rating = 0,
    this.review = '',
    this.profile,
    this.requestNumber = '',
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'rating': rating,
      'review': review,
      'user_id': profile?.id,
      'request_number': requestNumber,
      'creted_at': createdAt?.toIso8601String(),
      // 'service_request': serviceRequest?.toMap(),
      // serviceRequest is SnowRequest ? 'snow_request_id' : 'lawn_request_id':
      //     serviceRequest?.id,
    };
  }

  factory Review.fromMap(Map map) {
    if (map == null) return null;

    return Review(
      id: map['id'] ?? 0,
      rating: map['rating'] as int ?? 0,
      review: map['review'] ?? '',
      profile: map['user'] == null ? null : Profile.fromMap(map['user']),
      requestNumber: map['request_number'] ?? '',
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Review.fromJson(String source) => Review.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Review(id: $id, rating: $rating, review: $review, profile: $profile)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Review &&
        o.id == id &&
        o.rating == rating &&
        o.review == review &&
        o.profile == profile;
  }

  @override
  int get hashCode {
    return id.hashCode ^ rating.hashCode ^ review.hashCode ^ profile.hashCode;
  }
}
