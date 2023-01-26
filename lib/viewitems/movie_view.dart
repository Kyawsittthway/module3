import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:module3/network/api_constants.dart';

import '../data.vos/vos/movie_vo.dart';
import '../resources/dimens.dart';
import '../widgets/rating_view.dart';

class MovieView extends StatelessWidget {
  final Function(int) onTapMovie;
  final MovieVO mMovie;
  MovieView(this.onTapMovie, this.mMovie);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: MARGIN_MEDIUM),
      width: MOVIE_LIST_ITEM_WIDTH,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              onTapMovie(mMovie.id);
            },
            child: Image.network(
              "$IMAGE_BASE_URL${mMovie.posterPath}",
              height: 180,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
           GestureDetector(
             onTap: (){
               onTapMovie(mMovie.id);
             },
             child: Text(
              mMovie.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_REGULAR_2X,
                fontWeight: FontWeight.w600,
              ),
          ),
           ),
          const SizedBox(
            height: MARGIN_MEDIUM,
          ),
          Row(
            children: [
              const Text("8.9",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_REGULAR,
                    fontWeight: FontWeight.bold,
                  ),
              ),
              const SizedBox(width: MARGIN_SMALL),
          RatingView(),


            ],
          )
        ],
      ),
    );
  }
}
