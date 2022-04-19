import 'package:ServiceHub/models/address.dart';
import 'package:equatable/equatable.dart';

abstract class AddressEvent extends Equatable {
  @override
  String toString() => 'AddressEvent';
}

class ResetAddress extends AddressEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'ResetAddress';
}

class FetchAddresses extends AddressEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'FetchAddresses';
}

class FetchAddress extends AddressEvent {
  final Address address;

  FetchAddress(this.address);

  @override
  List<Object> get props => [address];

  @override
  String toString() => 'FetchAddress(address: $address)';
}

class AddAddress extends AddressEvent {
  final Address address;

  AddAddress(this.address);

  @override
  List<Object> get props => [address];

  @override
  String toString() => 'AddAddress(address: $address)';
}

class RemoveAddress extends AddressEvent {
  final Address address;

  RemoveAddress(this.address);

  @override
  List<Object> get props => [address];

  @override
  String toString() => 'RemoveAddress(address: $address)';
}
