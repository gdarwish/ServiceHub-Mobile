import 'package:ServiceHub/constants.dart';
import 'package:ServiceHub/models/address.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'dart:async';

import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';

import '../api_keys.dart';

class GooglePlacesTextField extends StatefulWidget {
  final Address address;
  GooglePlacesTextField(this.address);

  @override
  _GooglePlacesTextFieldState createState() => _GooglePlacesTextFieldState();
}

class _GooglePlacesTextFieldState extends State<GooglePlacesTextField> {
  Mode _mode = Mode.overlay;
  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onTap: () {
        _handlePressButton();
      },
      textInputAction: TextInputAction.done,
      maxLines: null,
      controller: addressController,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        labelText: 'Address',
        hintText: 'Enter your address',
        labelStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: (value) {
        if (value.isEmpty) {
          return 'Address can\'t be empty.';
        }
        return null;
      },
    );
  }

  void onError(PlacesAutocompleteResponse response) {
    failureSnackBar(response.errorMessage, context);
  }

  Future<void> _handlePressButton() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    final Prediction prediction = await PlacesAutocomplete.show(
      context: context,
      apiKey: kGoogleApiKey,
      onError: onError,
      mode: _mode,
      language: "en",
      components: [Component(Component.country, "ca")],
    );

    displayPrediction(prediction);
  }

  Future<Null> displayPrediction(Prediction prediction) async {
    if (prediction != null) {
      final GoogleMapsPlaces _places = GoogleMapsPlaces(
        apiKey: kGoogleApiKey,
        apiHeaders: await GoogleApiHeaders().getHeaders(),
      );
      final PlacesDetailsResponse detail =
          await _places.getDetailsByPlaceId(prediction.placeId);
      // final lat = detail.result.geometry.location.lat;
      // final lng = detail.result.geometry.location.lng;

      // print(detail.result.formattedAddress);
      addressController.text = detail.result.formattedAddress;

      // Set Address
      widget.address.formattedAddress = detail.result.formattedAddress;
      widget.address.latitude = detail.result.geometry.location.lat;
      widget.address.longitude = detail.result.geometry.location.lng;
      widget.address.placeId = detail.result.placeId;

      // scaffold.showSnackBar(
      //   SnackBar(
      //     content: Text("${p.description} - $lat/$lng"),
      //   ),
      // );
    }
  }
}
