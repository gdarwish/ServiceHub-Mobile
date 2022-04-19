import 'package:ServiceHub/models/review.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../constants.dart';

class ProfileReviewCard extends StatelessWidget {
  final Review review;

  const ProfileReviewCard({@required this.review});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                // Container(
                //   width: 50,
                //   height: 50,
                //   decoration: BoxDecoration(
                //     shape: BoxShape.circle,
                //     image: DecorationImage(
                //       image: NetworkImage(review.profile.imageURL),
                //       fit: BoxFit.fill,
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   width: 10.0,
                // ),
                // Text(
                //   review.profile.fullName,
                //   style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w500),
                // ),
                // Spacer(),
                RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: review.rating.toDouble(),
                  minRating: 1,
                  direction: Axis.horizontal,
                  itemCount: 5,
                  unratedColor: kPrimaryColorLight,
                  itemSize: 30.0,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: kPrimaryColor,
                  ),
                  onRatingUpdate: (value) {},
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    review.review,
                    style:
                        TextStyle(fontSize: 17.0, fontWeight: FontWeight.w400),
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  review.fCreatedAt,
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.w300),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
