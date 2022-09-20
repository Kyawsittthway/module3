import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:module3/data.vos/models/movie_model.dart';
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

import '../data.vos/models/movie_model_impl.dart';
import '../data.vos/vos/actor_vo.dart';
import '../data.vos/vos/genre_vo.dart';
import '../data.vos/vos/movie_vo.dart';
import '../viewitems/banner_view.dart';
import '../widgets/actors_and_creators_section_view.dart';

class HomePage extends StatefulWidget {

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  MovieModel mMovieModel = MovieModelImpl();

  List<String> genreList = [
    "Action",
    "Adventure",
    "Horror",
    "Comedy",
    "Thriller",
    "Drama"
  ];

   List<MovieVO>mNowPlayingMovieList=[];
   List<MovieVO>mPopularMoviesList= [];
   List<GenreVO>mGenreList=[];
   List<ActorVO>mActors=[];
   List<MovieVO>mShowCaseMovieList=[];
   List<MovieVO>mMoviesByGenreList=[];

  @override
  void initState(){
    super.initState();

    ///Now Playing Movies
    mMovieModel.getNowPlayingMovies(1)
    .then((movieList){
      setState((){
        mNowPlayingMovieList = movieList;
      });
    }).catchError((error){
      debugPrint(error.toString());
    });

    ///Actors
    mMovieModel.getActors(1).then((actorsList)
    {
      setState(() {
        mActors = actorsList;
        print("Success :: $mActors");
      });
    }).catchError((error){
      debugPrint(error.toString());
      print("Error :: ${mActors}");
    });

    ///Popular Movies
    mMovieModel.getPopularMovies(1)
    .then((movieList){
      setState(() {
        mPopularMoviesList = movieList;

      });
    }).catchError((error){
      debugPrint("Popular :: ${error.toString()}");
      print("This is mPopularMovieList ${mPopularMoviesList}");
    });

    ///Genres
    mMovieModel.getGenres().then((genreList){
      setState(() {
        mGenreList = genreList;

        ///Movies By Genre
        _getMoviesByGenreAndRefresh(mGenreList.first.id);
      });
    }).catchError((error){
      debugPrint(error.toString());
    });

    ///Showcases
    mMovieModel.getTopRatedMovies(1).then((movieList){
      setState(() {
        mShowCaseMovieList = movieList;
        print("this is showcase movie list :: ${mShowCaseMovieList}");
      });
    }).catchError((error){
      debugPrint(error.toString());
    });



  }



  void _getMoviesByGenreAndRefresh(int genreId){
    mMovieModel.getMoviesByGenre(genreId).then((moviesByGenre){
      setState(() {
        mMoviesByGenreList = moviesByGenre;
      });
    }).catchError((error){
      debugPrint(error.toString());
    });
  }

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
                BannerSectionView(mPopularMovies: mPopularMoviesList,),
                SizedBox(height: MARGIN_LARGE),
                BestPopularMovieAndSerialSectionView((movieId)=>_navigateToMovieDetailsScreen(context,mActors,movieId),mNowPlayingMovieList
                ),
                SizedBox(height: MARGIN_LARGE),
                CheckMovieShowTimeSectionView(),
                SizedBox(height: MARGIN_LARGE),
                GenreSectionView(
                  genreList: mGenreList.map((genre) => genre).toList(),
                  movieListByGenre: mMoviesByGenreList,
                  onTapMovie: (movieId)=>_navigateToMovieDetailsScreen(context,mActors,movieId),
                  onTapGenre: (genreId)=>_getMoviesByGenreAndRefresh(genreId),
                ),
                SizedBox(height: MARGIN_LARGE),
                ShowcasesSection(showcaseMovieList: mShowCaseMovieList,),
                SizedBox(height: MARGIN_LARGE),
                ActorsAndCreatorsSectionView(
                  BEST_ACTOR_TITLE,
                  BEST_ACTOR_SEE_MORE,
                  mActors
                ),
                SizedBox(height: MARGIN_LARGE),
              ],
            ),
          ),
        ));
  }

  void _navigateToMovieDetailsScreen(BuildContext context,List<ActorVO> actors,int movieId) {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => MovieDetailsPage(actorList: actors,movieId:movieId)));
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
   ShowcasesSection({
     required this.showcaseMovieList}) ;
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
            itemBuilder: (BuildContext context, int index){
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
  BestPopularMovieAndSerialSectionView(this.onTapMovie, this.mNowPlayingMovieList);

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
        HorizontalMovieListView((movieId) {
          this.onTapMovie(movieId);
        }, movieList: mNowPlayingMovieList
          ,)
      ],
    );
  }
}

class GenreSectionView extends StatelessWidget {
  final List<GenreVO> genreList;
  final List<MovieVO> movieListByGenre;
  final Function(int) onTapMovie;
  final Function(int) onTapGenre;


   GenreSectionView({
    required this.genreList,
     required this.movieListByGenre,
    required this.onTapMovie,
     required this.onTapGenre
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
              onTap: (int index){
                this.onTapGenre(genreList[index].id
                );
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
          child: HorizontalMovieListView((movieId) {
            onTapMovie(movieId);
          }, movieList: movieListByGenre,),
        ),
      ],
    );
  }
}

class HorizontalMovieListView extends StatelessWidget {
  final Function(int) onTapMovie;
  final List<MovieVO>movieList;
  HorizontalMovieListView(this.onTapMovie, {required this.movieList});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MOVIE_LIST_HEIGHT,
      child: (movieList != null)?ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.only(left: MARGIN_MEDIUM_2),
          itemCount: movieList.length,
          itemBuilder: (BuildContext context, int index) {
            return MovieView((movieId) {
              this.onTapMovie(movieId);
            },movieList[index]);
          }):Center(child: CircularProgressIndicator()),
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
                  if(page >5){
                    page = 0;
                  }
                _position = page.toDouble();
              });
            },
            children: widget.mPopularMovies.length > 5 ? widget.mPopularMovies.sublist(0,5).map((popularMovie) => BannerView(
              mMovie:popularMovie,
            )).toList() : widget.mPopularMovies.map((popularMovie) => BannerView(
              mMovie:popularMovie,
            )).toList()
          ),
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
