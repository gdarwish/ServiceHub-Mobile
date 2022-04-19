import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

class BottonNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onPressed;

  BottonNav(this.currentIndex, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      child: Container(
        height: 70,
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            IconButton(
              icon: Icon(
                Icons.home,
                size: 30.0,
                color: currentIndex == 0 ? kPrimaryColor : Colors.grey.shade400,
              ),
              onPressed: () => onPressed(0),
            ),
            spacer(),
            IconButton(
              icon: Icon(
                Icons.settings,
                size: 30.0,
                color: currentIndex == 1 ? kPrimaryColor : Colors.grey.shade400,
              ),
              onPressed: () => onPressed(1),
            ),
          ],
        ),
      ),
    );
  }
}
