import 'dart:convert';
import 'dart:io';

import 'package:ServiceHub/db/main-db.dart';
import 'package:flutter/foundation.dart';

import 'package:ServiceHub/models/report-status.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';

part '../db/adapters/report.g.dart';

@HiveType(typeId: MainDB.ReportType)
class Report {
  @HiveField(0)
  int id;

  @HiveField(1)
  ReportStatus status;

  @HiveField(2)
  String userDetails;

  @HiveField(3)
  String adminDetails;

  @HiveField(4)
  List<String> images;

  @HiveField(5)
  ServiceRequest serviceRequest;

  @HiveField(6)
  String requestNumber;

  @HiveField(7)
  DateTime createdAt;

  String get fCreatedAt => DateFormat.yMMMMd().add_jm().format(createdAt);

  List<File> localImages;

  Report({
    this.id,
    this.status,
    this.userDetails,
    this.adminDetails,
    this.images,
    this.serviceRequest,
    this.localImages,
    this.requestNumber,
    this.createdAt,
  });

  Report copyWith({
    int id,
    String userDetails,
    String adminDetails,
    List<String> images,
    ServiceRequest serviceRequest,
    List<File> localImages,
  }) {
    return Report(
      id: id ?? this.id,
      userDetails: userDetails ?? this.userDetails,
      adminDetails: adminDetails ?? this.adminDetails,
      images: images ?? this.images,
      serviceRequest: serviceRequest ?? this.serviceRequest,
      localImages: localImages ?? this.localImages,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_details': userDetails,
      'admin_details': adminDetails,
      'request_number': serviceRequest?.requestNumber,
      'service_request': serviceRequest?.toMap(),
      'created_at': createdAt?.toIso8601String(),
    };
  }

  factory Report.fromMap(Map map) {
    if (map == null) return null;

    return Report(
      id: map['id'] ?? 0,
      userDetails: map['user_details'] ?? '',
      adminDetails: map['admin_details'] ?? '',
      status: map['report_status'] == null
          ? null
          : ReportStatus.fromMap(map['report_status']),
      images: map['images'] == null ? null : List<String>.from(map['images']),
      requestNumber: map['request_number'] ?? '',
      serviceRequest: map['service_request'] == null
          ? null
          : ServiceRequest.fromMap(map['service_request']),
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  String toJson() => json.encode(toMap());

  factory Report.fromJson(String source) => Report.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Report(id: $id, userDetails: $userDetails, adminDetails: $adminDetails, images: $images, serviceRequest: $serviceRequest)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is Report &&
        o.id == id &&
        o.userDetails == userDetails &&
        o.adminDetails == adminDetails &&
        listEquals(o.images, images) &&
        o.serviceRequest == serviceRequest;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userDetails.hashCode ^
        adminDetails.hashCode ^
        images.hashCode ^
        serviceRequest.hashCode;
  }
}
