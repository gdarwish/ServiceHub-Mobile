import 'package:ServiceHub/Customer/Screens/add_service_screen.dart';
import 'package:ServiceHub/Customer/Widgets/service_type_box.dart';
import 'package:ServiceHub/constants.dart';
import 'package:ServiceHub/models/lawn-request.dart';
import 'package:ServiceHub/models/snow-request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SelectRequestType extends StatelessWidget {
  static const route = '/SelectRequestType';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select service'),
      ),
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AddServiceScreen.route,
                        arguments: SnowRequest);
                  },
                  child: Container(color: kSnowBoxColor),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AddServiceScreen.route,
                        arguments: LawnRequest);
                  },
                  child: Container(
                    color: kLawnBoxColor,
                  ),
                ),
              )
            ],
          ),
          Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              ServiceTypeBox(
                type: SnowRequest,
                title: 'Snow Removing',
                imageUrl: "images/shovel.png",
                color: kSnowBoxColor,
                borderRadius: new BorderRadius.only(
                  bottomRight: const Radius.circular(100.0),
                ),
              ),
              ServiceTypeBox(
                type: LawnRequest,
                title: 'Lawn Mowing',
                imageUrl: "images/mowing.png",
                color: kLawnBoxColor,
                borderRadius: new BorderRadius.only(
                  topLeft: const Radius.circular(100.0),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
