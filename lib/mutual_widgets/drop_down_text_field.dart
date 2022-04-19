import 'package:ServiceHub/mutual_widgets/platform_switch.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../constants.dart';

class DropDownTextField extends StatefulWidget {
  List<String> list = <String>[];
  var textFieldController = TextEditingController();

  String labelText;
  String hintText;
  String selected;
  Function(dynamic) onSelected;

  DropDownTextField({
    this.list,
    this.labelText,
    this.hintText,
    this.textFieldController,
    this.selected = '',
    this.onSelected,
  });

  @override
  _DropDownTextFieldState createState() => _DropDownTextFieldState();
}

class _DropDownTextFieldState extends State<DropDownTextField> {
  int selectedValue = 0;
  String currentSelectedValue;

  final textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    if (textFieldController.text.isEmpty)
      textFieldController.text = widget.selected;

    return PlatformSwitch(
      // Android Dropdown
      android: DropdownButtonFormField(
        isExpanded: true, //Adding this property, does the magic, Ghaith :)
        items: widget.list.map((String item) {
          return new DropdownMenuItem(
              value: item,
              child: Row(
                children: <Widget>[
                  Text(item),
                ],
              ));
        }).toList(),
        onChanged: _onSelectedAndroid,
        value: widget.selected,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
          fillColor: Colors.white,
          contentPadding: EdgeInsets.fromLTRB(10, 20, 10, 20),
          filled: true,
          labelText: widget.labelText,
          hintText: widget.hintText,
        ),
      ),
      // IOS Picker
      ios: GestureDetector(
        onTap: () {
          _showPicker(context);
        },
        child: TextField(
          controller: textFieldController,
          enabled: false,
          maxLines: null,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            labelText: widget.labelText,
            hintText: widget.hintText,
            labelStyle: TextStyle(color: Colors.black),
            contentPadding: EdgeInsets.fromLTRB(32, 16, 32, 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
            ),
            suffixIcon: Icon(
              FontAwesomeIcons.caretDown,
              color: kPrimaryColor,
            ),
          ),
        ),
      ),
    );
  }

  void _showPicker(BuildContext ctx) {
    showCupertinoModalPopup(
        context: ctx,
        builder: (_) => Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              child: CupertinoPicker(
                backgroundColor: Colors.white,
                itemExtent: 30,
                scrollController: FixedExtentScrollController(initialItem: 1),
                children: widget.list.map((String item) {
                  return new DropdownMenuItem(
                      value: item,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(item),
                        ],
                      ));
                }).toList(),
                onSelectedItemChanged: _onSelectediOS,
              ),
            ));
  }

  void _onSelectediOS(int value) {
    setState(() {
      widget.onSelected(widget.list[value]);
      textFieldController.text = widget.list[value];
    });
  }

  void _onSelectedAndroid(String value) {
    setState(() {
      widget.onSelected(value);
      textFieldController.text = value;
    });
  }
}
