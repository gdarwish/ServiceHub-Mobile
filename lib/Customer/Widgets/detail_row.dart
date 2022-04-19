import 'package:ServiceHub/constants.dart';
import 'package:flutter/material.dart';

Widget detailRow(IconData icon, String text,
    {Function onTap, TextDecoration decoration = TextDecoration.none}) {
  return Row(
    children: [
      Icon(
        icon,
        size: 25.0,
        color: kPrimaryColor,
      ),
      SizedBox(
        width: 10,
      ),
      Expanded(
        child: InkWell(
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            style: TextStyle(
                color: Colors.black,
                decoration: decoration,
                fontWeight: FontWeight.w400,
                fontSize: 20.0),
          ),
          onTap: onTap,
        ),
      ),
    ],
  );
}
