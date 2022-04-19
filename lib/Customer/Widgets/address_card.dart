import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ServiceHub/constants.dart';

class AddressCard extends StatelessWidget {
  final String addressText;
  final String addressName;
  final Function deleteOnTap;

  const AddressCard({
    this.addressText,
    this.addressName,
    this.deleteOnTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListTile(
          contentPadding: EdgeInsets.only(left: 0.0, right: 0.0),
          title: Text(
            addressName,
            style: TextStyle(fontSize: 25.0, color: Colors.black),
            overflow: TextOverflow.visible,
          ),
          trailing: IconButton(
              icon: Icon(
                Icons.delete,
                color: Colors.red,
              ),
              onPressed: deleteOnTap),
          subtitle: Text(
            addressText,
            style: TextStyle(fontSize: 18.0, color: Colors.black54),
            overflow: TextOverflow.visible,
          ),
        ),
      ),
    );
  }
}
