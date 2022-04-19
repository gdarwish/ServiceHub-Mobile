import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_credit_card/credit_card_form.dart';
import 'package:flutter_credit_card/credit_card_model.dart';
import 'package:flutter_credit_card/credit_card_widget.dart';

import 'package:ServiceHub/models/credit-card.dart';

class PaymentMethodWidget extends StatefulWidget {
  final CreditCard creditCard;
  final GlobalKey formKey;

  PaymentMethodWidget({this.creditCard, this.formKey});

  @override
  _PaymentMethodWidgetState createState() => _PaymentMethodWidgetState();
}

class _PaymentMethodWidgetState extends State<PaymentMethodWidget> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    // final creditCard = widget.creditCard;

    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                CreditCardWidget(
                  cardNumber: widget.creditCard.cardNumber,
                  expiryDate: widget.creditCard.expiryDate,
                  cardHolderName: widget.creditCard.name,
                  cvvCode: widget.creditCard.cvv,
                  showBackView: isCvvFocused,
                  obscureCardNumber: true,
                  obscureCardCvv: true,
                ),
                // spacer(),
                CreditCardForm(
                  formKey: widget.formKey,
                  obscureCvv: true,
                  obscureNumber: true,
                  cardNumberDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Number',
                    hintText: 'XXXX XXXX XXXX XXXX',
                  ),
                  expiryDateDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Expired Date',
                    hintText: 'XX/XX',
                  ),
                  cvvCodeDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'CVV',
                    hintText: 'XXX',
                  ),
                  cardHolderDecoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Card Holder',
                  ),
                  onCreditCardModelChange: onCreditCardModelChange,
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    final creditCard = widget.creditCard;
    setState(() {
      creditCard.cardNumber = creditCardModel.cardNumber;
      creditCard.expiryDate = creditCardModel.expiryDate;
      creditCard.name = creditCardModel.cardHolderName;
      creditCard.cvv = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
      if (creditCardModel.expiryDate.length == 5) {
        creditCard.expMonth =
            int.tryParse(creditCardModel.expiryDate.substring(0, 2)) ?? 0;
        creditCard.expYear =
            int.tryParse(creditCardModel.expiryDate.substring(3, 5)) ?? 0;
      }
    });
  }
}
