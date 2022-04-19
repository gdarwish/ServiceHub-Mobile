import 'dart:convert';

import 'package:ServiceHub/db/main-db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part '../db/adapters/report-status.g.dart';

enum ReportStatusType {
  Default, // index = 0
  Open, // index = 1
  Closed, // index = 2
}

@HiveType(typeId: MainDB.ReportStatusType)
class ReportStatus {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  ReportStatus({
    this.id,
    this.title,
  });

  Color get color {
    // Completed
    if (id == ReportStatusType.Open.index) {
      return Color(0xFF159E21);
    }
    // Canceled
    if (id == ReportStatusType.Closed.index) {
      return Color(0xFFCF2A27);
    }

    // Default
    return Colors.black;
  }

  ReportStatus copyWith({
    int id,
    String title,
  }) {
    return ReportStatus(
      id: id ?? this.id,
      title: title ?? this.title,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
    };
  }

  factory ReportStatus.fromMap(Map map) {
    if (map == null) return null;

    return ReportStatus(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory ReportStatus.fromJson(String source) =>
      ReportStatus.fromMap(json.decode(source));

  @override
  String toString() => 'ReportStatus(id: $id, title: $title)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ReportStatus && o.id == id && o.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
