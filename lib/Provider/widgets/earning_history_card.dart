import 'package:ServiceHub/models/service-request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class EarningHistoryCard extends StatelessWidget {
  final ServiceRequest serviceRequest;

  const EarningHistoryCard({
    Key key,
    @required this.serviceRequest,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '#${serviceRequest.requestNumber}',
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  serviceRequest.fPrice,
                  style: TextStyle(
                    fontSize: 25.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.end,
            //   children: [
            //     Text(
            //       serviceRequest.fPrice,
            //       style: TextStyle(
            //         fontSize: 25.0,
            //         color: Colors.black,
            //         fontWeight: FontWeight.w500,
            //       ),
            //     ),
            //   ],
            // ),
            Row(
              children: [
                Text(
                  serviceRequest.fDate,
                  style: TextStyle(
                    fontSize: 17.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w300,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
