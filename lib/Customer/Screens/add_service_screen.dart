import 'package:ServiceHub/Customer/Screens/review_service_screen.dart';
import 'package:ServiceHub/Customer/Widgets/lawn_edit_container.dart';
import 'package:ServiceHub/Customer/Widgets/snow_edit_container.dart';
import 'package:ServiceHub/models/account.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/lawn-request.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/models/snow-request.dart';
import 'package:ServiceHub/mutual_widgets/custom_stepper.dart';
import 'package:ServiceHub/mutual_widgets/custom_text_field.dart';
import 'package:ServiceHub/mutual_widgets/date_text_field.dart';
import 'package:ServiceHub/mutual_widgets/multy_image_slider.dart';
import 'package:ServiceHub/mutual_widgets/main_button.dart';
import 'package:ServiceHub/mutual_widgets/native_alert.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:ServiceHub/Customer/Widgets/address_action_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddServiceScreen extends StatefulWidget {
  static const route = '/AddServiceScreen';
  final Type type;

  AddServiceScreen(this.type, {Key key}) : super(key: key);

  @override
  _AddServiceScreenState createState() => _AddServiceScreenState();
}

class _AddServiceScreenState extends State<AddServiceScreen> {
  final priceTextFieldController = TextEditingController();
  final instructionsTextFieldController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  ServiceRequest serviceRequest;
  final numericRegex = RegExp(r'^-?(([0-9]*)|(([0-9]*)\.([0-9]*)))$');

  @override
  void dispose() {
    priceTextFieldController.dispose();
    instructionsTextFieldController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (serviceRequest == null) {
      if (widget.type == SnowRequest) serviceRequest = SnowRequest();
      if (widget.type == LawnRequest) serviceRequest = LawnRequest();
    }
    String title = 'Service Request';
    if (serviceRequest is SnowRequest) title = 'Snow Removing';
    if (serviceRequest is LawnRequest) title = 'Lawn Mowing';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: SafeArea(
        child: _buildAddServiceScreen(context),
      ),
    );
  }

  Stack _buildAddServiceScreen(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(
              vertical: 20.0,
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  spacer(height: 10.0),
                  CustomStepper(
                    serviceDetail: false,
                    reviewAndPayment: false,
                  ),
                  spacer(height: 10.0),
                  // Image Slider
                  MultyImageSliser(
                    images: serviceRequest.localImages,
                  ),
                  spacer(),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        // Date
                        DateTextField(serviceRequest),
                        spacer(),
                        // Address
                        AddressActionSheet(
                          serviceRequest,
                          validator: (value) {
                            final customer = Account.currentUser as Customer;
                            if (serviceRequest.address == null ||
                                !customer.addresses
                                    .contains(serviceRequest.address)) {
                              return 'Please select an address.';
                            }

                            return null;
                          },
                        ),
                        spacer(),
                        // Price
                        CustomTextField(
                          labelText: 'Price',
                          obscureText: false,
                          hintText: 'Enter your price.',
                          textFieldController: priceTextFieldController,
                          // keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Price can\'t be empty.';
                            }
                            if (!numericRegex.hasMatch(value)) {
                              return 'Price is invalid.';
                            }

                            serviceRequest.price = double.tryParse(value ?? '');
                            return null;
                          },
                        ),
                        spacer(),

                        // Snow Request
                        if (serviceRequest is SnowRequest)
                          SnowEditContainer(serviceRequest),

                        // // Lawn Request
                        if (serviceRequest is LawnRequest)
                          LawnEditContainer(serviceRequest),

                        // Instruction
                        spacer(),
                        CustomTextField(
                            labelText: 'Instructions',
                            obscureText: false,
                            hintText: 'Provide additionl instructions',
                            textFieldController:
                                instructionsTextFieldController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Instructions can\'t be empty.';
                              }

                              serviceRequest.instructions = value;
                              return null;
                            }),

                        spacer(height: 30.0),
                        mainBtn(
                          'Continue to Review',
                          () {
                            setState(
                              () {
                                // show error if not valid
                                final valid = formKey.currentState.validate();
                                if (!valid) return;

                                if (serviceRequest.localImages.isEmpty) {
                                  nativeAlert(
                                    context: context,
                                    title: 'Warning',
                                    body: 'Please add images to your request.',
                                  );
                                  return;
                                }

                                // If not empty
                                Navigator.pushNamed(
                                    context, ReviewServiceScreen.route,
                                    arguments: serviceRequest);
                              },
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
