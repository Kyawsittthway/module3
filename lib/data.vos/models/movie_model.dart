import '../vos/actor_vo.dart';
import '../vos/credit_vo.dart';
import '../vos/genre_vo.dart';
import '../vos/movie_vo.dart';

abstract class MovieModel{
  Future<List<MovieVO>>getNowPlayingMovies(int page);
  Future<List<GenreVO>> getGenres();
  Future<List<MovieVO>> getPopularMovies(int page);
  Future<List<MovieVO>> getTopRatedMovies(int page);
  Future<List<MovieVO>> getMoviesByGenre(int genreId);
  Future<List<ActorVO>> getActors(int page);
  Future<MovieVO> getMovieDetails(int movieId);
  Future<List<CreditVO>> getCreditsByMovie(int movieId);
}