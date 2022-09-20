// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_by_genres_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetMoviesByGenreResponse _$GetMoviesByGenreResponseFromJson(
        Map<String, dynamic> json) =>
    GetMoviesByGenreResponse(
      items: (json['items'] as List<dynamic>)
          .map((e) => MovieVO.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetMoviesByGenreResponseToJson(
        GetMoviesByGenreResponse instance) =>
    <String, dynamic>{
      'items': instance.items,
    };
