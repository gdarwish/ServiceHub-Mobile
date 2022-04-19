import 'package:ServiceHub/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SettingsCard extends StatelessWidget {
  final String title;
  final IconData iconData;
  final Function onTap;
  final Widget trailingBtn;

  const SettingsCard(
      {this.title,
      this.iconData,
      this.onTap,
      this.trailingBtn = const Icon(FontAwesomeIcons.chevronRight)});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          iconData,
          color: kPrimaryColor,
        ),
        title: Text(title),
        trailing: trailingBtn,
        onTap: onTap,
      ),
    );
  }
}
