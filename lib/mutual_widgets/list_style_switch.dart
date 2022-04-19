import 'package:ServiceHub/constants.dart';
import 'package:ServiceHub/db/settings-db.dart';
import 'package:ServiceHub/models/settings.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:toggle_switch/toggle_switch.dart';

class ListStyleSwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ToggleSwitch(
      minWidth: 75.0,
      initialLabelIndex: Settings().listStyle,
      cornerRadius: 20.0,
      activeFgColor: Colors.white,
      inactiveBgColor: Colors.grey,
      inactiveFgColor: Colors.white,
      labels: ['List', 'Grid'],
      icons: [FontAwesomeIcons.list, FontAwesomeIcons.gripVertical],
      activeBgColors: [kPrimaryColor, kPrimaryColor],
      onToggle: (style)  {
        Settings().listStyle = style;
        SettingsDB().saveSettings(Settings());
      },
    );
  }
}