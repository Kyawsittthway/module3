import 'package:flutter/material.dart';
import 'package:module3/resources/colors.dart';
import 'package:module3/resources/dimens.dart';

import '../widgets/gradient_view.dart';
import '../widgets/play_button_view.dart';

class BannerView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children:  [
        Positioned.fill(
          child: BannerImageView(),
        ),
        Positioned.fill(
          child: GradientView(),
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: BannerTitleView(),
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
  const BannerTitleView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MARGIN_MEDIUM_2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text(
            "The Wolverine 2013",
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
  const BannerImageView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://media2.fdncms.com/inlander/imager/mild-mutant/u/original/2189500/art19539.jpg",
      fit: BoxFit.fill,
    );
  }
}
