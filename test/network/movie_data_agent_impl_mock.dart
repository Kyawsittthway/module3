import 'package:module3/data.vos/vos/actor_vo.dart';
import 'package:module3/data.vos/vos/credit_vo.dart';
import 'package:module3/data.vos/vos/genre_vo.dart';
import 'package:module3/data.vos/vos/movie_vo.dart';
import 'package:module3/network/movie_data_agent.dart';

import '../mock_data/mock_data.dart';

class MockDataAgentImplMock extends MovieDataAgent{
  @override
  Future<List<ActorVO>> getActors(int page) {
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
  Future<MovieVO> getMovieDetails(int movieId) {
    return Future.value(getMockMoviesForTest().first);
  }

  @override
  Future<MovieVO> getMovieDetailsFromDatabase(int movieId) {
    print("this thing is called");
    return Future.value(getMockMoviesForTest().first);
  }

  @override
  Future<List<MovieVO>> getMoviesByGenre(int page) {
    return Future.value(getMockMoviesForTest());
  }

  @override
  Future<List<MovieVO>> getNowPlayingMovies(int page) {
    return Future.value(getMockMoviesForTest().where((element) => element.isNowPlaying ?? false).toList());
  }

  @override
  Future<List<MovieVO>> getPopularMovies(int page) {
    return Future.value(getMockMoviesForTest().where((element) => element.isPopular ?? false).toList());
  }

  @override
  Future<List<MovieVO>> getTopRatedmovies(int page) {
    return Future.value(getMockMoviesForTest().where((element) => element.isTopRated ?? false).toList());
  }

}