import 'package:flutter/cupertino.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module3/blocs/home_bloc.dart';

import '../data.models/movie_model_impl_mock.dart';
import '../mock_data/mock_data.dart';

void main(){
  group("Home Bloc Test",(){
    HomeBloc? homeBloc;

    setUp((){
      homeBloc = HomeBloc(MovieModelImplMock());
    });

    test("Fetch Now Playing Movies Test",(){
      expect(
        homeBloc?.mNowPlayingMovieList?.contains(getMockMoviesForTest().last),
        true
      );
    });

    test("Fetch Popular Movies Test",(){
      expect(
        homeBloc?.mPopularMoviesList?.contains(getMockMoviesForTest()[1]),
        true
      );
    });

    test("Fetch Top Rated Movies Test",(){
      expect(
          homeBloc?.mShowCaseMovieList?.contains(getMockMoviesForTest().first),
          true
      );
    });

    test("Fetch Genre Test",(){
      expect(
          homeBloc?.mGenreList?.contains(getMockGenres().first),
          true
      );
    });

    test("Fetch Initial Movies by Genres Test",() async{
      await Future.delayed(Duration(milliseconds: 500));
      expect(
          homeBloc?.mMoviesByGenreList?.contains(getMockMoviesForTest().first),
          true
      );
    });

    test("Fetch Actor Test",(){
      expect(
          homeBloc?.mActors?.contains(getMockActors().first),
          true
      );
    });

    test("Fetch Movie By Genre From User",() async{
      homeBloc?.getMoviesByGenreAndRefresh(3);
      await Future.delayed(Duration(milliseconds:500));
      expect(
          homeBloc?.mMoviesByGenreList?.contains(getMockMoviesForTest().last),
          true
      );
    });
  });
}