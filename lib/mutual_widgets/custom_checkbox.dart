import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomCheckbox extends StatefulWidget {
  String checkboxMessage;
  bool checkboxSatus;
  Function(bool) onChanged;
  CustomCheckbox({this.checkboxMessage, this.checkboxSatus, this.onChanged});

  @override
  _CustomCheckboxState createState() => _CustomCheckboxState();
}

class _CustomCheckboxState extends State<CustomCheckbox> {
  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
      contentPadding: EdgeInsets.all(0),
      title: Text(widget.checkboxMessage),
      value: widget.checkboxSatus,
      onChanged: (newValue) {
        setState(() {
          widget.checkboxSatus = newValue;
          widget.onChanged(newValue);
        });
      },
      controlAffinity: ListTileControlAffinity.leading,
    );
  }
}
