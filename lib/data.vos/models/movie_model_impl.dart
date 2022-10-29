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

class MovieModelImpl extends MovieModel {

  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();
  @override
  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl(){
    return _singleton;
  }


  MovieModelImpl._internal(){
    // getNowPlayingMoviesFromDatabase();
    // getTopRatedMoviesFromDatabase();
    // getPopularMoviesFromDatabase();
    // getActors(1);
    // getAllActorsFromDatabase();
    // getGenresFromDatabase();
  }

  /// Daos
  MovieDao mMovieDao = MovieDao();
  GenreDao mGenreDao = GenreDao();
  ActorDao mActorDao = ActorDao();
  //
  // ///State
  // List<MovieVO>mNowPlayingMovieList = [];
  // List<MovieVO>mPopularMoviesList = [];
  // List<GenreVO>mGenreList = [];
  // List<ActorVO>mActors = [];
  // List<MovieVO>mShowCaseMovieList = [];
  // List<MovieVO>mMoviesByGenreList = [];
  //
  // ///Movie Detail
  // MovieVO? mMovie;
  // List<CreditVO> mActorsList = [];
  // List<CreditVO> mCreatorsList = [];


  //Network
  @override
  void getNowPlayingMovies(int page) {
    mDataAgent.getNowPlayingMovies(page).then((movies) async {
      List<MovieVO>nowPlayingMovies = movies.map((movie) {
        movie.isNowPlaying = true;
        movie.isPopular = false;
        movie.isTopRated = false;
        return movie;
      }).toList();
    });
  }

  @override
  Future<List<GenreVO>> getGenres() {
   return mDataAgent.getGenres().then((genres) async {
      return Future.value(genres);
    });
  }

  @override
  void getPopularMovies(int page) {
    mDataAgent.getPopularMovies(page).then((movies) async {
      List<MovieVO>popularMovies = movies.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = true;
        movie.isTopRated = false;
        return movie;
      }).toList();
    });
  }

  @override
  void getTopRatedMovies(int page) {
    mDataAgent.getTopRatedmovies(page).then((movies) async {
      List<MovieVO>topRatedMovies = movies.map((movie) {
        movie.isNowPlaying = false;
        movie.isPopular = false;
        movie.isTopRated = true;
        return movie;
      }).toList();
    });
  }

  @override
  Future<List<MovieVO>> getMoviesByGenre(int genreId) {
    return mDataAgent.getMoviesByGenre(genreId)
        .then((movieList) {
      return Future.value(movieList);
    });
  }

  @override
  Future<List<ActorVO>> getActors(int page) {
    return mDataAgent.getActors(page).then((actors) async {
      mActorDao.saveAllActors(actors);
      return Future.value(actors);
    });
  }

  @override
  Future<List<CreditVO>> getCreditsByMovie(int movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }

  // @override
  // void getCreditsByMovie(int movieId) {
  //   mDataAgent.getCreditsByMovie(movieId).then((creditsByMovie){
  //     mCreatorsList = creditsByMovie.where((credit) => credit.isCreator() == true).toList();
  //     mActorsList = creditsByMovie.where((credit) => credit.isActor() == true).toList();
  //     notifyListeners();
  //   });
  // }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
    return mDataAgent.getMovieDetails(movieId).then((movie) async {
      MovieVO mMovie = await getMovieDetailsFromDatabase(movieId);
      movie.isTopRated = mMovie?.isTopRated ?? false;
      movie.isPopular = mMovie?.isPopular ?? false;
      movie.isNowPlaying = mMovie?.isNowPlaying ?? false;
      mMovieDao.saveSingleMovie(movie);
      return Future.value(movie);
    });
  }


  //Database
  @override
  Future<List<ActorVO>> getAllActorsFromDatabase() {
    return Future.value(mActorDao.getAllActors());
  }

  @override
  Future<List<GenreVO>> getGenresFromDatabase() {
    return Future.value(mGenreDao.getAllGenres());
  }

  @override
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(mMovieDao.getMovieById(movieId));
  }

  //  @override
  // void getMovieDetailsFromDatabase(int movieId) {
  //    mMovie = mMovieDao.getMovieById(movieId);
  //    notifyListeners();
  //  }

  @override
  Future<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    this.getNowPlayingMovies(1);
    return Future.value(mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getNowPlayingMoviesStream())
        .map((event) => mMovieDao.getNowPlayingMovies())
        .first
        .then((value) => value));
    // .then((nowPlayingMovies) {
    //   mNowPlayingMovieList = nowPlayingMovies;
    //   notifyListeners();
    //  });

  }

  @override
  Future<List<MovieVO>> getPopularMoviesFromDatabase() {
    this.getPopularMovies(1);
    return Future.value(mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getPopularMoviesStream())
        .map((event) => mMovieDao.getPopularMovies())
        .first
        .then((value)=>value));
        // .then((popularMovies){
        //   mPopularMoviesList = popularMovies;
        //   notifyListeners();
        //  });
  }

  @override
  Future<List<MovieVO>> getTopRatedMoviesFromDatabase() {
    this.getTopRatedMovies(1);
    return Future.value(mMovieDao
        .getAllMoviesEventStream()
        .startWith(mMovieDao.getTopRatedMoviesStream())
        .map((event) => mMovieDao.getTopRatedMovies())
        .first
        .then((value) => value));
    //     .then((topRatedMovies) {
    //   mShowCaseMovieList = topRatedMovies;
    //   notifyListeners();
    // });
  }


}