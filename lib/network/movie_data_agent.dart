

import 'package:module3/data.vos/vos/actor_vo.dart';
import 'package:module3/data.vos/vos/credit_vo.dart';
import 'package:module3/data.vos/vos/genre_vo.dart';
import 'package:retrofit/dio.dart';

import '../data.vos/vos/movie_vo.dart';

abstract class MovieDataAgent{
  Future<List<MovieVO>> getNowPlayingMovies(int page);
  Future<List<MovieVO>> getPopularMovies(int page);
  Future<List<MovieVO>> getTopRatedmovies(int page);
  Future<List<GenreVO>> getGenres();
  Future<List<MovieVO>> getMoviesByGenre(int page);
  Future<List<ActorVO>> getActors(int page);
  Future<MovieVO> getMovieDetails(int movieId);
  Future<List<CreditVO>> getCreditsByMovie(int movieId);


}
