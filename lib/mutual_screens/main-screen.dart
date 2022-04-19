import 'package:ServiceHub/authentication_screens/signIn_screen.dart';
import 'package:ServiceHub/data/user/user.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<UserBloc, UserState>(
      listener: (context, state) {
        if (state is UserUnauthenticated) {
          Navigator.pushNamedAndRemoveUntil(
            context,
            SigninScreen.route,
            (route) => false,
          );
        }
      },
      buildWhen: (before, current) => current is UserUnauthenticated,
      builder: (context, state) {
        if(state is UserUnauthenticated) {

        }
        
      },
    );
  }
}
