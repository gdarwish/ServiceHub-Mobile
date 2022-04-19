import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../constants.dart';
import 'custom_text_field.dart';

class MultySelectBox extends StatefulWidget {
  final reviewTextFieldController;

  MultySelectBox({@required this.reviewTextFieldController});

  @override
  _MultySelectBoxState createState() => _MultySelectBoxState();
}

class _MultySelectBoxState extends State<MultySelectBox> {
  int index = 0;
  List<String> customerList = [
    'Thank you!',
    'Amazing service, Thank you :)',
    'Arrived in time',
    'Good service',
    'Followed instructions'
  ];

  List<String> providerList = [
    'Thank you!',
    'Was nice meeting you!',
    'Wishing to see you again :)',
    'Thanks!'
  ];
  String currentSelected;

  @override
  Widget build(BuildContext context) {
    final user = Account.currentUser;
    final list = user is Customer ? customerList : providerList;
    return Column(
      children: [
        Align(
          alignment: Alignment.center,
          child: Wrap(
            alignment: WrapAlignment.center,
            children: list.map((String item) {
              return boxContainer(item, list);
            }).toList(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 15.0, right: 15.0, top: 10.0),
          child: CustomTextField(
            obscureText: false,
            labelText: 'Review',
            hintText: 'Custom review',
            keyboardType: TextInputType.text,
            textFieldController: widget.reviewTextFieldController,
          ),
        )
      ],
    );
  }

  Widget boxContainer(String text, List list) {
    return GestureDetector(
      onTap: () {
        setState(() {
          index = list.indexOf(text);
          currentSelected = list[index];

          widget.reviewTextFieldController.text = currentSelected;
        });
      },
      child: Container(
        padding: const EdgeInsets.all(8.0),
        margin: const EdgeInsets.all(10.0),
        color: list.indexOf(text) == index ? kPrimaryColor : null,
        child: Text(
          text,
          overflow: TextOverflow.visible,
          style: TextStyle(
              color:
                  list.indexOf(text) == index ? Colors.white : kPrimaryColor),
        ),
      ),
    );
  }
}
