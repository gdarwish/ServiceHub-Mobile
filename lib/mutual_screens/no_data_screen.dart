import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoDataScreen extends StatelessWidget {
  final String message;
  final Function(BuildContext context) onRefresh;

  const NoDataScreen({this.message, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    // return RefreshIndicator(
    //   onRefresh: () {},
    //   child: Container(
    //     width: double.infinity,
    //     height: double.infinity,
    //     child: Padding(
    //       padding: const EdgeInsets.all(10.0),
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         children: [
    //           Text(
    //             message,
    //             textAlign: TextAlign.center,
    //             style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
    //           ),
    //           Flexible(
    //             child: Image(
    //               image: AssetImage('images/no-data.png'),
    //             ),
    //           )
    //         ],
    //       ),
    //     ),
    //   ),
    // );
    return RefreshIndicator(
      onRefresh: () async => onRefresh(context),
      child: Container(
        alignment: Alignment.center,
        child: SingleChildScrollView(
          physics: AlwaysScrollableScrollPhysics(),
          padding: EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
              ),
              Image(
                image: AssetImage('images/no-data.png'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
