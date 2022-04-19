import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void customDialog(BuildContext context, String title, String body,
    String btnText, Function onTap) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: <Widget>[
          new TextButton(
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          new TextButton(
            child: new Text(btnText),
            onPressed: onTap,
          ),
        ],
      );
    },
  );
}
