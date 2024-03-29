import 'package:module3/data.vos/models/movie_model.dart';
import 'package:module3/data.vos/vos/actor_vo.dart';
import 'package:module3/data.vos/vos/credit_vo.dart';
import 'package:module3/data.vos/vos/genre_vo.dart';
import 'package:module3/data.vos/vos/movie_vo.dart';

import '../mock_data/mock_data.dart';

class MovieModelImplMock extends MovieModel{
  @override
  Future<List<ActorVO>> getActors(int page) {
    return Future.value(getMockActors());
  }

  @override
  Future<List<ActorVO>> getAllActorsFromDatabase() {
    return Future.value(getMockActors());
  }

  @override
  Future<List<CreditVO>> getCreditsByMovie(int movieId) {
    return Future.value(getMockCredit());
  }

  @override
  Future<List<GenreVO>> getGenres() {
    return Future.value(getMockGenres());
  }

  @override
  Future<List<GenreVO>> getGenresFromDatabase() {
    return Future.value(getMockGenres());
  }

  @override
  Future<MovieVO> getMovieDetails(int movieId) {
    return Future.value(getMockMoviesForTest().first);
  }

  @override
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId) {
    return Future.value(getMockMoviesForTest().first);
  }

  @override
  Future<List<MovieVO>> getMoviesByGenre(int genreId) {
    if(genreId == 3){
      return Future.value([getMockMoviesForTest().last]);
    }else{
      return Future.value([getMockMoviesForTest().first]);
    }
  }

  @override
  void getNowPlayingMovies(int page) {
    // No Need
  }

  @override
  Stream<List<MovieVO>> getNowPlayingMoviesFromDatabase() {
    return Stream.value(getMockMoviesForTest()
    .where((element)=>element?.isNowPlaying ?? false)
    .toList());
  }

  @override
  void getPopularMovies(int page) {
    // No Need
  }

  @override
  Stream<List<MovieVO>> getPopularMoviesFromDatabase() {
    return Stream.value(getMockMoviesForTest()
        .where((element)=>element?.isPopular ?? false)
        .toList());
  }

  @override
  void getTopRatedMovies(int page) {
    // No Need
  }

  @override
  Stream<List<MovieVO>> getTopRatedMoviesFromDatabase() {
        return Stream.value(getMockMoviesForTest()
        .where((element)=>element?.isTopRated ?? false)
    .toList());
  }
  
}