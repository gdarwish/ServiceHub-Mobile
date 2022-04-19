import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget pageTitle(String title) {
  return Text(
    title,
    style: TextStyle(
      color: Colors.black,
      fontFamily: 'OpenSans',
      fontSize: 30.0,
      fontWeight: FontWeight.w400,
    ),
  );
}
