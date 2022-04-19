import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Future<void> nativeAlert({
  BuildContext context,
  String title,
  String body,
  String btnText,
  Function onTap,
}) async {
  if (Platform.isAndroid) {
    // Android-specific code
    await showDialog(
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
            if (btnText != null && onTap != null)
              new TextButton(
                child: new Text(btnText),
                onPressed: onTap,
              ),
          ],
        );
      },
    );
  } else if (Platform.isIOS) {
    // iOS-specific code
    await showDialog(
      context: context,
      builder: (BuildContext context) => new CupertinoAlertDialog(
        title: new Text(title),
        content: new Text(body),
        actions: [
          CupertinoDialogAction(
            isDefaultAction: true,
            child: new Text("Close"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          if (btnText != null && onTap != null)
            CupertinoDialogAction(
              isDefaultAction: false,
              child: new Text(btnText),
              onPressed: onTap,
            )
        ],
      ),
    );
  }
}
