import 'package:ServiceHub/models/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_checkbox.dart';

class FilterAlertDialog extends StatefulWidget {
  @override
  _FilterAlertDialogState createState() => _FilterAlertDialogState();
}

class _FilterAlertDialogState extends State<FilterAlertDialog> {
  bool snowRemovalvalue = false;
  bool lawnMowingvalue = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 130.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomCheckbox(
              checkboxMessage: 'Snow Removal',
              checkboxSatus: Settings().snowFilter,
              onChanged: (value) {
                Settings().snowFilter = value;
              }),
          CustomCheckbox(
              checkboxMessage: 'Lawn Mowing',
              checkboxSatus: Settings().lawnFilter,
              onChanged: (value) {
                Settings().lawnFilter = value;
              }),
        ],
      ),
    );
  }
}
