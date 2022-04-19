import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  var textFieldController = TextEditingController();

  final String labelText;
  final String hintText;
  final bool obscureText;
  final IconData prefixIcon;
  final TextInputType keyboardType;
  final Function(String) validator;

  CustomTextField({
    this.labelText,
    this.hintText,
    this.textFieldController,
    this.keyboardType,
    this.validator,
    this.obscureText,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      textInputAction: TextInputAction.done,
      maxLines: obscureText ? 1 : null,
      obscureText: obscureText,
      controller: textFieldController,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        prefixIcon: prefixIcon == null
            ? null
            : Icon(
                prefixIcon,
                color: Color(0xFF2C72D4),
                size: 20.0,
              ),
        filled: true,
        fillColor: Colors.white,
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(color: Colors.black),
        contentPadding: EdgeInsets.all(16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      validator: validator,
    );
  }
}
