import 'dart:convert';

import 'package:ServiceHub/db/main-db.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

part '../db/adapters/request-status.g.dart';

enum RequestStatusType {
  Default, // index = 0
  Active, // index = 1
  Pending, // index = 2
  Accepted, // index = 3
  InProgress, // index = 4
  Completed, // index = 5
  Confirmed, // index = 6
  Canceled, // index = 7
}

@HiveType(typeId: MainDB.RequestStatusType)
class RequestStatus {
  @HiveField(0)
  int id;

  @HiveField(1)
  String title;

  RequestStatusType get type {
    if (id > RequestStatusType.values.length) return RequestStatusType.Default;
    return RequestStatusType.values[id];
  }

  RequestStatus({
    this.id,
    this.title,
  });

  Color get color {
    // Active
    if (id == RequestStatusType.Active.index) {
      return Color(0xFF81D742);
    }
    // Pending
    if (id == RequestStatusType.Pending.index) {
      return Color(0xFFDD9934);
    }
    // Accepted
    if (id == RequestStatusType.Accepted.index) {
      return Color(0xFF0874A2);
    }
    // In Progress
    if (id == RequestStatusType.InProgress.index) {
      return Color(0xFFA21F99);
    }
    // Completed
    if (id == RequestStatusType.Completed.index) {
      return Color(0xFF159E21);
    }
    // Confirmed
    if (id == RequestStatusType.Confirmed.index) {
      return Color(0xFF3597DC);
    }
    // Canceled
    if (id == RequestStatusType.Canceled.index) {
      return Color(0xFFCF2A27);
    }

    // Default
    return Colors.black;
  }

  RequestStatus copyWith({
    int id,
    String title,
  }) {
    return RequestStatus(
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

  factory RequestStatus.fromMap(Map map) {
    if (map == null) return null;

    return RequestStatus(
      id: map['id'] ?? 0,
      title: map['title'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory RequestStatus.fromJson(String source) =>
      RequestStatus.fromMap(json.decode(source));

  @override
  String toString() => 'RequestStatus(id: $id, title: $title)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RequestStatus && o.id == id && o.title == title;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode;
}
