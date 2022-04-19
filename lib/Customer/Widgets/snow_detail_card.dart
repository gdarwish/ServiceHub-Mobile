import 'package:ServiceHub/models/snow-request.dart';
import 'package:ServiceHub/mutual_widgets/detail_instruction_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SnowDetailCard extends StatelessWidget {
  final SnowRequest snowRequest;
  SnowDetailCard(this.snowRequest);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          detailInstructionCard("Driveway", snowRequest.driveway),
          detailInstructionCard("Walkway", snowRequest.walkway ? 'Yes' : 'No'),
          detailInstructionCard(
              "Sidewalk", snowRequest.sidewalk ? 'Yes' : 'No'),
          detailInstructionCard("Salting", snowRequest.salting ? 'Yes' : 'No'),
        ],
      ),
    );
  }
}
