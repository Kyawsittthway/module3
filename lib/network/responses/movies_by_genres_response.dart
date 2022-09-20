


import 'package:json_annotation/json_annotation.dart';

import '../../data.vos/vos/movie_vo.dart';

part 'movies_by_genres_response.g.dart';

@JsonSerializable()
class GetMoviesByGenreResponse{
  @JsonKey(name:'items')
  List<MovieVO>items;

  GetMoviesByGenreResponse({required this.items});

  factory GetMoviesByGenreResponse.fromJson(Map<String,dynamic>json)=>_$GetMoviesByGenreResponseFromJson(json);

  Map<String,dynamic> toJson()=>_$GetMoviesByGenreResponseToJson(this);
}