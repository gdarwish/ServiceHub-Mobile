import 'package:ServiceHub/models/payment-method.dart';
import 'package:equatable/equatable.dart';

abstract class PaymentMethodEvent extends Equatable {
  @override
  String toString() => 'PaymentMethodEvent';
}

class ResetPaymentMethod extends PaymentMethodEvent {
  @override
  List<Object> get props => [];
  @override
  String toString() => 'ResetPaymentMethod';
}

class FetchPaymentMethods extends PaymentMethodEvent {
  @override
  List<Object> get props => [];

  @override
  String toString() => 'FetchPaymentMethods';
}

class FetchPaymentMethod extends PaymentMethodEvent {
  final PaymentMethod paymentMethod;

  FetchPaymentMethod(this.paymentMethod);

  @override
  List<Object> get props => [paymentMethod];

  @override
  String toString() => 'FetchPaymentMethod(paymentMethod: $paymentMethod)';
}

class AddPaymentMethod extends PaymentMethodEvent {
  final PaymentMethod paymentMethod;

  AddPaymentMethod(this.paymentMethod);

  @override
  List<Object> get props => [paymentMethod];

  @override
  String toString() => 'AddPaymentMethod(paymentMethod: $paymentMethod)';
}

class RemovePaymentMethod extends PaymentMethodEvent {
  final PaymentMethod paymentMethod;

  RemovePaymentMethod(this.paymentMethod);

  @override
  List<Object> get props => [paymentMethod];

  @override
  String toString() => 'PaymentMethod(address: $paymentMethod)';
}
