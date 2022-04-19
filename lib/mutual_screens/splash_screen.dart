import 'package:ServiceHub/authentication_screens/signIn_screen.dart';
import 'package:ServiceHub/data/blocs.dart';
import 'package:ServiceHub/splash/animation_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'main-screen.dart';

class SplashScreen extends StatefulWidget {
  static const route = '/SplashScreen';

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: BlocListener<UserBloc, UserState>(
        listener: (context, state) {
          if (state is UserUnauthenticated) {
            Navigator.pushNamedAndRemoveUntil(
                context, SigninScreen.route, (route) => false);
          }
        },
        child: Stack(
          children: <Widget>[
            // MainScreen(),
            SigninScreen(),
            IgnorePointer(
              child: AnimationScreen(color: Theme.of(context).accentColor),
            )
          ],
        ),
      ),
    );
  }
}
