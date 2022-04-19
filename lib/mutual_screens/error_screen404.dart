import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorScreen404 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Error 404'),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                AnimatedTextKit(
                  repeatForever: true,
                  animatedTexts: [
                    TypewriterAnimatedText(
                      '404 Error',
                      textStyle: TextStyle(
                        fontSize: 40.0,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFFE11640),
                      ),
                      speed: Duration(milliseconds: 300),
                    ),
                  ],
                ),
                Text('The Page doesn\'t exist.',
                    style: TextStyle(fontSize: 20)),
              ],
            ),
            Container(
              child: Image.asset(
                "images/giphy.gif",
              ),
            ),
          ],
        ),
      ),
    );
  }
}
