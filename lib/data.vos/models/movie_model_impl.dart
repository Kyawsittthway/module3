

import 'package:flutter/cupertino.dart';
import 'package:module3/data.vos/vos/actor_vo.dart';
import 'package:module3/data.vos/vos/credit_vo.dart';
import 'package:module3/data.vos/vos/genre_vo.dart';
import 'package:module3/data.vos/vos/movie_vo.dart';
import 'package:module3/network/movie_data_agent.dart';
import 'package:module3/network/retrofit_data_agent_impl.dart';
import 'package:retrofit/dio.dart';
import 'package:stream_transform/stream_transform.dart';

import '../../persistence/daos/actor_dao.dart';
import '../../persistence/daos/genre_dao.dart';
import '../../persistence/daos/movie_dao.dart';
import 'movie_model.dart';

class MovieModelImpl extends MovieModel{

  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();
  @override
  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl(){
    return _singleton;
  }


  MovieModelImpl._internal(){
  getNowPlayingMoviesFromDatabase();
  getTopRatedMoviesFromDatabase();
  getPopularMoviesFromDatabase();
  getActors(1);
  getAllActorsFromDatabase();
  getGenres();
  getGenresFromDatabase();
  }

  /// Daos
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();
  ActorDao mActorDao = ActorDao();

  ///State
  List<MovieVO>mNowPlayingMovieList=[];
  List<MovieVO>mPopularMoviesList= [];
  List<GenreVO>mGenreList=[];
  List<ActorVO>mActors=[];
  List<MovieVO>mShowCaseMovieList=[];
  List<MovieVO>mMoviesByGenreList=[];

  ///Movie detail state
  MovieVO? mMovie;

  List<CreditVO>? mActorsList;
  List<CreditVO>? mCreatorList;


  //Network
  @override
  void getNowPlayingMovies(int page) {
       mDataAgent.getNowPlayingMovies(page).then((movies) async{
        List<MovieVO>nowPlayingMovies = movies.map((movie){
          movie.isNowPlaying = true;
          movie.isPopular = false;
          movie.isTopRated = false;
          return movie;
        }).toList();
        mMovieDao.saveMovies(nowPlayingMovies);
        mNowPlayingMovieList = nowPlayingMovies;
        notifyListeners();
      });
  }

  @override
void getGenres() {
     mDataAgent.getGenres().then((genres) async{
      mGenreDao.saveAllGenres(genres);
      mGenreList = genres;
      getMoviesByGenre(genres.first.id);
      notifyListeners();
      return Future.value(genres);
    });
  }

  @override
  void getPopularMovies(int page) {
     mDataAgent.getPopularMovies(page).then((movies) async{
      List<MovieVO>popularMovies = movies.map((movie){
        movie.isNowPlaying = false;
        movie.isPopular = true;
        movie.isTopRated = false;
        return movie;
      }).toList();
      mMovieDao.saveMovies(popularMovies);
      mPopularMoviesList = popularMovies;
      notifyListeners();
    });
  }

  @override
  void getTopRatedMovies(int page) {
     mDataAgent.getTopRatedmovies(page).then((movies) async{
      List<MovieVO>topRatedMovies = movies.map((movie){
        movie.isNowPlaying = false;
        movie.isPopular = false;
        movie.isTopRated = true;
        return movie;
      }).toList();
      mMovieDao.saveMovies(topRatedMovies);
      mShowCaseMovieList = topRatedMovies;
      notifyListeners();
    });
  }

  @override
void getMoviesByGenre(int genreId) {
    mDataAgent.getMoviesByGenre(genreId)
    .then((movieList){
      mMoviesByGenreList = movieList;
      notifyListeners();
    });

  }

  @override
  void getActors(int page) {
     mDataAgent.getActors(page).then((actors) async{
      mActorDao.saveAllActors(actors);
      mActors = actors;
      notifyListeners();
      return Future.value(actors);
    });
  }

  @override
 getCreditsByMovie(int movieId) {
     mDataAgent.getCreditsByMovie(movieId).then((creditList){
       this.mActorsList = creditList.where((credit)=>credit.isActor()).toList();
       this.mCreatorList = creditList.where((credit)=>credit.isCreator()).toList();
       notifyListeners();
     });
  }

  @override
 void getMovieDetails(int movieId) {

     mDataAgent.getMovieDetails(movieId).then((movie) {
      getMovieDetailsFromDatabase(movieId);

      movie.isTopRated = mMovie?.isTopRated ?? false;
      movie.isPopular = mMovie?.isPopular ?? false;
      movie.isNowPlaying = mMovie?.isNowPlaying ?? false;
      mMovieDao.saveSingleMovie(movie);
      notifyListeners();
    });
  }


  //Database
  @override
  void getAllActorsFromDatabase() {
    mActors = mActorDao.getAllActors();
    notifyListeners();
  }

  @override
  void getGenresFromDatabase() {
    mGenreList = mGenreDao.getAllGenres();
    notifyListeners();
  }

  @override
 void getMovieDetailsFromDatabase(int movieId) {
     mMovie = mMovieDao.getMovieById(movieId);
     notifyListeners();
  }

  @override
 void getNowPlayingMoviesFromDatabase() {
    this.getNowPlayingMovies(1);
     mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .map((event) => mMovieDao.getNowPlayingMovies())
    .first
    .then((nowPlayingMovies) {
      mNowPlayingMovieList = nowPlayingMovies;
      notifyListeners();
     });
  }

  @override
  void getPopularMoviesFromDatabase() {
    this.getPopularMovies(1);
     mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getPopularMoviesStream())
        .map((event) => mMovieDao.getPopularMovies())
    .first
    .then((popularMovies){
      mPopularMoviesList = popularMovies;
      notifyListeners();
     });
  }

  @override
  void getTopRatedMoviesFromDatabase() {
    this.getTopRatedMovies(1);
      mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getTopRatedMoviesStream())
        .map((event) => mMovieDao.getTopRatedMovies())
        .first
        .then((topRatedMovies){
          mShowCaseMovieList = topRatedMovies;
          notifyListeners();
    });
  }




}