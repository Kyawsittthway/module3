import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:module3/pages/movie_details_page.dart';
import 'package:module3/resources/colors.dart';
import 'package:module3/resources/dimens.dart';
import 'package:module3/resources/strings.dart';
import 'package:module3/viewitems/actor_view.dart';
import 'package:module3/viewitems/movie_view.dart';
import 'package:module3/viewitems/showcase_view.dart';
import 'package:module3/widgets/see_more_text.dart';
import 'package:module3/widgets/title_text.dart';
import 'package:module3/widgets/title_text_with_see_more_view.dart';
import '';

import '../viewitems/banner_view.dart';
import '../widgets/actors_and_creators_section_view.dart';

class HomePage extends StatelessWidget {
  List<String> genreList = [
    "Action",
    "Adventure",
    "Horror",
    "Comedy",
    "Thriller",
    "Drama"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PRIMARY_COLOR,
          title: const Text(
            MAIN_SCREEN_APP_BAR_TITLE,
            style: TextStyle(
              fontWeight: FontWeight.w700,
            ),
          ),
          leading: const Icon(Icons.menu),
          actions: const [
            Padding(
                padding: EdgeInsets.only(
                    top: 0, left: 0, bottom: 0, right: MARGIN_MEDIUM_2),
                child: Icon(Icons.search)),
          ],
        ),
        body: Container(
          color: HOME_SCREEN_BACKGROUND_COLOR,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BannerSectionView(),
                SizedBox(height: MARGIN_LARGE),
                BestPopularMovieAndSerialSectionView(()=>_navigateToMovieDetailsScreen(context)
                ),
                SizedBox(height: MARGIN_LARGE),
                CheckMovieShowTimeSectionView(),
                SizedBox(height: MARGIN_LARGE),
                GenreSectionView(
                  genreList: genreList,
                  onTapMovie: ()=>_navigateToMovieDetailsScreen(context),
                ),
                SizedBox(height: MARGIN_LARGE),
                ShowcasesSection(),
                SizedBox(height: MARGIN_LARGE),
                ActorsAndCreatorsSectionView(
                  BEST_ACTOR_TITLE,
                  BEST_ACTOR_SEE_MORE,
                ),
                SizedBox(height: MARGIN_LARGE),
              ],
            ),
          ),
        ));
  }

  void _navigateToMovieDetailsScreen(BuildContext context) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MovieDetailsPage()));
  }
}

class CheckMovieShowTimeSectionView extends StatelessWidget {
  const CheckMovieShowTimeSectionView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: PRIMARY_COLOR,
      height: SHOWTIME_SECTION_HEIGHT,
      margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      padding: EdgeInsets.all(MARGIN_LARGE),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MAIN_SCREEN_CHECK_MOVIEW_SHOWTIMES,
                /**/
                style: TextStyle(
                    color: Colors.white,
                    fontSize: TEXT_HEADING_1x,
                    fontWeight: FontWeight.w600),
              ),
              Spacer(),
              SeeMoreText(
                MAIN_SCREEN_SEE_MORE,
                textColor: PLAY_BUTTON_COLOR,
              ),
            ],
          ),
          Spacer(),
          Icon(Icons.location_on_rounded,
              color: Colors.white, size: BANNER_PLAY_BUTTON_SIZE)
        ],
      ),
    );
  }
}

class ShowcasesSection extends StatelessWidget {
  const ShowcasesSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: TitleTextWithSeeMoreView(
            SHOW_CASES_TITLE,
            SHOW_CASES_SEE_MORE,
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        Container(
          height: SHOW_CASES_HEIGHT,
          child: ListView(
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            scrollDirection: Axis.horizontal,
            children: [ShowCaseView(), ShowCaseView(), ShowCaseView()],
          ),
        ),
      ],
    );
  }
}

class BestPopularMovieAndSerialSectionView extends StatelessWidget {
  final Function onTapMovie;

  BestPopularMovieAndSerialSectionView(this.onTapMovie);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          margin: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          child: const TitleText(MAIN_SCRREN_BEST_POPULAR_MOVIES_AND_SERIALS),
        ),
        const SizedBox(
          height: MARGIN_MEDIUM_2,
        ),
        HorizontalMovieListView(() {
          this.onTapMovie();
        })
      ],
    );
  }
}

class GenreSectionView extends StatelessWidget {
  final List<String> genreList;
  final Function onTapMovie;

  const GenreSectionView({
    required this.genreList,
    required this.onTapMovie,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MARGIN_MEDIUM_2,
          ),
          child: DefaultTabController(
            length: genreList.length,
            child: TabBar(
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                  .map(
                    (genre) => Tab(
                      child: Text(genre),
                    ),
                  )
                  .toList(),
            ),
          ),
        ),
        Container(
          color: PRIMARY_COLOR,
          padding: EdgeInsets.only(
            top: MARGIN_MEDIUM_2,
            bottom: MARGIN_LARGE,
          ),
          child: HorizontalMovieListView(() {
            onTapMovie();
          }),
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function onTapMovie;

  HorizontalMovieListView(this.onTapMovie);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 270,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          itemCount: 10,
          itemBuilder: (BuildContext context, int index) {
            return MovieView(() {
              this.onTapMovie();
            });
          }),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  @override
  State<BannerSectionView> createState() => _BannerSectionViewState();
}

class _BannerSectionViewState extends State<BannerSectionView> {
  double _position = 0.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 4,
          child: PageView(
            onPageChanged: (page) {
              setState(() {
                _position = page.toDouble();
              });
            },
            children: [
              BannerView(),
              BannerView(),
            ],
          ),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        DotsIndicator(
          dotsCount: 2,
          position: _position,
          decorator: DotsDecorator(
            color: HOME_SCREEN_BANNER_DOTS_INACTIVE_COLOR,
            activeColor: PLAY_BUTTON_COLOR,
          ),
        )
      ],
    );
  }
}
