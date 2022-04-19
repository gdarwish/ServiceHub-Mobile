import 'package:ServiceHub/models/lawn-request.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:ServiceHub/mutual_widgets/detail_instruction_card.dart';

class LawnDetailCard extends StatelessWidget {
  final LawnRequest lawnRequest;
  LawnDetailCard(this.lawnRequest);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          detailInstructionCard("Grass Length", lawnRequest.grassLength),
          detailInstructionCard("Front Yard", lawnRequest.frontyard),
          detailInstructionCard("Back Yard", lawnRequest.backyard),
          detailInstructionCard("Side Yard", lawnRequest.sideyard),
          detailInstructionCard(
              "Clear Clipping", lawnRequest.clearClipping ? 'Yes' : 'No'),
          detailInstructionCard(
              "String Trimming", lawnRequest.stringTrimming ? 'Yes' : 'No'),
        ],
      ),
    );
  }
}
