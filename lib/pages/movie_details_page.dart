import 'package:flutter/material.dart';
import 'package:module3/resources/colors.dart';
import 'package:module3/resources/strings.dart';
import 'package:module3/widgets/actors_and_creators_section_view.dart';
import 'package:module3/widgets/gradient_view.dart';

import '../resources/dimens.dart';
import '../widgets/rating_view.dart';
import '../widgets/title_text.dart';

class MovieDetailsPage extends StatelessWidget {
  List<String> genreList = ["Action", "Comedy", "Drama"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: HOME_SCREEN_BACKGROUND_COLOR,
        child: CustomScrollView(
          slivers: [
            MovieDetailSliverAppbarView(
                ()=>Navigator.pop(context)
            ),
            SliverList(
              delegate: SliverChildListDelegate([
                Container(
                  margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                  child: TrailerSection(genreList),
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                ActorsAndCreatorsSectionView(
                  MOVIE_DETAIL_SCREEN_ACTORS_TITLE,
                  "",
                  seeMoreButtonVisibility: false,
                ),
                SizedBox(
                  height: MARGIN_LARGE,
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText("ABOUT FILM"),
                      AboutFilmnInfoView(
                          "Original Title:", "X-Men Origins Wolverine"),
                      SizedBox(
                        height: MARGIN_MEDIUM_2,
                      ),
                      AboutFilmnInfoView("Type", "Action,Comedy,Drama"),
                      SizedBox(
                        height: MARGIN_MEDIUM_2,
                      ),
                      AboutFilmnInfoView(
                        "Production:",
                        "United Kingdom,USA",
                      ),
                      SizedBox(
                        height: MARGIN_MEDIUM_2,
                      ),
                      AboutFilmnInfoView(
                        "Premiere:",
                        "8 November 2016 (World)",
                      ),
                      SizedBox(
                        height: MARGIN_MEDIUM_2,
                      ),
                      AboutFilmnInfoView(
                        "Description:",
                        "Logan comes out of retirement to escort a young mutant named Laura to a safe place. He meets with other mutants, who run from an evil corporation that has been experimenting with them, along the way.",
                      )
                    ],
                  ),
                ),
                ActorsAndCreatorsSectionView(
                  MOVIE_DETAIL_SCREEN_CREATORS_TITLE,
                  MOVIE_DETAIL_SCREEN_CREATORS_SEE_MORE,
                ),
              ]),
            )
          ],
        ),
      ),
    );
  }
}

class AboutFilmnInfoView extends StatelessWidget {
  final String label;
  final String desccription;

  AboutFilmnInfoView(this.label, this.desccription);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery.of(context).size.width / 4,
          child: Text(
            label,
            style: TextStyle(
              color: MOVIE_DETAILS_INFO_TEXT_COLOR,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        SizedBox(width: MARGIN_CARD_MEDIUM_2),
        Expanded(
          child: Text(
            desccription,
            style: TextStyle(
              color: Colors.white,
              fontSize: MARGIN_MEDIUM_2,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ],
    );
  }
}

class TrailerSection extends StatelessWidget {
  final List<String> genreList;

  TrailerSection(this.genreList);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MovieTimeAndGenreView(genreList: genreList),
        SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        StoryLineView(),
        SizedBox(height: MARGIN_MEDIUM_2),
        Row(
          children: [
            MovieDetailScreenButtonView(
              "PLAY TRAILER",
              PLAY_BUTTON_COLOR,
              Icon(
                Icons.play_circle_filled,
                color: Colors.black54,
              ),
            ),
            SizedBox(width: MARGIN_CARD_MEDIUM_2),
            MovieDetailScreenButtonView(
              "RATE MOVIE",
              HOME_SCREEN_BACKGROUND_COLOR,
              Icon(
                Icons.star,
                color: PLAY_BUTTON_COLOR,
              ),
              isGhostButton: true,
            )
          ],
        )
      ],
    );
  }
}

class MovieDetailScreenButtonView extends StatelessWidget {
  final String title;
  final Color backgroundColor;
  final Icon buttonIcon;
  final bool isGhostButton;

  MovieDetailScreenButtonView(this.title, this.backgroundColor, this.buttonIcon,
      {this.isGhostButton = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_CARD_MEDIUM_2),
      height: MARGIN_XXLARGE,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(
          MARGIN_LARGE,
        ),
        border: (isGhostButton)
            ? Border.all(
                color: Colors.white,
                width: 2,
              )
            : null,
      ),
      child: Center(
        child: Row(children: [
          buttonIcon,
          SizedBox(
            width: MARGIN_MEDIUM,
          ),
          Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: TEXT_REGULAR_2X,
            ),
          )
        ]),
      ),
    );
  }
}

