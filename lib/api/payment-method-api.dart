import 'package:ServiceHub/api/stripe-api.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/payment-method.dart';
import 'package:ServiceHub/api/main-api.dart';

class PaymentMethodAPI {
  static final PaymentMethodAPI _instance = PaymentMethodAPI._internal();

  factory PaymentMethodAPI() => _instance;

  PaymentMethodAPI._internal();

  Future<List<PaymentMethod>> fetchPaymentMethods() async {
    final data = await MainAPI().get('/customer/payment-methods');

    if (data != null) {
      return List<PaymentMethod>.from(
        data.map((paymentMethod) => PaymentMethod.fromMap(paymentMethod)),
      );
    }

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<PaymentMethod> fetchPaymentMethod(PaymentMethod paymentMethod) async {
    final data =
        await MainAPI().get('/customer/payment-methods/${paymentMethod.id}');

    if (data != null) {
      return PaymentMethod.fromMap(data);
    }

    // if you hit this line, something weird is going on :)
    throw APIError();
  }

  Future<bool> removePaymentMethod(PaymentMethod paymentMethod) async {
    final data =
        await MainAPI().delete('/customer/payment-methods/${paymentMethod.id}');
    return data != null;
  }

  Future<PaymentMethod> addPaymentMethod(PaymentMethod paymentMethod) async {
    final customer = (Account.currentUser as Customer);

    // Create stripe customer (if not already created)
    if (customer.stripeCustomer == null) {
      final createCustomerResponse = await StripeAPI().post('/customers', {
        'name': customer.fullName,
        'email': customer.email,
      });

      if (createCustomerResponse == null) {
        throw APIError(message: 'Failed to create stripe customer.');
      }

      // Set customer stripe Id [IMPORTANT]
      customer.stripeCustomer = createCustomerResponse['id'];
    }

    // Create stripe payment method
    final paymentMethodResponse = await StripeAPI().post(
      '/payment_methods',
      paymentMethod.card.toMap(),
    );
    
    // final paymentMethodResponse = await StripeAPI().post('/payment_methods', {
    //   'type': 'card',
    //   'card[number]': paymentMethod.card.cardNumber,
    //   'card[exp_month]': paymentMethod.card.expMonth,
    //   'card[exp_year]': paymentMethod.card.expYear,
    //   'card[cvc]': paymentMethod.card.cvv,
    // });

    if (paymentMethodResponse == null) {
      throw APIError(message: 'Failed to create stripe payment method.');
    }

    if (paymentMethodResponse['error'] != null) {
      throw APIError(message: paymentMethodResponse['error']['message']);
    }

    final paymentMethodId = paymentMethodResponse['id'];
    if (paymentMethodId != null) {
      final attachePaymentMethodResponse = await StripeAPI().post(
        '/payment_methods/$paymentMethodId/attach',
        {'customer': Account.currentUser.stripeCustomer},
      );

      if (attachePaymentMethodResponse == null) {
        throw APIError(
          message: 'Failed to attach payment method to a customer.',
        );
      }

      if (attachePaymentMethodResponse['error'] != null) {
        throw APIError(
            message: attachePaymentMethodResponse['error']['message']);
      }

      return PaymentMethod.fromMap({'data': paymentMethodResponse});
    }

    // if you hit this line, something weird is going on :)
    throw APIError();
  }
}
