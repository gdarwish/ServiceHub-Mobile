import 'package:ServiceHub/Customer/Screens/add_payment_screen.dart';
import 'package:ServiceHub/Customer/Widgets/payment_card.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/payment-method.dart';
import 'package:ServiceHub/mutual_screens/error_screen500.dart';
import 'package:ServiceHub/mutual_screens/no_data_screen.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/native_alert.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PaymentsScreen extends StatefulWidget {
  static const route = '/PaymentsScreen';

  @override
  _PaymentsScreenState createState() => _PaymentsScreenState();
}

class _PaymentsScreenState extends State<PaymentsScreen> {
  // final paymentMethods = (Account.currentUser as Customer).paymentMethods;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Payment'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              //Navigate to AddNewCardScreen
              Navigator.pushNamed(context, AddPaymentMethodScreen.route);
            },
          )
        ],
      ),
      body: BlocConsumer<PaymentMethodBloc, PaymentMethodState>(
          listener: (context, state) {
        if (state is PaymentMethodRemovedState) {
          successSnackBar('Payment Method has been removed.', context);
          _fetchPaymentMethods(context);
        }
        if (state is PaymentMethodFailureState) {
          failureSnackBar(state.apiError.message, context);
        }
      }, builder: (context, state) {
        if (state is PaymentMethodInitState) {
          _fetchPaymentMethods(context);
          return Container();
        }
        if (state is PaymentMethodsFetchingState ||
            state is PaymentMethodRemovingState) {
          return CustomProgressIndicator();
        }
        if (state is PaymentMethodsFetchedState) {
          return _buildPaymentMethods(state.paymentMethods);
        }

        return ErrorScreen500(onRefresh: _fetchPaymentMethods);
      }),
    );
  }

  Widget _buildPaymentMethods(List<PaymentMethod> paymentMethods) {
    if (paymentMethods.isNotEmpty) {
      return RefreshIndicator(
        onRefresh: () async => _fetchPaymentMethods(context),
        child: ListView.builder(
          itemCount: paymentMethods.length,
          itemBuilder: (_, index) {
            final paymentMethod = paymentMethods[index];
            return PaymentCard(
              card: paymentMethod.card,
              cancelOnTap: () {
                nativeAlert(
                  context: context,
                  title: 'Warning',
                  body: 'Are you sure you want to remove this Payment Method?',
                  btnText: 'Confirm',
                  onTap: () {
                    // Cancel card
                    // setState(
                    //   () {
                    //     paymentMethods.removeAt(index);
                    //     Navigator.pop(context);
                    //   },
                    // );

                    BlocProvider.of<PaymentMethodBloc>(context)
                        .add(RemovePaymentMethod(paymentMethod));
                    Navigator.pop(context);
                  },
                );
              },
            );
          },
        ),
      );
    }

    if (paymentMethods.isEmpty) {
      return NoDataScreen(
        message: 'You currently don\'t have any saved Payment Methods!',
        onRefresh: (context) {},
      );
    }
  }

  void _fetchPaymentMethods(BuildContext context) {
    BlocProvider.of<PaymentMethodBloc>(context).add(FetchPaymentMethods());
  }
}
