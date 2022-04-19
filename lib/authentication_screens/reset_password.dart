import 'package:ServiceHub/authentication_screens/signIn_screen.dart';
import 'package:ServiceHub/constants.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/mutual_widgets/asset_image.dart';
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

class ResetPasswordScreen extends StatelessWidget {
  static const route = '/ResetPasswordScreen';
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(
          color: Colors.black,
        ),
      ),
      body: SafeArea(
        child: BlocConsumer<UserBloc, UserState>(
          listener: (context, state) async {
            if (state is UserResetPasswordSent) {
              await nativeAlert(
                  context: context,
                  title: 'Success',
                  body: state.message,
                  btnText: 'Login',
                  onTap: () => Navigator.pop(context));
              Navigator.pop(context);
            } else if (state is UserResetPasswordFailure) {
              failureSnackBar(state.apiError.message, context);
            }
          },
          builder: (context, state) {
            if (state is UserAuthenticating) {
              return CustomProgressIndicator();
            }

            return _buildResetPassword(context);
          },
        ),
      ),
    );
  }

  Widget _buildResetPassword(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(
          height: double.infinity,
          child: SingleChildScrollView(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  pageTitle("Reset Password"),
                  spacer(),
                  assetImage('images/logo.png', context),
                  spacer(),
                  CustomTextField(
                    labelText: 'Email Address',
                    hintText: 'Enter your Email Address',
                    obscureText: false,
                    prefixIcon: Icons.lock,
                    textFieldController: emailController,
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Email Address can\'t be empty';
                      }
                      if (!value.contains('@')) {
                        return 'Email Address is not valid';
                      }
                      if (!value.contains('.')) {
                        return 'Email Address is not valid';
                      }
                      return null;
                    },
                  ),
                  spacer(height: 30.0),
                  // Reset password
                  mainBtn(
                    "Submit",
                    () {
                      // Local user validate
                      final valid = formKey.currentState.validate();
                      if (!valid) return;

                      BlocProvider.of<UserBloc>(context)
                          .add(UserResetPassword(email: emailController.text));
                      // Navigator.pushNamed(context, SigninScreen.route);
                    },
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
