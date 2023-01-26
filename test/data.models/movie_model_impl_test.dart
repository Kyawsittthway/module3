import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:module3/data.vos/models/movie_model_impl.dart';
import 'package:module3/data.vos/vos/movie_vo.dart';
import 'package:module3/network/dio_movie_data_agent_impl.dart';
import 'package:module3/network/movie_data_agent.dart';
import 'package:module3/persistence/impls/movie_dao_impl.dart';

import '../mock_data/mock_data.dart';
import '../network/movie_data_agent_impl_mock.dart';
import '../persistence/actor_dao_impl_mock.dart';
import '../persistence/genre_dao_impl_mock.dart';
import '../persistence/movie_dao_impl_mock.dart';

void main() {
  group("movie_model_impl", () {
    var movieModel = MovieModelImpl();

    setUp(() {
      movieModel.setDaoAndDataAgents(MovieDaoImplMock(), ActorDaoImplMock(),
          GenreDaoImplMock(), MockDataAgentImplMock());
    });

    test(
        "Saving Now Playing Movies and Getting now playing movies from database",
            () {
          expect(
              movieModel.getNowPlayingMoviesFromDatabase(),
              emits(
                [
                  MovieVO(
                      false,
                      "/mqsPyyeDCBAghXyjbw4TfEYwljw.jpg",
                      [10752, 18, 28],
                      null,
                      null,
                      null,
                      "",
                      49046,
                      null,
                      "de",
                      "Im Westen nichts Neues スーパーヒーロー",
                      "Paul Baumer and his friends Albert and Muller, egged on by romantic dreams of heroism, voluntarily enlist in the German army. Full of excitement and patriotic fervour, the boys enthusiastically march into a war they believe in. But once on the Western Front, they discover the soul-destroying horror of World War I.",
                      2467.37,
                      "/hYqOjJ7Gh1fbqXrxlIao1g8ZehF.jpg",
                      null,
                      null,
                      null,
                      null,
                      null,
                      null,
                      null,
                      "2022-10-07",
                      "All Quiet on the Western Front",
                      false,
                      7.9,
                      637,
                      true,
                      false,
                      false),
                ],
              ));
        });

    test("Saving Popular Movies and Getting Popular Movies", () {
      expect(
        movieModel.getPopularMoviesFromDatabase(),
        emits(
          [
            MovieVO(
                false,
                "/7ABsaBkO1jA2psC8Hy4IDhkID4h.jpg",
                [16, 878, 28],
                null,
                null,
                null,
                "",
                19995,
                null,
                "en",
                "Avatar",
                "In the 22nd century, a paraplegic Marine is dispatched to the moon Pandora on a unique mission, but becomes torn between following orders and protecting an alien civilization.",
                639.348,
                "/jRXYjXNq0Cs2TcJjLkki24MLp7u.jpg",
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                "2009-12-15",
                "Avatar",
                false,
                7.528,
                26503,
                false,
                true,
                false)

          ],
        ),
      );
    });

    test("Saving Top Rated Movies and Getting TopRated Movies", () {
      expect(
        movieModel.getTopRatedMoviesFromDatabase(),
        emits(
          [
            MovieVO(
                false,
                "/ugS5FVfCI3RV0ZwZtBV3HAV75OX.jpg",
                [16, 878, 28],
                null,
                null,
                null,
                "",
                610150,
                null,
                "ja",
                "ドラゴンボール超 スーパーヒーロー",
                "The Red Ribbon Army, an evil organization that was once destroyed by Goku in the past, has been reformed by a group of people who have created new and mightier Androids, Gamma 1 and Gamma 2, and seek vengeance against Goku and his family.",
                749.799,
                "/rugyJdeoJm7cSJL1q4jBpTNbxyU.jpg",
                null,
                null,
                null,
                null,
                null,
                null,
                null,
                "2022-06-11",
                "Dragon Ball Super: Super Hero",
                false,
                8.0,
                2009,
                false,
                false,
                true)

          ],
        ),
      );
    });


    test("Get Genres", () {
      expect(movieModel.getGenres(), completion(equals(getMockGenres()),));
    });

    test("Get Actors Test", () {
      expect(
          movieModel.getActors(1),
          completion(
            equals(getMockActors()),
          ));
    });

    test("Get Credit Test", () {
      expect(
        movieModel.getCreditsByMovie(1),
        completion(
          equals(getMockCredit()))
      );

    });

    test("Get Movie Detail Test",(){
      expect(movieModel.getMovieDetails(1),
      completion(
      equals(getMockMoviesForTest().first),
      ),);
    });

    test("Get Actors From Database test", () async{
      await movieModel.getActors(1);
      expect(
        movieModel.getAllActorsFromDatabase(),
        completion(equals(getMockActors()),)
      );
    });

    test("Get Movie Detail from Database Test", () async {
      await movieModel.getMovieDetails(1);
      expect(movieModel.getMovieDetails(1),
      completion(
        equals(getMockMoviesForTest().first),
      ));
    });

    test("Get Genres From Database Test ", () async{
      await movieModel.getGenres();
      expect(
        movieModel.getGenresFromDatabase(),
        completion(equals(getMockGenres()))
      );
    });
  });
}
