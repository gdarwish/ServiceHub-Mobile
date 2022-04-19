import 'package:ServiceHub/Customer/Widgets/address_action_sheet.dart';
import 'package:ServiceHub/data/service-requests-handler/service-request-handler-bloc.dart';
import 'package:ServiceHub/data/service-requests-handler/service-request-handler-event.dart';
import 'package:ServiceHub/data/service-requests-handler/service-request-handler-state.dart';
import 'package:ServiceHub/models/lawn-request.dart';
import 'package:ServiceHub/models/snow-request.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/custom_text_field.dart';
import 'package:ServiceHub/mutual_widgets/date_text_field.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ServiceHub/Customer/Widgets/lawn_edit_container.dart';
import 'package:ServiceHub/Customer/Widgets/snow_edit_container.dart';
import 'package:ServiceHub/models/service-request.dart';
import 'package:ServiceHub/mutual_widgets/image_slider.dart';
import 'package:ServiceHub/mutual_widgets/main_button.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class EditScreen extends StatefulWidget {
  static const route = '/EditScreen';

  final ServiceRequest serviceRequest;
  EditScreen(this.serviceRequest, {Key key}) : super(key: key);

  @override
  _EditScreenState createState() => _EditScreenState();
}

class _EditScreenState extends State<EditScreen> {
  var addressTextFieldController = TextEditingController();
  var priceTextFieldController = TextEditingController();
  var instructionsTextFieldController = TextEditingController();
  var dateTextFieldController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  var testController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final serviceRequest = widget.serviceRequest;

    priceTextFieldController.text = serviceRequest.price.toStringAsFixed(2);
    instructionsTextFieldController.text = serviceRequest.instructions;

    return Scaffold(
      appBar: AppBar(
        title: Text("Edit"),
      ),
      body: BlocConsumer<ServiceRequestHandlerBloc, ServiceRequestHandlerState>(
        listener: (context, state) {
          if (state is ServiceRequestUpdatedState) {
            Navigator.pop(context);
            successSnackBar('Successful Updated Service Request!', context);
          }
          if (state is ServiceRequestsHandlerFailureState) {
            failureSnackBar(state.apiError.message, context);
          }
        },
        builder: (context, state) {
          if (state is ServiceRequestProcessing) {
            return CustomProgressIndicator();
          }

          return _buildEditScreen(context);
        },
      ),
    );
  }

  Widget _buildEditScreen(BuildContext context) {
    final serviceRequest = widget.serviceRequest;
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            // get new focus to dismiss the keyboard
            FocusScope.of(context).requestFocus(new FocusNode());
          },
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: double.infinity,
            child: SingleChildScrollView(
              physics: AlwaysScrollableScrollPhysics(),
              padding: EdgeInsets.symmetric(
                vertical: 20.0,
              ),
              child: Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image Slider
                    ImageSliser(
                      networkImages: serviceRequest.customerImages,
                    ),
                    spacer(),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        children: [
                          // Date
                          DateTextField(serviceRequest),
                          spacer(),
                          // Price
                          CustomTextField(
                            labelText: 'Price',
                            obscureText: false,
                            hintText: 'Enter your Price',
                            textFieldController: priceTextFieldController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Price Can\'t Be Empty';
                              }

                              serviceRequest.price = double.tryParse(value) ?? serviceRequest.price;
                              return null;
                            },
                          ),
                          // Address
                          spacer(),
                          AddressActionSheet(serviceRequest),

                          // DropDownTextField(
                          //   labelText: 'Address',
                          //   list: (Account.currentUser as Customer)
                          //       .addresses
                          //       .map((address) => address.formattedAddress)
                          //       .toList(),
                          //   onSelected: (value) {
                          //     final address = (Account.currentUser as Customer)
                          //         .addresses
                          //         .firstWhere((address) =>
                          //             address.formattedAddress == value);
                          //     serviceRequest.address = address;
                          //   },
                          //   selected: (Account.currentUser as Customer)
                          //       .getSelectedAddress(
                          //         serviceRequest.address,
                          //       )
                          //       .formattedAddress,
                          // ),
                          spacer(),

                          // Snow Request
                          if (serviceRequest is SnowRequest)
                            SnowEditContainer(serviceRequest),

                          // Lawn Request
                          if (serviceRequest is LawnRequest)
                            LawnEditContainer(serviceRequest),

                          // Instruction
                          spacer(),
                          CustomTextField(
                            labelText: 'Instructions',
                            hintText: 'Instructions',
                            obscureText: false,
                            textFieldController:
                                instructionsTextFieldController,
                            validator: (value) {
                              if (value.isEmpty) {
                                return 'Instructions can\'t be empty';
                              }

                              serviceRequest.instructions = value;
                              return null;
                            },
                          ),

                          spacer(height: 30.0),
                          mainBtn('Save', () {
                            //TODO:: Save new changes
                            final valid = formKey.currentState.validate();
                            if (!valid) return;

                            BlocProvider.of<ServiceRequestHandlerBloc>(context)
                                .add(
                              UpdateServiceRequest(serviceRequest),
                            );
                          }),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
