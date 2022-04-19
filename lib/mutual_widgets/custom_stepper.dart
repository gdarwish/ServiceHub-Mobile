import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ServiceHub/constants.dart';

class CustomStepper extends StatelessWidget {
  final bool serviceDetail;
  final bool reviewAndPayment;

  const CustomStepper({
    this.serviceDetail = false,
    this.reviewAndPayment = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: kPrimaryColor,
                child: Text(
                  '1',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              Text(
                'Service Type',
                style: TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          ),
          Column(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor:
                    serviceDetail ? kPrimaryColor : Colors.grey[600],
                child: Text(
                  '2',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w600,
                      color: Colors.white),
                ),
              ),
              Text(
                'Service Details',
                style: TextStyle(fontWeight: FontWeight.w600),
              )
            ],
          ),
          Column(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor:
                    reviewAndPayment ? kPrimaryColor : Colors.grey[600],
                child: Text(
                  '3',
                  style: TextStyle(
                      fontSize: 15.0,
                      fontWeight: FontWeight.w500,
                      color: Colors.white),
                ),
              ),
              Text('Review & Payment',
                  style: TextStyle(fontWeight: FontWeight.w600))
            ],
          )
        ],
      ),
    );
  }
}
