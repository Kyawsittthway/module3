import 'package:flutter/cupertino.dart';
import 'package:module3/network/api_constants.dart';
import 'package:module3/network/movie_data_agent.dart';
import 'package:http/http.dart' as http;
class HttpMovieDataAgentImpl{
  @override
  void getNowPlayingMovies(int page) {
  Map<String,String> queryParameters = {
    PARAM_API_KEY:API_KEY,
    PARAM_LANGUAGE:LANGUAGE_EN_US,
    PARAM_PAGE:page.toString()
  };
  var url = Uri.https(BASE_URL, ENDPOINT_GET_NOW_PLAYING,queryParameters);
  http.get(url).then((value){
    debugPrint("Now Playing Movies =======> ${value.body.toString()}");
  }).catchError((error){
    debugPrint("Error========>${error.toString()}");
  });
  }

}