import 'package:ServiceHub/mutual_widgets/asset_image.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter/cupertino.dart';

class HaveServiceRequestContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'You already have a service request!',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w400),
          ),
          spacer(),
          assetImage('images/work.png', context),
        ],
      ),
    );
  }
}
