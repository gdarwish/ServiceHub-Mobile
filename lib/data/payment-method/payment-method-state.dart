import 'package:ServiceHub/models/api-error.dart';
import 'package:ServiceHub/models/payment-method.dart';
import 'package:equatable/equatable.dart';

abstract class PaymentMethodState extends Equatable {}

class PaymentMethodInitState extends PaymentMethodState {
  @override
  List<Object> get props => [];
}

class PaymentMethodsFetchedState extends PaymentMethodState {
  final List<PaymentMethod> paymentMethods;

  PaymentMethodsFetchedState(this.paymentMethods);

  @override
  List<Object> get props => [paymentMethods];

  @override
  String toString() =>
      'PaymentMethodsFetchedState(paymentMethods: $paymentMethods)';
}

class PaymentMethodFetchedState extends PaymentMethodState {
  final PaymentMethod paymentMethod;

  PaymentMethodFetchedState(this.paymentMethod);

  @override
  List<Object> get props => [paymentMethod];

  @override
  String toString() =>
      'PaymentMethodFetchedState(paymentMethod: $paymentMethod)';
}

class PaymentMethodsFetchingState extends PaymentMethodState {
  final String message;

  PaymentMethodsFetchingState({this.message = 'Loading...'});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'PaymentMethodsFetchingState(message: $message)';
}

class PaymentMethodAddingState extends PaymentMethodState {
  final String message;

  PaymentMethodAddingState({this.message = 'Loading...'});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'PaymentMethodAddingState(message: $message)';
}

class PaymentMethodRemovingState extends PaymentMethodState {
  final String message;

  PaymentMethodRemovingState({this.message = 'Removing...'});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'PaymentMethodRemovingState(message: $message)';
}

class PaymentMethodAddedState extends PaymentMethodState {
  final PaymentMethod paymentMethod;

  PaymentMethodAddedState(this.paymentMethod);

  @override
  List<Object> get props => [paymentMethod];

  @override
  String toString() => 'PaymentMethodAddedState(PaymentMethod: $PaymentMethod)';
}


class PaymentMethodRemovedState extends PaymentMethodState {
  final String message;

  PaymentMethodRemovedState({this.message = 'Payment Method Removed'});

  @override
  List<Object> get props => [message];

  @override
  String toString() => 'PaymentMethodRemovedState{message: $message)';
}

class PaymentMethodFailureState extends PaymentMethodState {
  final APIError apiError;

  PaymentMethodFailureState(this.apiError);

  @override
  List<Object> get props => [apiError];

  @override
  String toString() => 'PaymentMethodsFailureState(message: $apiError)';
}
