import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:module3/blocs/home_bloc.dart';
import 'package:module3/pages/movie_details_page.dart';
import 'package:module3/resources/colors.dart';
import 'package:module3/resources/dimens.dart';
import 'package:module3/resources/strings.dart';
import 'package:module3/viewitems/movie_view.dart';
import 'package:module3/viewitems/showcase_view.dart';
import 'package:module3/widgets/see_more_text.dart';
import 'package:module3/widgets/title_and_horizontal_movie_list_view.dart';
import 'package:module3/widgets/title_text.dart';
import 'package:module3/widgets/title_text_with_see_more_view.dart';
import 'package:provider/provider.dart';

import '../data.vos/vos/actor_vo.dart';
import '../data.vos/vos/genre_vo.dart';
import '../data.vos/vos/movie_vo.dart';
import '../viewitems/banner_view.dart';
import '../widgets/actors_and_creators_section_view.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeBloc(),
      child: Scaffold(
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
                  Selector<HomeBloc, List<MovieVO>>(
                    selector: (context, bloc) => bloc.mShowCaseMovieList,
                    builder: (context, showcaseMovieList, child) =>
                        BannerSectionView(
                      mPopularMovies: showcaseMovieList.take(8).toList() ?? [],
                    ),
                  ),
                  SizedBox(height: MARGIN_LARGE),
                  Selector<HomeBloc, List<MovieVO>>(
                    selector: (context, bloc) => bloc.mPopularMoviesList,
                    builder: (context, popularMovieList, child) =>
                        TitleAndHorizontalMovieListView(
                      (movieId) =>
                          _navigateToMovieDetailsScreen(context, movieId),
                      popularMovieList,
                      onListEndReached: () {
                        var bloc =
                            Provider.of<HomeBloc>(context, listen: false);
                        bloc.onNowPlayingMovieListEndReached();
                      },
                      title: MAIN_SCRREN_BEST_POPULAR_MOVIES_AND_SERIALS,
                    ),
                    // child: BestPopularMovieAndSerialSectionView(
                    //     (movieId) => _navigateToMovieDetailsScreen(
                    //         context, mActors, movieId),
                    //     mNowPlayingMovieList),
                  ),
                  SizedBox(height: MARGIN_LARGE),
                  CheckMovieShowTimeSectionView(),
                  SizedBox(height: MARGIN_LARGE),
                  Selector<HomeBloc, List<GenreVO>>(
                    selector: (context, bloc) => bloc.mGenreList,
                    builder: (context, genreList, child) =>
                        Selector<HomeBloc, List<MovieVO>>(
                      selector: (context, bloc) => bloc.mMoviesByGenreList,
                      builder: (context, moviesByGenreList, chiild) =>
                          GenreSectionView(
                              genreList: genreList,
                              movieListByGenre: moviesByGenreList,
                              onTapMovie: (movieId) =>
                                  _navigateToMovieDetailsScreen(
                                      context, movieId),
                              onTapGenre: (genreId) {
                                HomeBloc bloc = Provider.of<HomeBloc>(context,
                                    listen: false);
                                bloc.getMoviesByGenreAndRefresh(genreId);
                              }),
                    ),
                  ),
                  SizedBox(height: MARGIN_LARGE),
                  Selector<HomeBloc, List<MovieVO>>(
                    selector: (context, bloc) => bloc.mShowCaseMovieList,
                    builder: (context, showCaseMovieList, child) =>
                        ShowcasesSection(
                      showcaseMovieList: showCaseMovieList,
                    ),
                  ),
                  SizedBox(height: MARGIN_LARGE),
                  Selector<HomeBloc, List<ActorVO>>(
                    selector: (context, bloc) => bloc.mActors,
                    builder: (context, actorList, child) =>
                        ActorsAndCreatorsSectionView(
                            BEST_ACTOR_TITLE, BEST_ACTOR_SEE_MORE, actorList),
                  ),
                  SizedBox(height: MARGIN_LARGE),
                ],
              ),
            ),
          )),
    );
  }

  void _navigateToMovieDetailsScreen(BuildContext context, int movieId) {
    // model.getMovieDetails(movieId);
    // model.getMovieDetailsFromDatabase(movieId);
    // model.getCreditsByMovie(movieId);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => MovieDetailsPage(movieId)));
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
  ShowcasesSection({required this.showcaseMovieList});

  final List<MovieVO> showcaseMovieList;

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
          child: ListView.builder(
            padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
            scrollDirection: Axis.horizontal,
            itemCount: showcaseMovieList.length,
            itemBuilder: (BuildContext context, int index) {
              return ShowCaseView(
                movieTitle: showcaseMovieList[index].title,
                releaseDate: showcaseMovieList[index].releaseDate,
                imageNetwork: showcaseMovieList[index].posterPath,
              );
            },
          ),
        ),
      ],
    );
  }
}

class BestPopularMovieAndSerialSectionView extends StatelessWidget {
  final Function(int) onTapMovie;
  final List<MovieVO> mNowPlayingMovieList;

  BestPopularMovieAndSerialSectionView(
      this.onTapMovie, this.mNowPlayingMovieList);

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
        HorizontalMovieListView(
          (movieId) {
            this.onTapMovie(movieId);
          },
          movieList: mNowPlayingMovieList,
        )
      ],
    );
  }
}

class GenreSectionView extends StatelessWidget {
  final List<GenreVO> genreList;
  final List<MovieVO> movieListByGenre;
  final Function(int) onTapMovie;
  final Function(int) onTapGenre;

  GenreSectionView(
      {required this.genreList,
      required this.movieListByGenre,
      required this.onTapMovie,
      required this.onTapGenre});

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
              onTap: (int index) {
                this.onTapGenre(genreList[index].id);
              },
              isScrollable: true,
              indicatorColor: PLAY_BUTTON_COLOR,
              unselectedLabelColor: HOME_SCREEN_LIST_TITLE_COLOR,
              tabs: genreList
                  .map(
                    (genre) => Tab(
                      child: Text("${genre.name}"),
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
          child: HorizontalMovieListView(
            (movieId) {
              onTapMovie(movieId);
            },
            movieList: movieListByGenre,
          ),
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int) onTapMovie;
  final List<MovieVO> movieList;

  HorizontalMovieListView(this.onTapMovie, {required this.movieList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)
          ? ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
              itemCount: movieList.length,
              itemBuilder: (BuildContext context, int index) {
                return MovieView((movieId) {
                  this.onTapMovie(movieId);
                }, movieList[index]);
              })
          : Center(child: CircularProgressIndicator()),
    );
  }
}

class BannerSectionView extends StatefulWidget {
  final List<MovieVO> mPopularMovies;

  BannerSectionView({required this.mPopularMovies});

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
                  if (page > 5) {
                    page = 0;
                  }
                  _position = page.toDouble();
                });
              },
              children: widget.mPopularMovies.length > 5
                  ? widget.mPopularMovies
                      .sublist(0, 5)
                      .map((popularMovie) => BannerView(
                            mMovie: popularMovie,
                          ))
                      .toList()
                  : widget.mPopularMovies
                      .map((popularMovie) => BannerView(
                            mMovie: popularMovie,
                          ))
                      .toList()),
        ),
        SizedBox(height: MARGIN_MEDIUM_2),
        DotsIndicator(
          dotsCount: 5,
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
