import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:module3/data.vos/vos/genre_vo.dart';
import 'package:module3/network/api_constants.dart';
import 'package:module3/network/movie_data_agent.dart';
import 'package:module3/network/the_movie_api.dart';
import 'package:retrofit/dio.dart';

import '../data.vos/vos/actor_vo.dart';
import '../data.vos/vos/credit_vo.dart';
import '../data.vos/vos/movie_vo.dart';

class RetrofitDataAgentImpl extends MovieDataAgent {
  late TheMovieApi mApi;

   static final RetrofitDataAgentImpl _singleton = RetrofitDataAgentImpl._internal();

   factory RetrofitDataAgentImpl(){
     return _singleton;
   }


  RetrofitDataAgentImpl._internal(){
      final dio = Dio();
      mApi = TheMovieApi(dio);

  }
  @override
  Future<List<MovieVO>> getNowPlayingMovies(int page) {
    return mApi
        .getNowPlayingMovies(API_KEY, LANGUAGE_EN_US, page.toString())
         .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>> getTopRatedmovies(int page) {
    return mApi
        .getTopRatedMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<MovieVO>> getPopularMovies(int page) {
    return mApi
        .getPopularMovies(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }

  @override
  Future<List<GenreVO>> getGenres() {
    return mApi
        .getGenres(API_KEY, LANGUAGE_EN_US)
        .asStream()
        .map((response) => response.genres)
        .first;
  }

  @override
  Future<List<MovieVO>> getMoviesByGenre(int genreId){
     return mApi
         .getMoviesByGenre(genreId.toString(), API_KEY, LANGUAGE_EN_US)
         .asStream()
         .map((response) => response.results)
         .first;
  }

  @override
  Future<List<ActorVO>> getActors(int page) {
    return mApi
        .getActors(API_KEY, LANGUAGE_EN_US, page.toString())
        .asStream()
        .map((response) => response.results)
        .first;
  }
  @override
  Future<MovieVO> getMovieDetails(int movieId){
     return mApi
         .getMovieDetails(movieId.toString(), API_KEY, LANGUAGE_EN_US, 1.toString());
  }
  @override
  Future<List<CreditVO>> getCreditsByMovie(int movieId){
    return mApi
        .getCreditsByMovieResponse(movieId.toString(), API_KEY, LANGUAGE_EN_US, 1.toString())
        .asStream()
        .map((response) => response.cast)
        .first;
  }


}
