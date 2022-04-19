import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ConfirmReviewButton extends StatelessWidget {
  RoundedRectangleBorder rectangleBorder;
  String title;
  Function onTap;
  Color color;

  ConfirmReviewButton({
    this.rectangleBorder,
    this.title,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      padding: EdgeInsets.only(left: 50, right: 50),
      onPressed: onTap,
      shape: rectangleBorder,
      child: Text(
        title,
        style: TextStyle(fontSize: 15.0),
      ),
      color: color,
      textColor: Colors.white,
    );
  }
}
