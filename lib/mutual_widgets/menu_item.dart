import 'package:flutter/cupertino.dart';
import '../constants.dart';

class MenuItem extends StatelessWidget {
  final String text;
  final IconData icon;
  final Color color;

  const MenuItem({
    this.text,
    this.icon,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          color: color ?? kPrimaryColor,
        ),
        SizedBox(
          width: 15.0,
        ),
        Text(text),
      ],
    );
  }
}
