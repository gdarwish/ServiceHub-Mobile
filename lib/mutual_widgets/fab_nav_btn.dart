import 'package:flutter/material.dart';

Widget fabNavBtn(IconData icon, Color color, Function onTap) {
  return FloatingActionButton(
    backgroundColor: color,
    child: Icon(
      icon,
      size: 30.0,
    ),
    onPressed: onTap,
  );
}
