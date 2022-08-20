import 'package:flutter/material.dart';
import 'package:module3/resources/dimens.dart';
import 'package:module3/widgets/play_button_view.dart';
import 'package:module3/widgets/title_text.dart';

class ShowCaseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(right: MARGIN_MEDIUM_2),
      child: SizedBox(
        width: 300,
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.network(
                "https://media2.fdncms.com/inlander/imager/mild-mutant/u/original/2189500/art19539.jpg",
                fit: BoxFit.cover,
              ),
            ),
            Align(
              alignment: Alignment.center,
              child: PlayButtonView(),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: Padding(
                padding: EdgeInsets.all(MARGIN_MEDIUM_2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Text(
                      "Passengers",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: TEXT_REGULAR_3X,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: MARGIN_MEDIUM),
                    TitleText("15 December 2016"),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
