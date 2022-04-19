import 'package:ServiceHub/db/main-db.dart';
import 'package:ServiceHub/models/payment-method.dart';

class PaymentMethodDB {
  static final PaymentMethodDB _instance = PaymentMethodDB._internal();

  factory PaymentMethodDB() => _instance;

  PaymentMethodDB._internal();

  Future<List<PaymentMethod>> getPaymentMethods() async {
    List<PaymentMethod> paymentMethods = [];

    paymentMethods =
        await MainDB().getAll<PaymentMethod>(MainDB.PaymentMethodBox);

    return paymentMethods;
  }

  Future<void> savePaymentMethods(List<PaymentMethod> paymentMethods) async {
    MainDB().insertAll<PaymentMethod>(MainDB.PaymentMethodBox,
        object: paymentMethods);
  }
}
