import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../signup_screen.dart';

class SignupBtn extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        //TODO:: Sign Up
        // Navigator.pushNamed(context, SignupScreen.route)
        Navigator.pushNamedAndRemoveUntil(
            context, SignupScreen.route, (route) => false);
        print('hello world');
      },
      child: RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: 'Don\'t have an Account? ',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18.0,
                fontWeight: FontWeight.w400,
              ),
            ),
            TextSpan(
              text: 'Sign Up',
              style: TextStyle(
                color: Color(0xFF2C72D4),
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
