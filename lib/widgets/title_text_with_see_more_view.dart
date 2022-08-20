import 'package:flutter/material.dart';
import 'package:module3/widgets/see_more_text.dart';
import 'package:module3/widgets/title_text.dart';

class TitleTextWithSeeMoreView extends StatelessWidget {
  final String titleText;
  final String seeMoreText;
  final bool seeMoreButtonVisibility;

   TitleTextWithSeeMoreView(this.titleText, this.seeMoreText,{this.seeMoreButtonVisibility = true});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TitleText(
          titleText,
        ),
        const Spacer(),
        Visibility(
          visible: seeMoreButtonVisibility,
          child: SeeMoreText(seeMoreText),
        ),
      ],
    );
  }
}
