import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../resources/dimens.dart';

class RatingView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return RatingBar.builder(
      initialRating: 5,
      itemBuilder: (BuildContext context, int index) =>  Icon(
        Icons.star,
        color: Colors.amber,
      ),
      itemSize: MARGIN_MEDIUM_2,
      onRatingUpdate: (rating) {
        print(rating);
      },
    );
  }
}
