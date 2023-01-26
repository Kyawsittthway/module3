import 'package:hive/hive.dart';
import 'package:module3/persistence/daos/hive_constants.dart';

import '../../data.vos/vos/movie_vo.dart';

abstract class MovieDao{

  void saveMovies(List<MovieVO> movies);
  void saveSingleMovie(MovieVO movie);
  List<MovieVO>getAllMovies();
  MovieVO? getMovieById(int movieId);
  Stream<void> getAllMoviesEventStream();
  Stream<List<MovieVO>> getNowPlayingMoviesStream();
  Stream<List<MovieVO>> getPopularMoviesStream();
  Stream<List<MovieVO>> getTopRatedMoviesStream();
  List<MovieVO> getNowPlayingMovies();
  List<MovieVO> getPopularMovies();
  List<MovieVO> getTopRatedMovies();

}