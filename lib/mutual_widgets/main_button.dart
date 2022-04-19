import 'package:ServiceHub/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget mainBtn(String title, Function onPressed) {
  return Container(
    width: double.infinity,
    child: RaisedButton(
      elevation: 5.0,
      onPressed: onPressed,
      padding: EdgeInsets.all(13.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      color: kPrimaryColor,
      child: Text(
        title,
        style: TextStyle(
          color: Colors.white,
          letterSpacing: 1.0,
          fontSize: 18.0,
          fontWeight: FontWeight.w400,
          fontFamily: 'OpenSans',
        ),
      ),
    ),
  );
}
