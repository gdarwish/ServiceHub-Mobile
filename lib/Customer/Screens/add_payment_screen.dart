import 'package:ServiceHub/Customer/Widgets/add_payment_method.dart';
import 'package:ServiceHub/data/payment-method/payment-method-bloc.dart';
import 'package:ServiceHub/data/payment-method/payment-method.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/credit-card.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/payment-method.dart';
import 'package:ServiceHub/mutual_widgets/main_button.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddPaymentMethodScreen extends StatelessWidget {
  static const route = '/AddPaymentMethodScreen';

  final PaymentMethod paymentMethod = PaymentMethod(card: CreditCard());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Payment Method'),
      ),
      body: BlocConsumer<PaymentMethodBloc, PaymentMethodState>(
        listener: (context, state) {
          if (state is PaymentMethodAddedState) {
            BlocProvider.of<PaymentMethodBloc>(context)
                .add(FetchPaymentMethods());
            successSnackBar('Payment Method has been added.', context);
            Navigator.pop(context);
          }

          if (state is PaymentMethodFailureState) {
            failureSnackBar(state.apiError.message, context);
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Flexible(
                child: Container(
                  height: 600.0,
                  child: PaymentMethodWidget(
                    creditCard: paymentMethod.card,
                    formKey: formKey,
                  ),
                ),
              ),
              spacer(),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: mainBtn(
                  'Add New Card',
                  () {
                    final valid = formKey.currentState.validate();
                    if (!valid) return;

                    //TODO:: Add new payment method

                    // TODO:: add new payment
                    final user = Account.currentUser;
                    if (user is Customer) {
                      // user.paymentMethods.add(PaymentMethod(card: creditCard));
                      BlocProvider.of<PaymentMethodBloc>(context)
                          .add(AddPaymentMethod(paymentMethod));
                    }

                    // onChange(() {});
                    // Navigator.pop(context);
                  },
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
