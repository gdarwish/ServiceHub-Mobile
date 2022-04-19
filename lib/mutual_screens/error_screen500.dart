import 'package:ServiceHub/data/service-requests-fetcher/service-request-fetcher.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ErrorScreen500 extends StatelessWidget {
  final Function(BuildContext context) onRefresh;

  const ErrorScreen500({
    Key key,
    @required this.onRefresh,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      child: RefreshIndicator(
        onRefresh: () async => onRefresh(context),
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              AnimatedTextKit(
                repeatForever: true,
                animatedTexts: [
                  TypewriterAnimatedText(
                    '500 Error',
                    textStyle: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFFE11640),
                    ),
                    speed: Duration(milliseconds: 300),
                  ),
                ],
              ),
              Text('Oops, Something went wrong!',
                  style: TextStyle(fontSize: 20)),
              Container(
                child: Image.asset(
                  "images/giphy.gif",
                ),
              ),
              // Spacer(),
            ],
          ),
        ),
      ),
    );
  }

  // void _fetchServiceRequests(BuildContext context) {
  //   BlocProvider.of<ServiceRequestFetcherBloc>(context)
  //       .add(FetchServiceRequests());
  // }
}
