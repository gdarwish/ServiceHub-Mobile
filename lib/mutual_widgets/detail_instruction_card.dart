import 'package:flutter/material.dart';

import '../constants.dart';

Widget detailInstructionCard(String title, String value) {
  return Card(
    color: Colors.white,
    margin: EdgeInsets.all(5.0),
    elevation: 5,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(7.0),
    ),
    child: Padding(
      padding: const EdgeInsets.all(12.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: kCardDetailStyle,
          ),
          Text(value, style: kCardDetailStyle),
        ],
      ),
    ),
  );
}
