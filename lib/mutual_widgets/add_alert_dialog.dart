import 'package:flutter/material.dart';

void addAlertDialog({
  BuildContext context,
  String title,
  Function onTap,
  Function onPop,
  String mainBtnText,
  Widget content,
}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text(title),
        content: content,
        actions: <Widget>[
          TextButton(
            child: Text("Close"),
            onPressed: () {
              if (onPop != null) onPop();
              Navigator.of(context).pop();
            },
          ),
          if (mainBtnText != null)
            TextButton(
              child: Text(mainBtnText),
              onPressed: onTap ?? () {},
            ),
        ],
      );
    },
  );
}
