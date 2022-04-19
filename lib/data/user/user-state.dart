import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/api-error.dart';

abstract class UserState extends Equatable {}

class UserUnauthenticated extends UserState {
  @override
  List<Object> get props => [];
}

class UserAuthenticated extends UserState {
  final Account user;

  UserAuthenticated(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UserAuthenticated(user: $user)';
}

class UserAuthenticating extends UserState {
  final String message;
  UserAuthenticating({this.message = 'User authenticating...'});
  @override
  List<Object> get props => [message];

  @override
  String toString() => 'UserAuthenticating(message: $message)';
}

class UserAuthenticationFailure extends UserState {
  final APIError apiError;
  UserAuthenticationFailure(this.apiError);
  @override
  List<Object> get props => [apiError];

  @override
  String toString() => 'UserAuthenticationFailure(apiError: $apiError)';
}

class UserRegistered extends UserState {
  final String email;
  final String password;

  UserRegistered({@required this.email, @required this.password});

  @override
  List<Object> get props => [email, password];

  @override
  String toString() => 'UserRegistered(email: $email, password: $password)';
}

class UserNotVerified extends UserState {
  final Account user;
  final String message;
  UserNotVerified(this.user, {this.message = 'You account is not verified.'});
  @override
  List<Object> get props => [user, message];

  @override
  String toString() => 'UserNotVerified(user: $user, message: $message)';
}

class UserResetPasswordSent extends UserState {
  final String message;
  UserResetPasswordSent({this.message = 'User reset password link was sent.'});
  @override
  List<Object> get props => [message];

  @override
  String toString() => 'UserResetPasswordSent(message: $message)';
}

class UserResetPasswordFailure extends UserState {
  final APIError apiError;
  UserResetPasswordFailure(this.apiError);
  @override
  List<Object> get props => [apiError];

  @override
  String toString() => 'UserResetPasswordFailure(apiError: $apiError)';
}

class UserEmailVerifySent extends UserState {
  final String message;
  UserEmailVerifySent(
      {this.message = 'Email has been sent to verify your account.'});
  @override
  List<Object> get props => [message];

  @override
  String toString() => 'UserEmailVerifySent(message: $message)';
}

class UserEmailVerifyFailure extends UserState {
  final APIError apiError;
  UserEmailVerifyFailure(this.apiError);
  @override
  List<Object> get props => [apiError];

  @override
  String toString() => 'UserEmailVerifyFailure(apiError: $apiError)';
}

class UserUpdating extends UserState {
  final String message;
  UserUpdating({this.message = 'User updating...'});
  @override
  List<Object> get props => [message];

  @override
  String toString() => 'UserUpdating(message: $message)';
}

class UserUpdated extends UserState {
  final Account user;

  UserUpdated(this.user);

  @override
  List<Object> get props => [user];

  @override
  String toString() => 'UserUpdated(user: $user)';
}


class UserUpdateFailure extends UserState {
  final APIError apiError;
  UserUpdateFailure(this.apiError);
  @override
  List<Object> get props => [apiError];

  @override
  String toString() => 'UserUpdateFailure(apiError: $apiError)';
}