class StoryLineView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleText(MOVIE_DETAIL_STORYLINE_TITLE),
        SizedBox(
          height: MARGIN_MEDIUM,
        ),
        Text(
          "Logan comes out of retirement to escort a young mutant named Laura to a safe place. He meets with other mutants, who run from an evil corporation that has been experimenting with them, along the way.",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_REGULAR_2X,
          ),
        )
      ],
    );
  }
}

class MovieTimeAndGenreView extends StatelessWidget {
  const MovieTimeAndGenreView({
    required this.genreList,
  });

  final List<String> genreList;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.access_time,
          color: PLAY_BUTTON_COLOR,
        ),
        Text(
          "2h 30mins",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(
          width: MARGIN_MEDIUM,
        ),
        Row(
          children: genreList.map((genre) => GenreChipView(genre)).toList(),
        ),
        Spacer(),
        Icon(
          Icons.favorite_border,
          color: Colors.white,
        )
      ],
    );
  }
}

class GenreChipView extends StatelessWidget {
  final String genreText;

  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Chip(
        backgroundColor: MOVIE_DETAILS_SCREEN_CHIP_BACKGROUND_COLOR,
        label: Text(
          genreText,
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      SizedBox(
        width: MARGIN_MEDIUM,
      )
    ]);
  }
}

class MovieDetailSliverAppbarView extends StatelessWidget {
  final Function onTapBack;

  MovieDetailSliverAppbarView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: PRIMARY_COLOR,
      automaticallyImplyLeading: false,
      expandedHeight: MOVIEW_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(children: [
          Positioned.fill(
            child: MovieDetailsAppbarImageView(),
          ),
          Positioned.fill(
            child: GradientView(),
          ),
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: EdgeInsets.only(
                top: MARGIN_XXLARGE,
                left: MARGIN_MEDIUM_2,
              ),
              child: BackButtonView(
                () => onTapBack(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: EdgeInsets.only(
                top: MARGIN_XXLARGE + MARGIN_MEDIUM,
                right: MARGIN_MEDIUM_2,
              ),
              child: SearchButtonView(),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: EdgeInsets.only(
                  left: MARGIN_MEDIUM_2,
                  right: MARGIN_MEDIUM_2,
                  bottom: MARGIN_LARGE),
              child: MovieDetailsAppbarInfoView(),
            ),
          )
        ]),
      ),
    );
  }
}

class MovieDetailsAppbarInfoView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            MovieDetailsYearView(),
            Spacer(),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    RatingView(),
                    SizedBox(
                      height: MARGIN_SMALL,
                    ),
                    TitleText("38876 VOTES"),
                    SizedBox(
                      height: MARGIN_CARD_MEDIUM_2,
                    )
                  ],
                ),
                SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                Text(
                  "9,76",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: MOVIE_DETAILS_RATING_TEXT_SIZE,
                  ),
                ),
              ],
            )
          ],
        ),
        SizedBox(height: MARGIN_MEDIUM),
        Text(
          "The Wolverine",
          style: TextStyle(
            color: Colors.white,
            fontSize: TEXT_HEADING_2X,
            fontWeight: FontWeight.bold,
          ),
        )
      ],
    );
  }
}

class MovieDetailsYearView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XXLARGE,
      child: Center(
        child: Text(
          "2016",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      decoration: BoxDecoration(
        color: PLAY_BUTTON_COLOR,
        borderRadius: BorderRadius.circular(MARGIN_LARGE),
      ),
    );
  }
}

class SearchButtonView extends StatelessWidget {
  const SearchButtonView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      Icons.search,
      color: Colors.white,
      size: MARGIN_XLARGE,
    );
  }
}

class BackButtonView extends StatelessWidget {
  final Function onTapBack;

  BackButtonView(this.onTapBack);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTapBack();
      },
      child: Container(
        width: MARGIN_XXLARGE,
        height: MARGIN_XXLARGE,
        child: Icon(
          Icons.chevron_left,
          color: Colors.white,
          size: MARGIN_XLARGE,
        ),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.black54,
        ),
      ),
    );
  }
}

class MovieDetailsAppbarImageView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Image.network(
      "https://cdn.britannica.com/72/182872-050-914C987D/Hugh-Jackman-title-character-The-Wolverine-James.jpg",
      fit: BoxFit.cover,
    );
  }
}
