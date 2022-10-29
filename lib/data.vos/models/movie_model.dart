

import 'package:retrofit/dio.dart';
import 'package:scoped_model/scoped_model.dart';

import '../vos/actor_vo.dart';
import '../vos/credit_vo.dart';
import '../vos/genre_vo.dart';
import '../vos/movie_vo.dart';

abstract class MovieModel extends Model{
  // Network
  void getNowPlayingMovies(int page);
  Future<List<GenreVO>> getGenres();
  void getPopularMovies(int page);
  void getTopRatedMovies(int page);
  Future<List<MovieVO>> getMoviesByGenre(int genreId);
  Future<List<ActorVO>> getActors(int page);
  Future<MovieVO> getMovieDetails(int movieId);
  Future<List<CreditVO>> getCreditsByMovie(int movieId);

  // Database
  Future<List<MovieVO>> getTopRatedMoviesFromDatabase();
  Future<List<MovieVO>> getNowPlayingMoviesFromDatabase();
  Future<List<MovieVO>> getPopularMoviesFromDatabase();
  Future<List<GenreVO>> getGenresFromDatabase();
  Future<List<ActorVO>> getAllActorsFromDatabase();
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId);
}