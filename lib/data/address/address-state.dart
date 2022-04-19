import 'package:ServiceHub/models/address.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:equatable/equatable.dart';

abstract class AddressState extends Equatable {}

class AddressInitState extends AddressState {
  @override
  List<Object> get props => [];
}

class AddressesFetchedState extends AddressState {
  final List<Address> addresses;

  AddressesFetchedState(this.addresses);

  @override
  List<Object> get props => [addresses];

  @override
  String toString() => 'AddressesFetchedState(addresses: $addresses)';
}

class AddressFetchedState extends AddressState {
  final Address address;

  AddressFetchedState(this.address);

  @override
  List<Object> get props => [address];

  @override
  String toString() => 'AddressFetchedState(address: $address)';
}

class AddressesFetchingState extends AddressState {
  final String message;

  AddressesFetchingState({this.message = 'Loading...'});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'AddressesFetchingState(message: $message)';
}

class AddressAddingState extends AddressState {
  final String message;

  AddressAddingState({this.message = 'Loading...'});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'AddressAddingState(message: $message)';
}

class AddressRemovingState extends AddressState {
  final String message;

  AddressRemovingState({this.message = 'Removing...'});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'AddressRemovingState(message: $message)';
}

class AddressAddedState extends AddressState {
  final Address address;

  AddressAddedState(this.address);

  @override
  List<Object> get props => [address];

  @override
  String toString() => 'AddressAddedState(address: $address)';
}

class AddressRemovedState extends AddressState {
  final String message;

  AddressRemovedState({this.message = 'Address Removed'});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'AddressRemovedState{message: $message)';
}

class AddressFailureState extends AddressState {
  final APIError apiError;

  AddressFailureState(this.apiError);

  @override
  List<Object> get props => [apiError];

  @override
  String toString() => 'AddresssFailureState(apiError: $apiError)';
}
