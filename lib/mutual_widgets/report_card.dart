import 'dart:math';

import 'package:ServiceHub/models/report.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReportCard extends StatefulWidget {
  final Report report;

  const ReportCard(this.report);

  @override
  _ReportCardState createState() => _ReportCardState();
}

class _ReportCardState extends State<ReportCard> with TickerProviderStateMixin {
  Animation _arrowAnimation;
  AnimationController _arrowAnimationController;

  @override
  void initState() {
    super.initState();
    _arrowAnimationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 200));
    _arrowAnimation =
        Tween(begin: 0.0, end: pi).animate(_arrowAnimationController);
  }

  bool hide = true;

  @override
  Widget build(BuildContext context) {
    final report = widget.report;
    return GestureDetector(
      // onTap: () => setState(() => hide = !hide),
      onTap: () {
        setState(() {
          hide = !hide;
          _arrowAnimationController.isCompleted
              ? _arrowAnimationController.reverse()
              : _arrowAnimationController.forward();
        });
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '#${report.requestNumber}',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w500),
                    ),
                    Text(
                      report.status.title,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.w500,
                        color: report.status.color,
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Expanded(
                      child: RichText(
                        textAlign: TextAlign.start,
                        maxLines: hide ? 3 : null,
                        overflow: TextOverflow.fade,
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'User: ',
                              style: TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(text: report.userDetails),
                          ],
                          style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w400,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                if (!hide && report.adminDetails.isNotEmpty)
                  Row(
                    children: [
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: RichText(
                            maxLines: hide ? 3 : null,
                            overflow: TextOverflow.fade,
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: 'Admin: ',
                                  style: TextStyle(
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(text: report.adminDetails),
                              ],
                              style: TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                                color: Colors.black,
                              ),
                            ),
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ),
                    ],
                  ),

                // Icon(hide
                //     ? FontAwesomeIcons.chevronDown
                //     : FontAwesomeIcons.chevronUp),
                AnimatedBuilder(
                  animation: _arrowAnimationController,
                  builder: (context, child) => Transform.rotate(
                    angle: _arrowAnimation.value,
                    child: Icon(
                      Icons.expand_more,
                      size: 50.0,
                      color: Colors.black,
                    ),
                  ),
                ),

                SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(
                      report.fCreatedAt,
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
