import 'package:ServiceHub/constants.dart';
import 'package:ServiceHub/data/address/address-bloc.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/models/address.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/custom_text_field.dart';
import 'package:ServiceHub/mutual_widgets/google_maps_textfield.dart';
import 'package:ServiceHub/mutual_widgets/main_button.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddaddressScreen extends StatefulWidget {
  static const route = '/AddaddressScreen';

  @override
  _AddaddressScreenState createState() => _AddaddressScreenState();
}

final homeScaffoldKey = GlobalKey<ScaffoldState>();

class _AddaddressScreenState extends State<AddaddressScreen> {
  final addressTitle = TextEditingController();
  final phoneNumber = TextEditingController();
  final formKey = GlobalKey<FormState>();
  final phoneRegex = RegExp(
    r'\s*(?:\+?(\d{1,3}))?[-. (]*(\d{3})[-. )]*(\d{3})[-. ]*(\d{4})(?: *x(\d+))?\s*$',
  );

  final address = Address();

  @override
  void dispose() {
    addressTitle.dispose();
    phoneNumber.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: homeScaffoldKey,
      appBar: AppBar(
        title: Text('Add Address'),
      ),
      body: SafeArea(
        child: BlocConsumer<AddressBloc, AddressState>(
          listener: (context, state) {
            if(state is AddressAddedState) {
              successSnackBar('Address has been added.', context);
              Navigator.pop(context);
            }
            if(state is AddressFailureState) {
              failureSnackBar(state.apiError.message, context);
            }
          },
          builder: (context, state) {
            if(state is AddressAddingState) {
              return CustomProgressIndicator();
            }
            return _buildAddAdressScreen(context);
          },
        ),
      ),
    );
  }

  GestureDetector _buildAddAdressScreen(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // get new focus to dismiss the keyboard
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: Stack(
        children: <Widget>[
          Container(
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: 40.0,
                vertical: 20.0,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    CustomTextField(
                      obscureText: false,
                      labelText: 'Address Title',
                      hintText: 'Enter Address Title',
                      textFieldController: addressTitle,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Address Title can\'t be empty.';
                        }

                        address.title = value;
                        return null;
                      },
                    ),
                    spacer(),
                    GooglePlacesTextField(address),
                    spacer(),
                    CustomTextField(
                      obscureText: false,
                      keyboardType: TextInputType.number,
                      labelText: 'Phone Number',
                      hintText: 'Enter Address contect number',
                      textFieldController: phoneNumber,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Phone Number can\'t be empty.';
                        }
                        if (!phoneRegex.hasMatch(value)) {
                          return 'Phone Number is not valid.';
                        }

                        address.phone = value;
                        return null;
                      },
                    ),
                    spacer(),
                    mainBtn(
                      'Add',
                      () {
                        setState(() {
                          // show error if not valid
                          final valid = formKey.currentState.validate();
                          if (!valid) return;

                          BlocProvider.of<AddressBloc>(context)
                              .add(AddAddress(address));
                        });
                      },
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
