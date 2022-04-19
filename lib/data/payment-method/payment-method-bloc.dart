import 'package:ServiceHub/api/connection.dart';
import 'package:ServiceHub/api/payment-method-api.dart';
import 'package:ServiceHub/db/payment-method-db.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/api-error.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/payment-method.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'payment-method.dart';

class PaymentMethodBloc extends Bloc<PaymentMethodEvent, PaymentMethodState> {
  final _paymentMethodAPI = PaymentMethodAPI();
  final _paymentMethodDB = PaymentMethodDB();

  PaymentMethodBloc() : super(PaymentMethodInitState());

  @override
  Stream<PaymentMethodState> mapEventToState(PaymentMethodEvent event) async* {
    if (event is ResetPaymentMethod) {
      yield PaymentMethodInitState();
    } else if (event is FetchPaymentMethods) {
      yield* _mapFetchPaymentMethodsToState(event);
    } else if (event is FetchPaymentMethod) {
      yield* _mapFetchPaymentMethodToState(event);
    } else if (event is AddPaymentMethod) {
      yield* _mapPostPaymentMethodToState(event);
    } else if (event is RemovePaymentMethod) {
      yield* _mapRemovePaymentMethodToState(event);
    }
  }

  Stream<PaymentMethodState> _mapFetchPaymentMethodToState(
      FetchPaymentMethod event) async* {
    try {
      yield PaymentMethodsFetchingState();
      // return same payment method (payment methods are immutable :)
      PaymentMethod data = event.paymentMethod;

      if (data != null && data is PaymentMethod) {
        yield PaymentMethodFetchedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield PaymentMethodFailureState(apiError);
    } catch (error) {
      yield PaymentMethodFailureState(APIError(message: error.toString()));
    }
  }

  Stream<PaymentMethodState> _mapFetchPaymentMethodsToState(
      FetchPaymentMethods event) async* {
    try {
      yield PaymentMethodsFetchingState();
      List<PaymentMethod> data;

      final isConnected = await Connection().isConnected();
      if (isConnected) {
        data = await _paymentMethodAPI.fetchPaymentMethods();
      } else {
        data = await _paymentMethodDB.getPaymentMethods();
      }

      if (data != null && data is List<PaymentMethod>) {
        yield PaymentMethodsFetchedState(data);
        // Update user paymentMethods
        (Account.currentUser as Customer).paymentMethods = data;

        // Update local records
        if (isConnected) _paymentMethodDB.savePaymentMethods(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield PaymentMethodFailureState(apiError);
    } catch (error) {
      yield PaymentMethodFailureState(APIError(message: error.toString()));
    }
  }

  Stream<PaymentMethodState> _mapPostPaymentMethodToState(
      AddPaymentMethod event) async* {
    try {
      yield PaymentMethodsFetchingState();
      final data =
          await _paymentMethodAPI.addPaymentMethod(event.paymentMethod);
      if (data != null && data is PaymentMethod) {
        if (!(Account.currentUser as Customer).paymentMethods.contains(data))
          (Account.currentUser as Customer).paymentMethods.add(data);

        yield PaymentMethodAddedState(data);
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield PaymentMethodFailureState(apiError);
    } catch (error) {
      yield PaymentMethodFailureState(APIError(message: error.toString()));
    }
  }

  Stream<PaymentMethodState> _mapRemovePaymentMethodToState(
      RemovePaymentMethod event) async* {
    try {
      yield PaymentMethodRemovingState();
      final removed =
          await _paymentMethodAPI.removePaymentMethod(event.paymentMethod);
      if (removed) {
        if ((Account.currentUser as Customer)
            .paymentMethods
            .contains(event.paymentMethod))
          (Account.currentUser as Customer)
              .paymentMethods
              .remove(event.paymentMethod);

        yield PaymentMethodRemovedState();
      } else {
        throw APIError();
      }
    } on APIError catch (apiError) {
      yield PaymentMethodFailureState(apiError);
    } catch (error) {
      yield PaymentMethodFailureState(APIError(message: error.toString()));
    }
  }
}
