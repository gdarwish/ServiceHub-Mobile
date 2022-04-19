import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/credit-card.dart';
import 'package:ServiceHub/models/payment-method.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PaymentCard extends StatelessWidget {
  // final String cardType;
  // final String last4nums;
  // final String cardHolderName;
  // final String cardExpiry;
  // final Color color;
  final CreditCard card;
  final Function cancelOnTap;

  const PaymentCard({
    // this.cardType,
    // this.last4nums,
    // this.cardHolderName,
    // this.cardExpiry,
    // this.color,
    this.card,
    this.cancelOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        color: card.color,
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0),
          width: MediaQuery.of(context).size.width,
          height: 200.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Text(
                  //   card.type.toUpperCase(),
                  //   style: TextStyle(
                  //     fontSize: 16.0,
                  //     color: Colors.white,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  Row(
                    children: [
                      Icon(
                        card.icon,
                        color: Colors.white,
                        size: 30,
                      ),
                      SizedBox(width: 10),
                      Text(
                        card.type.toUpperCase(),
                        style: TextStyle(
                          fontSize: 16.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.cancel,
                      size: 30.0,
                      color: Colors.white,
                    ),
                    onPressed: cancelOnTap,
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    '**** **** **** ${card.last4Digits ?? ''}',
                    style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Card Holder',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'Card Expiry',
                        style: TextStyle(
                          fontSize: 15.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        card.name.isNotEmpty
                            ? card.name
                            : Account.currentUser?.fullName,
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        card.fExpiryDate ?? '',
                        style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
