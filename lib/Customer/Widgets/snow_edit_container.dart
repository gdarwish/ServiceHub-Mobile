import 'package:ServiceHub/models/snow-request.dart';
import 'package:ServiceHub/mutual_widgets/drop_down_text_field.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter/material.dart';

class SnowEditContainer extends StatelessWidget {
  final SnowRequest snowRequest;
  SnowEditContainer(this.snowRequest) {
    if (!drivewayList.contains(snowRequest.driveway)) {
      snowRequest.driveway = drivewayList.first;
    } else {
      snowRequest.driveway ??= drivewayList.first;
    }
    snowRequest.sidewalk ??= false;
    snowRequest.walkway ??= false;
    snowRequest.salting ??= false;
  }

  String priceValue;
  String addresscurrentSelectedValue;

  final List<String> drivewayList = [
    "Small (Fits 2 cars)",
    "Medium (Fits 4 cars)",
    "Large (Fits 6 cars)",
  ];

  List<String> optionsList = [
    "YES",
    "NO",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          DropDownTextField(
            list: drivewayList,
            labelText: 'Driveway',
            hintText: 'Tap',
            selected: snowRequest.driveway,
            onSelected: (value) => snowRequest.driveway = value,
          ),
          spacer(),
          DropDownTextField(
            list: optionsList,
            labelText: 'Walkway',
            hintText: 'Tap',
            selected: optionsList[snowRequest.walkway ? 0 : 1],
            onSelected: (value) => snowRequest.walkway = (value == 'YES'),
          ),
          spacer(),
          DropDownTextField(
            list: optionsList,
            labelText: 'SideWalk',
            hintText: 'Tap',
            selected: optionsList[snowRequest.walkway ? 0 : 1],
            onSelected: (value) => snowRequest.sidewalk = (value == 'YES'),
          ),
          spacer(),
          DropDownTextField(
            list: optionsList,
            labelText: 'Salting',
            hintText: 'Tap',
            selected: optionsList[snowRequest.salting ? 0 : 1],
            onSelected: (value) => snowRequest.salting = (value == 'YES'),
          ),
        ],
      ),
    );
  }
}
