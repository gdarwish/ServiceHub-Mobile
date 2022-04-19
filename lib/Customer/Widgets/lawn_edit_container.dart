import 'package:ServiceHub/models/lawn-request.dart';
import 'package:flutter/cupertino.dart';

import 'package:ServiceHub/mutual_widgets/drop_down_text_field.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';

class LawnEditContainer extends StatelessWidget {
  LawnEditContainer(this.lawnRequest) {
    if (!yard.contains(lawnRequest.frontyard)) {
      lawnRequest.frontyard = yard.first;
    } else {
      lawnRequest.frontyard ??= yard.first;
    }
    if (!grass.contains(lawnRequest.grassLength)) {
      lawnRequest.grassLength = grass.first;
    } else {
      lawnRequest.grassLength ??= grass.first;
    }
    if (!yard.contains(lawnRequest.backyard)) {
      lawnRequest.backyard = yard.first;
    } else {
      lawnRequest.backyard ??= yard.first;
    }
    if (!yard.contains(lawnRequest.sideyard)) {
      lawnRequest.sideyard = yard.first;
    } else {
      lawnRequest.sideyard ??= yard.first;
    }
    lawnRequest.clearClipping ??= false;
    lawnRequest.stringTrimming ??= false;
  }

  final LawnRequest lawnRequest;
  String priceValue;
  String addresscurrentSelectedValue;

  List<String> grass = [
    "Under 6 inches ",
    "6 to 10 inches ",
    "Over 10 inches ",
  ];

  List<String> yard = [
    "Small (50 - 100) sq.ft",
    "Medium (100 - 200) sq.ft",
    "Large (200 - 300) sq.ft",
  ];

  List<String> boolList = [
    "YES",
    "NO",
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          DropDownTextField(
            list: grass,
            labelText: 'Grass length',
            hintText: 'Tap',
            selected: lawnRequest.grassLength,
            onSelected: (value) => lawnRequest.grassLength = value,
          ),
          spacer(),
          DropDownTextField(
            list: yard,
            labelText: 'Front yard',
            hintText: 'Tap',
            selected: lawnRequest.frontyard,
            onSelected: (value) => lawnRequest.frontyard = value,
          ),
          spacer(),
          DropDownTextField(
            list: yard,
            labelText: 'Back yard',
            hintText: 'Tap',
            selected: lawnRequest.backyard,
            onSelected: (value) => lawnRequest.backyard = value,
          ),
          spacer(),
          DropDownTextField(
            list: yard,
            labelText: 'Side yard',
            hintText: 'Tap',
            selected: lawnRequest.sideyard,
            onSelected: (value) => lawnRequest.sideyard = value,
          ),
          spacer(),
          DropDownTextField(
            list: boolList,
            labelText: 'Clear Clipping',
            hintText: 'Tap',
            selected: boolList[lawnRequest.clearClipping ? 0 : 1],
            onSelected: (value) => lawnRequest.clearClipping = (value == 'YES'),
          ),
          spacer(),
          DropDownTextField(
            list: boolList,
            labelText: 'String Trimming',
            hintText: 'Tap',
            selected: boolList[lawnRequest.stringTrimming ? 0 : 1],
            onSelected: (value) =>
                lawnRequest.stringTrimming = (value == 'YES'),
          ),
        ],
      ),
    );
  }
}
