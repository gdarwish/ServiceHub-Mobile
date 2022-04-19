import 'package:ServiceHub/db/main-db.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/report.dart';
import 'package:ServiceHub/models/review.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:hive/hive.dart';

part '../db/adapters/profile.g.dart';

@HiveType(typeId: MainDB.ProfileType)
class Profile extends Account {
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

  Profile({
    this.id,
    this.firstName,
    this.lastName,
    this.imageURL,
    this.email,
    this.verified,
    // List<Review> reviews,
    // List<Report> reports,
    // List<ServiceRequest> serviceRequests,
  }) : super(
          id: id,
          firstName: firstName,
          lastName: lastName,
          imageURL: imageURL,
          email: email,
          verified: verified,
          // reviews: reviews,
          // reports: reports,
          // serviceRequests: serviceRequests,
        );

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'image_url': imageURL,
      'email': email,
      'verified': verified,
    };
  }

  @override
  factory Profile.fromMap(Map map) {
    if (map == null) return null;

    return Profile(
      id: map['id'] ?? 0,
      firstName: map['first_name'] ?? '',
      lastName: map['last_name'] ?? '',
      imageURL: map['image_url'] ?? '',
      email: map['email'] ?? '',
      verified: map['verified'] ?? false,
    );
  }
}
