import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final Function onTap;
  final Color color;

  SecondaryButton({
    this.label,
    this.icon,
    this.onTap,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton.icon(
          label: Text(
            label,
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w600),
          ),
          icon: Icon(icon),
          onPressed: onTap,
          style: ElevatedButton.styleFrom(primary: color),
        ),
      ),
    );
  }
}
