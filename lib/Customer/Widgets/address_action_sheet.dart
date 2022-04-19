import 'package:adaptive_action_sheet/adaptive_action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ServiceHub/Customer/Screens/add_address_screen.dart';
import 'package:ServiceHub/data_source/data.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/address.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/service-request.dart';

class AddressActionSheet extends StatefulWidget {
  final ServiceRequest serviceRequest;
  final Function(String) validator;
  AddressActionSheet(
    this.serviceRequest, {
    Key key,
    this.validator,
  }) : super(key: key);

  @override
  _AddressActionSheetState createState() => _AddressActionSheetState();
}

class _AddressActionSheetState extends State<AddressActionSheet> {
  var textFieldController = TextEditingController();

  Address selectedAddress;

  @override
  Widget build(BuildContext context) {
    final customerAddresses = (Account.currentUser as Customer).addresses;
    selectedAddress = widget.serviceRequest.address;
    if (selectedAddress != null)
      textFieldController.text = _getFormattedAddress(selectedAddress);

    return GestureDetector(
      onTap: () {
        showAdaptiveActionSheet(
          context: context,
          title: const Text('Addreses'),
          actions: <BottomSheetAction>[
            ...customerAddresses
                .map((address) => BottomSheetAction(
                    title: Text(_getFormattedAddress(address)),
                    onPressed: () {
                      widget.serviceRequest.address = address;
                      Navigator.of(context).pop();
                      setState(() {});
                    }))
                .toList(),
            BottomSheetAction(
                title: const Text('+ Add new Address'),
                onPressed: () {
                  // addAddressAlert('Add Address', () {});
                  Navigator.pop(context);
                  Navigator.pushNamed(context, AddaddressScreen.route);
                }),
          ],
          cancelAction: CancelAction(
            title: Text('Cancel'),
          ),
        );
      },
      child: TextFormField(
        enabled: false,
        textInputAction: TextInputAction.done,
        maxLines: null,
        controller: textFieldController,
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          labelText: 'Address',
          labelStyle: TextStyle(color: Colors.black),
          contentPadding: EdgeInsets.all(16),
          errorStyle: TextStyle(
            color: Theme.of(context).errorColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide(
              color: Theme.of(context).errorColor,
            ),
          ),
        ),
        validator: widget.validator,
      ),
    );
  }

  String _getFormattedAddress(Address address) =>
      '(${address.title}) ${address.formattedAddress}';

//Add Address on the fly
  // void addAddressAlert(String title, Function onTap) {
  //   var textFieldController = TextEditingController();

  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: new Text(title),
  //         content: Container(
  //           height: MediaQuery.of(context).size.height / 3,
  //           child: Column(
  //             children: [
  //               CustomTextField(
  //                   hintText: 'Enter address name',
  //                   labelText: 'Name',
  //                   textFieldController: textFieldController),
  //               spacer(),
  //               CustomTextField(
  //                   hintText: 'Enter your address',
  //                   labelText: 'Address',
  //                   textFieldController: textFieldController),
  //               spacer(),
  //               CustomTextField(
  //                   hintText: 'Enter your phone',
  //                   labelText: 'Phone',
  //                   textFieldController: textFieldController)
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           new TextButton(
  //             child: new Text("Close"),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //           new TextButton(
  //             child: new Text('Add'),
  //             onPressed: onTap,
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }
}
