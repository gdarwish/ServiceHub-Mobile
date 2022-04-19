import 'package:ServiceHub/models/settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'custom_checkbox.dart';

class FilterSliderDialogContent extends StatefulWidget {
  @override
  _FilterSliderDialogContentState createState() =>
      _FilterSliderDialogContentState();
}

class _FilterSliderDialogContentState extends State<FilterSliderDialogContent> {
  @override
  Widget build(BuildContext context) {
    // print('DISTANCE: ' + Settings().distanceFilter.toString());
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 250.0,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Distance',
              ),
            ],
          ),
          Slider(
            value: Settings().distanceFilter.toDouble(),
            min: 25,
            max: 250,
            divisions: 9,
            label: Settings().distanceFilter.toString() + ' km',
            onChanged: (double value) {
              setState(() {
                Settings().distanceFilter = value.toInt();
              });
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Service Type',
              ),
            ],
          ),
          CustomCheckbox(
            checkboxMessage: 'Snow Removal',
            checkboxSatus: Settings().snowFilter,
            onChanged: (value) {
              Settings().snowFilter = value;
            },
          ),
          CustomCheckbox(
            checkboxMessage: 'Lawn Mowing',
            checkboxSatus: Settings().lawnFilter,
            onChanged: (value) {
              Settings().lawnFilter = value;
            },
          ),
        ],
      ),
    );
  }
}
