import 'package:flutter/material.dart';
import 'package:module3/widgets/title_text_with_see_more_view.dart';

import '../resources/colors.dart';
import '../resources/dimens.dart';
import '../resources/strings.dart';
import '../viewitems/actor_view.dart';

class ActorsAndCreatorsSectionView extends StatelessWidget {
  final String title;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;

  ActorsAndCreatorsSectionView(
      this.title,
      this.seeMoreText,
      {this.seeMoreButtonVisibility = true}
      );
  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      padding: EdgeInsets.only(
        top: MARGIN_MEDIUM_2,
        bottom: MARGIN_XXLARGE,
      ),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TitleTextWithSeeMoreView(
              title,
              seeMoreText,
            ),
          ),
          SizedBox(height: MARGIN_MEDIUM_2),
          Container(
            height: BEST_ACTORS_HEIGHT,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                ActorView(),
                ActorView(),
                ActorView(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}