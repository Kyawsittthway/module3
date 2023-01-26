import 'package:hive/hive.dart';

import '../../data.vos/vos/movie_vo.dart';
import '../daos/hive_constants.dart';
import '../daos/movie_dao.dart';

class MovieDaoImpl extends MovieDao{
  static final MovieDaoImpl _singleton = MovieDaoImpl._internal();

  factory MovieDaoImpl(){
    return _singleton;
  }
  MovieDaoImpl._internal();

  void saveMovies(List<MovieVO> movies)async{
    Map<int,MovieVO> movieMap = Map.fromIterable(movies,key:(movie)=>movie.id,value:(movie)=>movie);
    await getMovieBox().putAll(movieMap);
  }

  void saveSingleMovie(MovieVO movie)async{
    return getMovieBox().put(movie.id,movie);
  }

  List<MovieVO>getAllMovies(){
    return getMovieBox().values.toList();
  }

  MovieVO? getMovieById(int movieId){
    return getMovieBox().get(movieId);
  }
  ///Reactive Programming
  Stream<void> getAllMoviesEventStream(){
    return getMovieBox().watch();
  }

  Stream<List<MovieVO>> getNowPlayingMoviesStream(){
    return Stream.value(getAllMovies()
        .where((element)=>element?.isNowPlaying ?? false)
        .toList());
  }

  Stream<List<MovieVO>> getPopularMoviesStream(){
    return Stream.value(getAllMovies()
        .where((element)=>element?.isPopular ?? false)
        .toList());
  }

  Stream<List<MovieVO>> getTopRatedMoviesStream(){
    return Stream.value(getAllMovies()
        .where((element)=>element?.isTopRated ?? false)
        .toList());
  }

  List<MovieVO> getNowPlayingMovies(){
    if(getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)){
      return getAllMovies()
          .where((element)=>element?.isNowPlaying ?? false)
          .toList();
    }else{
      return [];
    }
  }

  List<MovieVO> getPopularMovies(){
    if(getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)){
      return getAllMovies()
          .where((element)=>element?.isPopular ?? false)
          .toList();
    }else{
      return [];
    }
  }

  List<MovieVO> getTopRatedMovies(){
    if(getAllMovies() != null && (getAllMovies().isNotEmpty ?? false)){
      return getAllMovies()
          .where((element)=>element?.isTopRated ?? false)
          .toList();
    }else{
      return [];
    }
  }
  Box<MovieVO> getMovieBox(){
    return Hive.box<MovieVO>(BOX_NAME_MOVIE_VO);
  }
}