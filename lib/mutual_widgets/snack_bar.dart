import 'package:ServiceHub/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void customSnackBar(String text, BuildContext context, {Color color}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        text,
        style: TextStyle(
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: color,
      action: SnackBarAction(
        label: 'OK',
        textColor: Colors.white,
        onPressed: () {
          // Some code to undo the change.
        },
      ),
    ),
  );
}

void successSnackBar(String text, BuildContext context) {
  customSnackBar(text, context, color: kSuccessColor);
}

void failureSnackBar(String text, BuildContext context) {
  customSnackBar(text, context, color: kFailureColor);
}
