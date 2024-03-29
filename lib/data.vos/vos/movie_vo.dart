import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:module3/data.vos/vos/production_company_vo.dart';
import 'package:module3/data.vos/vos/production_country_vo.dart';
import 'package:module3/data.vos/vos/spoken_language_vo.dart';
import 'package:module3/persistence/daos/hive_constants.dart';

import 'collection_vo.dart';
import 'genre_vo.dart';

part 'movie_vo.g.dart';

@JsonSerializable()
@HiveType(typeId: HIVE_TYPE_ID_MOVIE_VO,adapterName: "MovieVOAdapter")
class MovieVO extends Equatable{

  @JsonKey(name:"adult")
  @HiveField(0)
  bool adult;

  @JsonKey(name:"backdrop_path")
  @HiveField(1)
  String backDropPath;

  @JsonKey(name:"genre_ids")
  @HiveField(2)
  List<int>? genreIds;

  @JsonKey(name:"belongs_to_collection")
  @HiveField(3)
  CollectionVO? belongToCollection;

  @JsonKey(name:"budget")
  @HiveField(4)
  double? budget;

  @JsonKey(name:"genres")
  @HiveField(5)
  List<GenreVO>? genres;

  @JsonKey(name: "homepage")
  @HiveField(6)
  String homepage;

  @JsonKey(name:"id")
  @HiveField(7)
  int id;

  @JsonKey(name:"imdb_id")
  @HiveField(8)
  String? imdbId;

  @JsonKey(name:"original_language")
  @HiveField(9)
  String originalLanguage;

  @JsonKey(name:"original_title")
  @HiveField(10)
  String originalTitle;

  @JsonKey(name:"overview")
  @HiveField(11)
  String overview;

  @JsonKey(name:"popularity")
  @HiveField(12)
  double? popularity;

  @JsonKey(name:"poster_path")
  @HiveField(13)
  String posterPath;

  @JsonKey(name:"production_companies")
  @HiveField(14)
  List<ProductionCompanyVO>? productionCompanies;

  @JsonKey(name:"production_countries")
  @HiveField(15)
  List<ProductionCountryVO>? productionCountries;

  @JsonKey(name:"revenue")
  @HiveField(16)
  int? revenue;

  @JsonKey(name:"runtime")
  @HiveField(17)
  int? runtTime;

  @JsonKey(name:"spoken_languages")
  @HiveField(18)
  List<SpokenLanguageVO>? spokenLanguages;

  @JsonKey(name:"status")
  @HiveField(19)
  String? status;

  @JsonKey(name:"tagline")
  @HiveField(20)
  String? tagLine;

  @JsonKey(name:"release_date")
  @HiveField(21)
  String releaseDate;

  @JsonKey(name:"title")
  @HiveField(22)
  String title;

  @JsonKey(name:"video")
  @HiveField(23)
  bool video;

  @JsonKey(name:"vote_average")
  @HiveField(24)
  double voteAverage;

  @JsonKey(name:"vote_count")
  @HiveField(25)
  int voteCount;

  @HiveField(26)
  bool isNowPlaying;

  @HiveField(27)
  bool isPopular;

  @HiveField(28)
  bool isTopRated;


  factory MovieVO.fromJson(Map<String,dynamic>json) => _$MovieVOFromJson(json);

  Map<String,dynamic>toJson()=>_$MovieVOToJson(this);

  @override
  String toString() {
    return 'MovieVO{adult: $adult, backDropPath: $backDropPath, genreIds: $genreIds, id: $id, originalLanguage: $originalLanguage, originalTitle: $originalTitle, overview: $overview, popularity: $popularity, posterPath: $posterPath, releaseDate: $releaseDate, title: $title, video: $video, voteAverage: $voteAverage, voteCount: $voteCount}';
  }

  MovieVO(
      this.adult,
      this.backDropPath,
      this.genreIds,
      this.belongToCollection,
      this.budget,
      this.genres,
      this.homepage,
      this.id,
      this.imdbId,
      this.originalLanguage,
      this.originalTitle,
      this.overview,
      this.popularity,
      this.posterPath,
      this.productionCompanies,
      this.productionCountries,
      this.revenue,
      this.runtTime,
      this.spokenLanguages,
      this.status,
      this.tagLine,
      this.releaseDate,
      this.title,
      this.video,
      this.voteAverage,
      this.voteCount,
      this.isNowPlaying,
      this.isPopular,
      this.isTopRated);

  @override
  // TODO: implement props
  List<Object?> get props =>[
    adult,
    backDropPath,
    genreIds,
    belongToCollection,
    budget,
    genres,
    homepage,
    id,
    imdbId,
    originalLanguage,
    originalTitle,
    overview,
    popularity,
    posterPath,
    productionCompanies,
    productionCountries,
    revenue,
    runtTime,
    spokenLanguages,
    status,
    tagLine,
    releaseDate,
    title,
    video,
    voteAverage,
    voteCount,
    isNowPlaying,
    isPopular,
    isTopRated
  ];



}

