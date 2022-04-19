import 'package:ServiceHub/Customer/Screens/customer_main_screen.dart';
import 'package:ServiceHub/Provider/screens/provider_main_screen.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/models/customer.dart';
import 'package:ServiceHub/models/provider.dart';
import 'package:ServiceHub/models/settings.dart';
import 'package:ServiceHub/mutual_widgets/asset_image.dart';
import 'package:ServiceHub/mutual_widgets/custom_checkbox.dart';
import 'package:ServiceHub/mutual_widgets/custom_progress_indicator.dart';
import 'package:ServiceHub/mutual_widgets/custom_text_field.dart';
import 'package:ServiceHub/mutual_widgets/main_button.dart';
import 'package:ServiceHub/mutual_widgets/native_alert.dart';
import 'package:ServiceHub/mutual_widgets/page_title.dart';
import 'package:ServiceHub/mutual_widgets/snack_bar.dart';
import 'package:ServiceHub/mutual_widgets/spacer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Widgets/forgot_password_btn.dart';
import 'Widgets/signup_btn.dart';

class SigninScreen extends StatefulWidget {
  static const route = '/SigninScreen';
  // final Map<String, String> credentials;

  // const SigninScreen({Key key, this.credentials}) : super(key: key);

  @override
  _SigninScreenState createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  bool rememberMe = false;

  final formKey = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();

  _SigninScreenState() {
    emailController.text = Settings().email ?? '';
    passwordController.text = Settings().password ?? '';
    rememberMe = Settings().rememberMe ?? false;
  }

  @override
  Widget build(BuildContext context) {
    // final credentials = widget.credentials;
    // if (credentials != null) {
    //   emailController.text = credentials['email'];
    //   passwordController.text = credentials['password'];
    // }
    return Scaffold(
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(
          listener: (_, state) {
            if (state is UserAuthenticated) {
              if (state.user is Customer) {
                Navigator.pushNamedAndRemoveUntil(
                    context, CustomerMainScreen.route, (route) => false);
              } else if (state.user is Provider) {
                Navigator.pushNamedAndRemoveUntil(
                    context, ProviderMainScreen.route, (route) => false);
              }
            } else if (state is UserNotVerified) {
              nativeAlert(
                context: context,
                title: 'Activate account',
                body:
                    'Account is not activated, please check your email to activate your account.',
                btnText: 'Send Email',
                onTap: () {
                  BlocProvider.of<UserBloc>(context).add(UserVerifyEmail());
                  Navigator.pop(context);
                },
              );
            } else if (state is UserAuthenticationFailure) {
              failureSnackBar(state.apiError.message, context);
            }

            if (state is UserEmailVerifySent) {
              successSnackBar(state.message, context);
            }
            if (state is UserEmailVerifyFailure) {
              failureSnackBar(state.apiError.message, context);
            }
          },
          buildWhen: (before, current) => !(current is UserAuthenticated),
          builder: (context, state) {
            if (state is UserAuthenticating) {
              return CustomProgressIndicator();
            }

            return _buildSignInScreen(context);
          },
        ),
      ),
    );
  }

  Widget _buildSignInScreen(context) {
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
                  pageTitle("Sign In"),
                  spacer(),
                  assetImage('images/logo.png', context),
                  spacer(height: 30.0),
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
                      // if (!value.contains('@')) {
                      //   return 'Email Address is not valid';
                      // }
                      // if (!value.contains('.')) {
                      //   return 'Email Address is not valid';
                      // }
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
                      return null;
                    },
                  ),
                  ForgotPasswordBtn(),
                  CustomCheckbox(
                    checkboxMessage: "Remember me",
                    checkboxSatus: rememberMe,
                    onChanged: (value) {
                      rememberMe = value;
                    },
                  ),
                  spacer(),
                  mainBtn(
                    "Sign In as Customer",
                    () {
                      // Sign In as Service Provieder
                      final valid = formKey.currentState.validate();
                      if (!valid) return;

                      BlocProvider.of<UserBloc>(context).add(CustomerLogin(
                        email: emailController.text,
                        password: passwordController.text,
                        rememberMe: rememberMe,
                      ));

                      // Account.setCurrentUser(Data().currentCustomer);
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, CustomerMainScreen.route, (route) => false);
                    },
                  ),
                  spacer(),
                  // Sign In as Service Provieder
                  mainBtn(
                    "Sign In as Service Provieder",
                    () {
                      // Local user validate
                      final valid = formKey.currentState.validate();
                      if (!valid) return;

                      BlocProvider.of<UserBloc>(context).add(ProviderLogin(
                        email: emailController.text,
                        password: passwordController.text,
                        rememberMe: rememberMe,
                      ));

                      // Account.setCurrentUser(Data().currentProvider);
                      // Navigator.pushNamedAndRemoveUntil(
                      //     context, ProviderMainScreen.route, (route) => false);
                    },
                  ),
                  SizedBox(height: 40.0),
                  SignupBtn(),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
// nativeAlert(
//     context,
//     'Activate account',
//     'Account is not activated, please check your email to activate your account.',
//     'Resend Email',
//     () {});
// show error if not valid
