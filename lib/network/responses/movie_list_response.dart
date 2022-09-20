

import 'package:json_annotation/json_annotation.dart';

import '../../data.vos/vos/date_vo.dart';
import '../../data.vos/vos/movie_vo.dart';

part 'movie_list_response.g.dart';


@JsonSerializable()
class MovieListResponse{

  @JsonKey(name:"dates")
  DateVO? dates;

  @JsonKey(name:"page")
  int page;

  @JsonKey(name:"results")
   List<MovieVO>results;

  MovieListResponse({  this.dates, required this.page, required this.results});

  factory MovieListResponse.fromJson(Map<String,dynamic>json)=> _$MovieListResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$MovieListResponseToJson(this);
}