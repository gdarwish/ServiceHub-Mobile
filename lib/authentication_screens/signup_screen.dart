import 'package:ServiceHub/authentication_screens/Widgets/signin_btn.dart';
import 'package:ServiceHub/authentication_screens/Widgets/terms_and_condition.dart';
import 'package:ServiceHub/authentication_screens/signIn_screen.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/models/settings.dart';
import 'package:ServiceHub/mutual_widgets/asset_image.dart';
import 'package:ServiceHub/mutual_widgets/custom_text_field.dart';
import 'package:ServiceHub/mutual_widgets/main_button.dart';
import 'package:ServiceHub/mutual_widgets/page_title.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignupScreen extends StatelessWidget {
  static const route = '/SignupScreen';
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  bool termsChecked = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) {
            if (state is UserRegistered) {
              Settings().email = state.email;
              Settings().password = state.password;

              Navigator.pushNamedAndRemoveUntil(
                context,
                SigninScreen.route,
                (route) => false,
                // arguments: {'email': state.email, 'password': state.password},
              );
            } else if (state is UserAuthenticationFailure) {
              failureSnackBar(state.apiError.message, context);
            }
          },
          builder: (context, state) {
            if (state is UserAuthenticating) {
              return Center(child: CircularProgressIndicator());
            }

            return _buildSignupScreen(context);
          },
        ),
      ),
    );
  }

  Widget _buildSignupScreen(BuildContext context) {
    return Stack(
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
                  pageTitle("Sign Up"),
                  spacer(),
                  assetImage('images/logo.png', context),
                  spacer(),
                  CustomTextField(
                    labelText: 'First Name',
                    hintText: 'Enter your First Name',
                    obscureText: false,
                    prefixIcon: Icons.person,
                    textFieldController: firstNameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'First Name can\'t be empty';
                      }
                      if (value.length < 3) {
                        return 'Enter a valid First Name';
                      }
                      return null;
                    },
                  ),
                  spacer(),
                  CustomTextField(
                    labelText: 'Last Name',
                    hintText: 'Enter your Last Name',
                    obscureText: false,
                    prefixIcon: Icons.person,
                    textFieldController: lastNameController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Last Name can\'t be empty';
                      }
                      if (value.length < 3) {
                        return 'Enter a valid Last Name';
                      }
                      return null;
                    },
                  ),
                  spacer(),
                  CustomTextField(
                    labelText: 'Email Address',
                    hintText: 'Enter your Email Address',
                    obscureText: false,
                    prefixIcon: Icons.email,
                    textFieldController: emailController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email Address can\'t be empty';
                      }
                      if (value.length < 3) {
                        return 'Enter a valid Email Address';
                      }
                      if (!value.contains('@') || (!value.contains('.'))) {
                        return 'Email Address is not valid';
                      }
                      return null;
                    },
                  ),
                  spacer(),
                  CustomTextField(
                    labelText: 'Password',
                    hintText: 'Enter your password',
                    obscureText: true,
                    prefixIcon: Icons.lock,
                    textFieldController: passwordController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Password can\'t be empty';
                      }
                      if (value.length < 8) {
                        return 'Password should be more than 8 characters';
                      }
                      return null;
                    },
                  ),
                  spacer(),
                  CustomTextField(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm your password',
                    obscureText: true,
                    prefixIcon: Icons.lock,
                    textFieldController: confirmPasswordController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Confirm Password can\'t be empty';
                      }
                      if (value != passwordController.text) {
                        return 'Password doesn\'t match';
                      }
                      return null;
                    },
                  ),
                  spacer(),
                  Text(
                    'I acknowledge that I have read:',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                  TermsAndConditions(onChanged: (checked) {
                    termsChecked = checked;
                  }),
                  spacer(height: 40),
                  // Sign Up
                  mainBtn(
                    "Sign Up",
                    () {
                      // Local user validate
                      final valid = formKey.currentState.validate();
                      if (!valid) return;

                      if (!termsChecked) {
                        failureSnackBar(
                            'Terms & Conditions in not checked', context);

                        return;
                      }

                      final firstName = firstNameController.text;
                      final lastName = lastNameController.text;
                      final email = emailController.text;
                      final password = passwordController.text;
                      final passwordConfirmation =
                          confirmPasswordController.text;

                      BlocProvider.of<UserBloc>(context).add(
                        UserRegister(
                          firstName: firstName,
                          lastName: lastName,
                          email: email,
                          password: password,
                          passwordConfirmation: passwordConfirmation,
                        ),
                      );

                      // Navigator.pushNamed(context, SigninScreen.route);
                    },
                  ),
                  SizedBox(height: 40.0),
                  SigninBtn(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
