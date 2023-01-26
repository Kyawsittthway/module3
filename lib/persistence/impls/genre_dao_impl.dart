import 'package:hive/hive.dart';

import '../../data.vos/vos/genre_vo.dart';
import '../daos/genre_dao.dart';
import '../daos/hive_constants.dart';

class GenreDaoImpl extends GenreDao{
  static final GenreDaoImpl _singleton = GenreDaoImpl._internal();

  factory GenreDaoImpl(){
    return _singleton;
  }

  GenreDaoImpl._internal();

  void saveAllGenres(List<GenreVO>genreList) async{
    Map<int,GenreVO> genreMap = Map.fromIterable(genreList,key:(genre)=>genre.id,value:(genre)=>genre);
    await getGenreBox().putAll(genreMap);
  }

  List<GenreVO> getAllGenres(){
    return getGenreBox().values.toList();
  }

  Box<GenreVO>getGenreBox(){
    return Hive.box<GenreVO>(BOX_NAME_GENRE_VO);
  }
}