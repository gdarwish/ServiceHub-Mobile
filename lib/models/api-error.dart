import 'dart:convert';

import 'package:flutter/foundation.dart';

class APIError implements Exception {
  final String message;
  final Map<String, dynamic> errors;

  APIError({
    this.message = 'Oops! something went wrong :(',
    this.errors,
  });

  APIError copyWith({
    String message,
    Map<String, dynamic> errors,
  }) {
    return APIError(
      message: message ?? this.message,
      errors: errors ?? this.errors,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'message': message,
      'errors': errors,
    };
  }

  factory APIError.fromMap(Map map) {
    return APIError(
      message: map['message'] ?? map['error'] ?? 'Something went wrong :(',
      errors:
          map['errors'] != null ? Map<String, dynamic>.from(map['errors']) : {},
    );
  }

  String toJson() => json.encode(toMap());

  factory APIError.fromJson(String source) =>
      APIError.fromMap(json.decode(source));

  @override
  String toString() => 'APIError(message: $message, errors: $errors)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is APIError &&
        other.message == message &&
        mapEquals(other.errors, errors);
  }

  @override
  int get hashCode => message.hashCode ^ errors.hashCode;
}
