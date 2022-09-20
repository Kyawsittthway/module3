import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:module3/network/movie_data_agent.dart';
import 'package:http/http.dart' as http;
import 'api_constants.dart';

class DioMovieDataAgentImpl {
  @override
  void getNowPlayingMovies(int page) {
    Map<String, String> queryParameters = {
      PARAM_API_KEY: API_KEY,
      PARAM_LANGUAGE: LANGUAGE_EN_US,
      PARAM_PAGE: page.toString()
    };

    Dio()
        .get("$BASE_URL_DIO$ENDPOINT_GET_NOW_PLAYING",
            queryParameters: queryParameters)
        .then((value) {
      debugPrint("Now Playing Movies =======> ${value.toString()}");
    }).catchError((error) {
      debugPrint("Error========>${error.toString()}");
    });
  }
}
