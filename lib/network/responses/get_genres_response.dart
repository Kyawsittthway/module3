

import 'package:json_annotation/json_annotation.dart';

import '../../data.vos/vos/genre_vo.dart';

part 'get_genres_response.g.dart';

@JsonSerializable()
class GetGenresResponse{
  @JsonKey(name:'genres')
  List<GenreVO>genres;

  GetGenresResponse({required this.genres});

  factory GetGenresResponse.fromJson(Map<String,dynamic>json)=>_$GetGenresResponseFromJson(json);

  Map<String,dynamic>toJson()=>_$GetGenresResponseToJson(this);
}