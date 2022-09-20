import 'package:flutter/material.dart';
import 'package:module3/network/api_constants.dart';
import 'package:module3/resources/colors.dart';
import 'package:module3/resources/dimens.dart';

import '../data.vos/vos/movie_vo.dart';
import '../widgets/gradient_view.dart';
import '../widgets/play_button_view.dart';

class BannerView extends StatelessWidget {
  final MovieVO mMovie;
  BannerView({required this.mMovie});
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:  [
        Positioned.fill(
          child: BannerImageView(mImageUrl: "$IMAGE_BASE_URL${mMovie.posterPath}",),
        ),
        Positioned.fill(
          child: GradientView(),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: BannerTitleView(title: mMovie.title,),
        ),
        Align(
          alignment: Alignment.center,
          child:PlayButtonView(),
        )
      ],
    );
  }
}




class BannerTitleView extends StatelessWidget {
 final String title;

 BannerTitleView({required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
          Text(
            title,
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_HEADING_1x,
                fontWeight: FontWeight.w500),
          ),
          Text(
            "Official Review",
            style: TextStyle(
                color: Colors.white,
                fontSize: TEXT_HEADING_1x,
                fontWeight: FontWeight.w500),
          )
        ],
      ),
    );
  }
}

class BannerImageView extends StatelessWidget {

final String mImageUrl;

BannerImageView({required this.mImageUrl});
  @override
  Widget build(BuildContext context) {
    return Image.network(
      mImageUrl,
      fit: BoxFit.fill,
    );
  }
}
