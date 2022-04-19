import 'dart:io';

import 'package:ServiceHub/models/account.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/provider.dart';

abstract class UserEvent extends Equatable {}

class ResetUser extends UserEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'ResetUser';
}

abstract class UserLogin extends UserEvent {
  final String email;
  final String password;
  final Type type;
  final bool rememberMe;

  UserLogin({
    @required this.email,
    @required this.password,
    @required this.type,
    @required this.rememberMe,
  });

  @override
  List<Object> get props => [email, password, type];

  @override
  String toString() =>
      'UserLogin(email: $email, password: $password, type: $type)';
}

class CustomerLogin extends UserLogin {
  CustomerLogin({
    @required String email,
    @required String password,
    @required bool rememberMe,
  }) : super(
          email: email,
          password: password,
          type: Customer,
          rememberMe: rememberMe,
        );

  @override
  String toString() => 'CustomerLogin(email: $email, password: $password)';
}

class ProviderLogin extends UserLogin {
  ProviderLogin({
    @required String email,
    @required String password,
    @required bool rememberMe,
  }) : super(
          email: email,
          password: password,
          type: Provider,
          rememberMe: rememberMe,
        );

  @override
  String toString() => 'ProviderLogin(email: $email, password: $password)';
}

class UserRegister extends UserEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String passwordConfirmation;
  final Type type;

  UserRegister({
    @required this.firstName,
    @required this.lastName,
    @required this.email,
    @required this.password,
    @required this.passwordConfirmation,
    this.type,
  });

  @override
  List<Object> get props =>
      [firstName, lastName, email, password, passwordConfirmation];

  @override
  String toString() {
    return 'UserRegister(firstName: $firstName, lastName: $lastName, email: $email, password: $password, passwordConfirmation: $passwordConfirmation)';
  }
}

class UserResetPassword extends UserEvent {
  final String email;

  UserResetPassword({
    @required this.email,
  });

  @override
  List<Object> get props => [email];

  @override
  String toString() => 'UserResetPassword(email: $email)';
}

class UserVerifyEmail extends UserEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'UserVerifyEmail';
}

class UserAuthenticate extends UserEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'UserAuthenticate';
}

class UserLogout extends UserEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'UserLogout';
}

class UserUpdate extends UserEvent {
  final Account user;
  final File newImage;

  UserUpdate(this.user, {this.newImage});

  @override
  List<Object> get props => [user, newImage];

  @override
  String toString() => 'UserLogout(user: $user, newImage: $newImage)';
}
