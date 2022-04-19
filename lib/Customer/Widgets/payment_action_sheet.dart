import 'package:ServiceHub/Customer/Widgets/add_payment_method.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/data_source/data.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/credit-card.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/payment-method.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/mutual_widgets/add_alert_dialog.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentActionSheet extends StatefulWidget {
  ServiceRequest serviceRequest;

  @override
  _PaymentActionSheetState createState() => _PaymentActionSheetState();
}

class _PaymentActionSheetState extends State<PaymentActionSheet> {
  var textFieldController = TextEditingController();
  final PaymentMethod paymentMethod = PaymentMethod(card: CreditCard());
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  IconData prefixIcon;

  @override
  Widget build(BuildContext context) {
    final paymentMethods = (Account.currentUser as Customer).paymentMethods;

    return GestureDetector(
      onTap: () {
        showAdaptiveActionSheet(
          context: context,
          title: const Text('Payments Methods'),
          actions: <BottomSheetAction>[
            ...paymentMethods.map(
              (paymentCard) => BottomSheetAction(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Text(
                    //   paymentCard.card.type.toString().split('.').last,
                    //   style: TextStyle(
                    //       fontSize: 16.0, fontWeight: FontWeight.bold),
                    // ),
                    Icon(paymentCard.card.icon),
                    Text(
                      '**** **** **** ${paymentCard.card.last4Digits}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                    Text('Expires ${paymentCard.card.fExpiryDate}',
                        style: TextStyle(fontSize: 16.0)),
                  ],
                ),
                onPressed: () {
                  setState(() {
                    textFieldController.text =
                        '**** **** **** ${paymentCard.card.last4Digits} - Expires ${paymentCard.card.fExpiryDate}';
                    prefixIcon = paymentCard.card.icon;
                    Navigator.of(context).pop();
                  });
                },
              ),
            ),
            BottomSheetAction(
              title: const Text('+ Add new Payment Method'),
              onPressed: () {
                Navigator.pop(context);
                addAlertDialog(
                  context: context,
                  title: 'Add new Payment Method',
                  onTap: () {
                    final valid = formKey.currentState.validate();
                    if (!valid) return;

                    // TODO:: add new payment
                    final user = Account.currentUser;
                    if (user is Customer) {
                      // user.paymentMethods.add(PaymentMethod(card: creditCard));
                      BlocProvider.of<PaymentMethodBloc>(context)
                          .add(AddPaymentMethod(paymentMethod));
                    }

                    //customSnackBar(creditCard.toString(), context);
                    // Navigator.pop(context);
                  },
                  mainBtnText: 'Add',
                  content: BlocListener<PaymentMethodBloc, PaymentMethodState>(
                    listener: (context, state) {
                      if (state is PaymentMethodAddedState) {
                        BlocProvider.of<PaymentMethodBloc>(context)
                            .add(FetchPaymentMethods());
                        successSnackBar(
                            'Payment Method has been added.', context);
                        Navigator.pop(context);
                      }

                      if (state is PaymentMethodFailureState) {
                        failureSnackBar(state.apiError.message, context);
                      }
                    },
                    child: PaymentMethodWidget(
                      creditCard: paymentMethod.card,
                      formKey: formKey,
                    ),
                  ),
                );
              },
            ),
          ],
          cancelAction: CancelAction(
            title: Text('Cancel'),
          ),
        );
      },
      child: TextField(
        enabled: false,
        textInputAction: TextInputAction.done,
        maxLines: null,
        controller: textFieldController,
        decoration: InputDecoration(
          // prefixIcon: Icon(prefixIcon),
          filled: true,
          fillColor: Colors.white,
          labelText: 'Payment',
          labelStyle: TextStyle(color: Colors.black),
          contentPadding: EdgeInsets.all(16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
    );
  }
}
