import 'dart:async';

import 'package:module3/data.vos/models/movie_model.dart';
import 'package:module3/data.vos/models/movie_model_impl.dart';

import '../data.vos/vos/movie_vo.dart';

class HomeBloc{

  ///Reactive Stream
  StreamController<List<MovieVO>> mNowPlayingStreamController = StreamController();
  StreamController<List<MovieVO>> mPopularMoviesListStreamController = StreamController();
  StreamController<List<MovieVO>> mGenreListStreamController = StreamController();
  StreamController<List<MovieVO>> mActorsStreamController = StreamController();
  StreamController<List<MovieVO>> mShowCaseStreamController = StreamController();
  StreamController<List<MovieVO>> mMoviesByGenreListStreamController = StreamController();

  ///Models
  MovieModel mMovieModel = MovieModelImpl();


  HomeBloc(){
    /// Now Playing Movies Database
    mMovieModel.getNowPlayingMoviesFromDatabase();
  }
}