import 'package:flutter/material.dart';
import 'package:module3/blocs/movie_details_bloc.dart';
import 'package:module3/data.vos/models/movie_model_impl.dart';
import 'package:module3/data.vos/vos/credit_vo.dart';
import 'package:module3/network/api_constants.dart';
import 'package:module3/resources/colors.dart';
import 'package:module3/resources/strings.dart';
import 'package:module3/widgets/actors_and_creators_section_view.dart';
import 'package:module3/widgets/gradient_view.dart';
import 'package:module3/widgets/title_and_horizontal_movie_list_view.dart';
import 'package:provider/provider.dart';
import 'package:scoped_model/scoped_model.dart';
import '../data.vos/vos/actor_vo.dart';
import '../data.vos/vos/movie_vo.dart';
import '../resources/dimens.dart';
import '../widgets/rating_view.dart';
import '../widgets/title_text.dart';

class MovieDetailsPage extends StatelessWidget {
  final int movieId;


  MovieDetailsPage(this.movieId);

  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => MovieDetailsBloc(movieId),
        child: Scaffold(
          body: Selector<MovieDetailsBloc, MovieVO?>(
              selector: (context, bloc) => bloc.mMovie,
              builder: (context, movie, child) =>
                  Container(
                      color: HOME_SCREEN_BACKGROUND_COLOR,
                      child: (movie != null) ? CustomScrollView(
                          slivers: [
                          MovieDetailSliverAppbarView(
                          () => Navigator.pop(context), movie!
          ),
          SliverList(
            delegate: SliverChildListDelegate([
            Container(
            margin: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
            child: TrailerSection(movie!),
          ),
          SizedBox(
            height: MARGIN_LARGE,
          ),
          Selector<MovieDetailsBloc, List<CreditVO>>(
            selector: (context, bloc) => bloc.mActorsList,
            builder: (context, actorList, child) =>
                ActorsAndCreatorsSectionView(
                  BEST_ACTOR_TITLE,
                  BEST_ACTOR_SEE_MORE,
                  actorList ?? [],
                  seeMoreButtonVisibility: false,


                ),
          ),
          SizedBox(
            height: MARGIN_LARGE,
          ),
          Selector<MovieDetailsBloc, List<MovieVO>?>(
              selector: (context, bloc) => bloc.mRelatedMoviesList,
              builder: (context, relatedMovieList, child) =>
                  TitleAndHorizontalMovieListView(
                        (movieId) =>
                        _navigateToMovieDetailsScreen(context, movieId),
                    relatedMovieList ?? [], onListEndReached: (){}, title: MOVIE_DETAIL_RELATED_MOVIE,),
                  ),
              // child: BestPopularMovieAndSerialSectionView(
              //     (movieId) => _navigateToMovieDetailsScreen(
              //         context, mActors, movieId),
              //     mNowPlayingMovieList),

              Container(
              padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleText("ABOUT FILM"),
              AboutFilmnInfoView(
                  "Original Title:", "${movie.title}"),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              AboutFilmnInfoView(
                  "Type", movie.genres?.map((genres) => genres.name).join(",")),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              AboutFilmnInfoView(
                "Production:",
                "${movie.productionCompanies?.map((e) => e.name).join(",")}",
              ),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              AboutFilmnInfoView(
                "Premiere:",
                "${movie.releaseDate}",
              ),
              SizedBox(
                height: MARGIN_MEDIUM_2,
              ),
              AboutFilmnInfoView(
                  "Description:",
                  "${movie.overview}"
              )
            ],
          ),
        ),
        Selector<MovieDetailsBloc, List<CreditVO>>(
          selector: (context, bloc) => bloc.mCreatorList,
          builder: (context, creatorList, chid) =>
              ActorsAndCreatorsSectionView(
                CREATOR_TITLE,
                "",
                creatorList ?? [],
                seeMoreButtonVisibility: false,
              ),
        ),
        ]),
    )
    ],
    ) : Center(child: CircularProgressIndicator()),
    ),


    ),
    ),
    );
  }

  void _navigateToMovieDetailsScreen(BuildContext context, int movieId) {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MovieDetailsPage(movieId)));
  }
}


class AboutFilmnInfoView extends StatelessWidget {
  final String label;
  final String? desccription;

  AboutFilmnInfoView(this.label, this.desccription);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: MediaQuery
              .of(context)
              .size
              .width / 4,
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
            desccription ?? "",
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
  final MovieVO mMovie;

  TrailerSection(this.mMovie);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,


      children: [
        MovieTimeAndGenreView(
            genreList: mMovie.genres?.map((genre) => genre.name).toList() ?? []),
        SizedBox(
          height: MARGIN_MEDIUM_3,
        ),
        StoryLineView(mMovie.overview),
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
  final String overView;

  StoryLineView(this.overView);

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
          overView,
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
  MovieTimeAndGenreView({
    required this.genreList,
  });

  final List<String>? genreList;

  @override
  Widget build(BuildContext context) {
    return Wrap(

        alignment: WrapAlignment.start,
        crossAxisAlignment: WrapCrossAlignment.center,
        direction: Axis.horizontal,


        children: _createMovieTimeandGenreWidget()
    );
  }

  List<Widget> _createMovieTimeandGenreWidget() {
    List<Widget>widgets = [
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
    ];
    widgets.addAll(genreList!.map((genre) => GenreChipView(genre)).toList());
    widgets.add((
        Icon(
          Icons.favorite_border,
          color: Colors.white,
        )
    ),);
    return widgets;
  }

}

class GenreChipView extends StatelessWidget {
  final String genreText;

  GenreChipView(this.genreText);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
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
  final MovieVO mMovie;

  MovieDetailSliverAppbarView(this.onTapBack, this.mMovie);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: PRIMARY_COLOR,
      automaticallyImplyLeading: false,
      expandedHeight: MOVIEW_DETAILS_SCREEN_SLIVER_APP_BAR_HEIGHT,
      flexibleSpace: FlexibleSpaceBar(
        background: Stack(children: [
          Positioned.fill(
            child: MovieDetailsAppbarImageView(mMovie.posterPath),
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
              child: MovieDetailsAppbarInfoView(mMovie),
            ),
          )
        ]),
      ),
    );
  }
}

class MovieDetailsAppbarInfoView extends StatelessWidget {
  final MovieVO mMovie;

  MovieDetailsAppbarInfoView(this.mMovie);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          children: [
            MovieDetailsYearView(mMovie.releaseDate.substring(0, 4)),
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
                    TitleText("${mMovie.voteCount}VOTES"),
                    SizedBox(
                      height: MARGIN_CARD_MEDIUM_2,
                    )
                  ],
                ),
                SizedBox(
                  width: MARGIN_MEDIUM,
                ),
                Text(
                  "${mMovie.voteAverage}",
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
          mMovie.title,
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
  final String releaseDate;

  MovieDetailsYearView(this.releaseDate);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: MARGIN_MEDIUM_2),
      height: MARGIN_XXLARGE,
      child: Center(
        child: Text(
          releaseDate,
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
  final String movieImage;

  MovieDetailsAppbarImageView(this.movieImage);

  @override
  Widget build(BuildContext context) {
    return Image.network(
      "$IMAGE_BASE_URL$movieImage",
      fit: BoxFit.cover,
    );
  }
}
