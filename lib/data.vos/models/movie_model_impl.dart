import 'package:module3/data.vos/vos/actor_vo.dart';
import 'package:module3/data.vos/vos/credit_vo.dart';
import 'package:module3/data.vos/vos/genre_vo.dart';
import 'package:module3/data.vos/vos/movie_vo.dart';
import 'package:module3/network/movie_data_agent.dart';
import 'package:module3/network/retrofit_data_agent_impl.dart';

import 'movie_model.dart';

class MovieModelImpl extends MovieModel{

  MovieDataAgent mDataAgent = RetrofitDataAgentImpl();
  @override
  static final MovieModelImpl _singleton = MovieModelImpl._internal();

  factory MovieModelImpl(){
    return _singleton;
  }


  MovieModelImpl._internal();

  @override
  Future<List<MovieVO>> getNowPlayingMovies(int page) {
      return mDataAgent.getNowPlayingMovies(page);
  }

  @override
  Future<List<GenreVO>> getGenres() {
    return mDataAgent.getGenres();
  }

  @override
  Future<List<MovieVO>> getPopularMovies(int page) {
    return mDataAgent.getPopularMovies(page);
  }

  @override
  Future<List<MovieVO>> getTopRatedMovies(int page) {
    return mDataAgent.getTopRatedmovies(page);
  }

  @override
  Future<List<MovieVO>> getMoviesByGenre(int genreId) {
    return mDataAgent.getMoviesByGenre(genreId);
  }

  @override
  Future<List<ActorVO>> getActors(int page) {
    return mDataAgent.getActors(page);
  }

  @override
  Future<List<CreditVO>> getCreditsByMovie(int movieId) {
    return mDataAgent.getCreditsByMovie(movieId);
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
  return mDataAgent.getMovieDetails(movieId);

  }


}